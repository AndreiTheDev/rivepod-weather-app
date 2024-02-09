const admin = require("firebase-admin");
const logger = require("firebase-functions/logger");
const functions = require("firebase-functions");

admin.initializeApp();

// .runWith({ enforceAppCheck: true })
exports.addFriend = functions.region("europe-west1").https.onCall((request) => {
  logger.info(request);
  const { currentUser, friend } = request;
  logger.info(currentUser);
  logger.info(friend);
  const defaultFirestore = admin.firestore();
  var batch = defaultFirestore.batch();
  var userFriendsDoc = defaultFirestore
    .collection("users")
    .doc(currentUser.uid)
    .collection("user_friends")
    .doc(friend.uid);
  batch.set(userFriendsDoc, friend);
  var friendRequestsDoc = defaultFirestore
    .collection("users")
    .doc(friend.uid)
    .collection("user_friends_requests")
    .doc(currentUser.uid);
  batch.set(friendRequestsDoc, currentUser);
  batch.commit();

  const receiver = admin
    .firestore()
    .collection("users")
    .doc(friend.uid)
    .get()
    .then((response) => {
      const payload = {
        token: response.data().fcmToken,
        notification: {
          title: `${currentUser.username} sent you a friend request`,
          body: "Don't let your new friend wait. Accept his request now.",
        },
        data: {
          body: "Don't let your new friend wait. Accept his request now.",
        },
      };
      admin
        .messaging()
        .send(payload)
        .then((response) => {
          logger.info("sent message");
        })
        .catch((error) => {
          logger.error(error);
        });
    });

  return;
});

// .runWith({ enforceAppCheck: true })
exports.deleteFriend = functions
  .region("europe-west1")
  .https.onCall((request) => {
    logger.info(request);
    const { currentUser, friend } = request;
    logger.info(currentUser);
    logger.info(friend);
    const defaultFirestore = admin.firestore();
    var batch = defaultFirestore.batch();
    var userFriendsDoc = defaultFirestore
      .collection("users")
      .doc(currentUser.uid)
      .collection("user_friends")
      .doc(friend.uid);
    batch.delete(userFriendsDoc);
    var friendUsersDoc = defaultFirestore
      .collection("users")
      .doc(friend.uid)
      .collection("user_friends")
      .doc(currentUser.uid);
    batch.delete(friendUsersDoc);
    var firendRequestsDoc = defaultFirestore
      .collection("users")
      .doc(friend.uid)
      .collection("user_friends_requests")
      .doc(currentUser.uid);
    batch.delete(firendRequestsDoc);
    batch.commit();

    return;
  });

// .runWith({ enforceAppCheck: true })
exports.rejectFriend = functions
  .region("europe-west1")
  .https.onCall((request) => {
    logger.info(request);
    const { currentUser, friend } = request;
    logger.info(currentUser);
    logger.info(friend);
    const defaultFirestore = admin.firestore();
    var batch = defaultFirestore.batch();
    var friendUsersDoc = defaultFirestore
      .collection("users")
      .doc(friend.uid)
      .collection("user_friends")
      .doc(currentUser.uid);
    batch.delete(friendUsersDoc);
    var firendRequestsDoc = defaultFirestore
      .collection("users")
      .doc(currentUser.uid)
      .collection("user_friends_requests")
      .doc(friend.uid);
    batch.delete(firendRequestsDoc);
    batch.commit();

    return;
  });
