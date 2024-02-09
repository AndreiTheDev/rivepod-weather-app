import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/domain/auth_controller.dart';
import '../features/authentication/presentation/recover_password_view.dart';
import '../features/authentication/presentation/signin_view.dart';
import '../features/authentication/presentation/signup_view.dart';
import '../features/core/friends/presentation/friend_requests_view.dart';
import '../features/core/friends/presentation/friends_view.dart';
import '../features/core/settings/presentation/settings_view.dart';
import '../features/core/weather/presentation/forecast_view.dart';
import '../features/core/weather/presentation/home_view.dart';
import '../features/core/weather/presentation/searches_view.dart';
import '../features/core/weather/presentation/weather_view.dart';
import '../features/core/weather/presentation/widgets/app_scaffold.dart';

final routerProvider = Provider<GoRouter>((final ref) {
  final AuthState authState = ref.watch(
    authControllerProvider
        .select((final authController) => authController.authState),
  );
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  return GoRouter(
    initialLocation: '/',
    navigatorKey: rootNavigatorKey,
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (
          final BuildContext context,
          final GoRouterState state,
          final Widget child,
        ) =>
            AppScaffold(child: child),
        routes: <GoRoute>[
          GoRoute(
            path: '/',
            parentNavigatorKey: shellNavigatorKey,
            routes: <GoRoute>[
              GoRoute(
                path: 'weather',
                pageBuilder:
                    (final BuildContext context, final GoRouterState state) =>
                        const NoTransitionPage<WeatherView>(
                  child: WeatherView(),
                ),
              ),
              GoRoute(
                path: 'forecast',
                pageBuilder:
                    (final BuildContext context, final GoRouterState state) =>
                        const NoTransitionPage<ForecastView>(
                  child: ForecastView(),
                ),
              ),
            ],
            pageBuilder:
                (final BuildContext context, final GoRouterState state) =>
                    const NoTransitionPage<HomeView>(
              child: HomeView(),
            ),
          ),
          GoRoute(
            path: '/friends',
            parentNavigatorKey: shellNavigatorKey,
            pageBuilder:
                (final BuildContext context, final GoRouterState state) =>
                    const NoTransitionPage<FriendsView>(
              child: FriendsView(),
            ),
          ),
          GoRoute(
            path: '/searches',
            parentNavigatorKey: shellNavigatorKey,
            pageBuilder:
                (final BuildContext context, final GoRouterState state) =>
                    const NoTransitionPage<SearchesView>(
              child: SearchesView(),
            ),
          ),
          GoRoute(
            path: '/settings',
            parentNavigatorKey: shellNavigatorKey,
            pageBuilder:
                (final BuildContext context, final GoRouterState state) =>
                    const NoTransitionPage<SettingsView>(
              child: SettingsView(),
            ),
          ),
          GoRoute(
            path: '/friend-requests',
            pageBuilder:
                (final BuildContext context, final GoRouterState state) =>
                    const NoTransitionPage<FriendRequestsView>(
              child: FriendRequestsView(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/signin',
        pageBuilder: (final BuildContext context, final GoRouterState state) =>
            const NoTransitionPage<SignInView>(
          child: SignInView(),
        ),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (final BuildContext context, final GoRouterState state) =>
            const NoTransitionPage<SignUpView>(
          child: SignUpView(),
        ),
      ),
      GoRoute(
        path: '/recover-password',
        pageBuilder: (final BuildContext context, final GoRouterState state) =>
            const NoTransitionPage<RecoverPasswordView>(
          child: RecoverPasswordView(),
        ),
      ),
    ],
    refreshListenable: authState,
    redirect: (final BuildContext context, final GoRouterState state) {
      final bool isSignedIn = authState.authUserState == AuthUserState.signedIn;
      final bool isSigningIn = state.matchedLocation == '/signin';
      final bool isSigningUp = state.matchedLocation == '/signup';
      final bool isRecoverPassword =
          state.matchedLocation == '/recover-password';
      if (!isSignedIn && !isSigningUp && !isRecoverPassword) {
        return isSigningIn ? null : '/signin';
      }
      if (!isSignedIn && !isSigningIn && !isRecoverPassword) {
        return isSigningUp ? null : '/signup';
      }
      if (!isSignedIn && !isSigningIn && !isSigningUp) {
        return isSigningUp ? null : '/recover-password';
      }
      if (isSigningIn || isSigningUp) {
        return '/';
      }
      return null;
    },
  );
});
