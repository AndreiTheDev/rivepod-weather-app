//codes

//App
const String unknownErrorCode = 'unknown-error';
const String nullUserCode = 'null-user';

//Firebase
const String noUserDataCode = 'no-user-data';
const String userNotExistsCode = 'user-not-exists';
const String emailExists = 'email-already-exists';
const String internalError = 'internal-error';
const String invalidCredential = 'invalid-credential';
const String invalidPassword = 'invalid-password';
const String userDisabled = 'user-disabled';
const String userNotFound = 'user-not-found';
const String wrongPassword = 'wrong-password';
const String userCancel = 'user-cancel';

//Dio
const String connectionTimeoutCode = 'dio-connection-timeout';
const String sendTimeoutCode = 'dio-send-timeout';
const String receiveTimeoutCode = 'dio-receive-timeout';
const String badCertificateCode = 'dio-bad-certificate';
const String badResponseCode = 'dio-bad-response';
const String cancelCode = 'dio-cancel';
const String connectionErrorCode = 'dio-connection-error';

//messages

//App
const String unknownErrorMessage = 'An unknown error occured.';
const String nullUserMessage = 'The user instance is null';

//Firebase
const String noUserDataMessage = 'Unable to get user data.';
const String userNotExistsMessage = 'The user does not exist in database.';
const String emailExistsMessage = 'Email is already in use.';
const String internalErrorMessage =
    'The server encountered an error. Please try again later.';
const String invalidCredentialMessage = 'The provided credential is invalid.';
const String invalidPasswordMessage = 'The provided password is invalid.';
const String userDisabledMessage = 'Your account has been disabled.';
const String userNotFoundMessage = 'There is no user associated to this email.';
const String wrongPasswordMessage = 'The provided password is invalid.';

//Dio
const String connectionTimeoutMessage =
    'It took too long to establish server connection.';
const String sendTimeoutMessage = 'It took too long for the server to respond.';
const String receiveTimeoutMessage = 'It took too long to show the data.';
const String badCertificateMessage =
    'The server was not able to establish a valid connection.';
const String badResponseMessage = 'Unable to fetch the weather.';
const String cancelMessage = 'The call to the server has been canceled.';
const String connectionErrorMessage = 'No internet connection.';
