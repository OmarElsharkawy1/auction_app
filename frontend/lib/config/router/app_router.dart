import 'package:frontend/config/router/go_router_refresh_stream.dart';
import 'package:frontend/core/services/injection_container.dart' as di;
import 'package:frontend/features/auction/presentatiom/auction_screen.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:frontend/features/auth/presentation/auth_cubit/auth_state.dart';
import 'package:frontend/features/auth/presentation/auth_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const AuthScreen()),
      GoRoute(
        path: '/auction',
        builder: (context, state) => const AuctionScreen(),
      ),
    ],
    redirect: (context, state) {
      final authCubit = di.sl<AuthCubit>();
      final authState = authCubit.state;
      final loggedIn = authState is AuthAuthenticated;
      final loggingIn = state.uri.toString() == '/';

      if (!loggedIn && !loggingIn) return '/';
      if (loggedIn && loggingIn) return '/auction';
      return null;
    },
    refreshListenable: GoRouterRefreshStream(di.sl<AuthCubit>().stream),
  );
}
