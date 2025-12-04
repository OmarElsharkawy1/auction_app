import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/config/router/app_routes.dart';
import 'package:frontend/config/router/go_router_refresh_stream.dart';
import 'package:frontend/core/services/injection_container.dart' as di;
import 'package:frontend/features/auction/presentation/auction_cubit/auction_cubit.dart';
import 'package:frontend/features/auction/presentation/auction_screen.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:frontend/features/auth/presentation/auth_screen.dart';
import 'package:go_router/go_router.dart';

/// Configures the application's router using GoRouter.
///
/// Defines the routes, redirect logic, and refresh listeners for authentication state changes.
class AppRouter {
  /// The GoRouter instance used for navigation.
  static final router = GoRouter(
    initialLocation: AppRoutes.auth,
    routes: [
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.auction,
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<AuctionCubit>(),
          child: const AuctionScreen(),
        ),
      ),
    ],
    redirect: (context, state) {
      final authCubit = di.sl<AuthCubit>();
      final authState = authCubit.state;
      final loggedIn = authState is AuthAuthenticated;
      final loggingIn = state.uri.toString() == AppRoutes.auth;

      if (!loggedIn && !loggingIn) return AppRoutes.auth;
      if (loggedIn && loggingIn) return AppRoutes.auction;
      return null;
    },
    refreshListenable: GoRouterRefreshStream(di.sl<AuthCubit>().stream),
  );
}
