import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_provider.dart';
import '../../screens/login_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/dashboard_screen.dart';
import '../../screens/tasks_screen.dart';
import '../../screens/envs_screen.dart';
import '../../screens/dependencies_screen.dart';
import '../../screens/scripts_screen.dart';
import '../../screens/logs_screen.dart';
import '../../screens/subscriptions_screen.dart';
import '../../screens/security_screen.dart';
import '../../screens/settings_screen.dart';
import '../../screens/open_api_screen.dart';
import '../../screens/backup_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// 将 auth status 变化转为 Listenable，供 GoRouter.refreshListenable 使用
class _AuthNotifierBridge extends ChangeNotifier {
  _AuthNotifierBridge(Ref ref) {
    ref.listen<AuthStatus>(
      authProvider.select((s) => s.status),
      (previous, next) => notifyListeners(),
    );
  }
}

final _authNotifierProvider = Provider<_AuthNotifierBridge>((ref) {
  return _AuthNotifierBridge(ref);
});

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(_authNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isAuth = authState.status == AuthStatus.authenticated;
      final isUnknown = authState.status == AuthStatus.unknown;
      final isLoginRoute = state.matchedLocation == '/login';

      if (isUnknown) return null;
      if (!isAuth && !isLoginRoute) return '/login';
      if (isAuth && isLoginRoute) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
      GoRoute(path: '/tasks', builder: (_, __) => const TasksScreen()),
      GoRoute(path: '/envs', builder: (_, __) => const EnvsScreen()),
      GoRoute(path: '/deps', builder: (_, __) => const DependenciesScreen()),
      GoRoute(path: '/scripts', builder: (_, __) => const ScriptsScreen()),
      GoRoute(path: '/logs', builder: (_, __) => const LogsScreen()),
      GoRoute(path: '/subscriptions', builder: (_, __) => const SubscriptionsScreen()),
      GoRoute(path: '/security', builder: (_, __) => const SecurityScreen()),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      GoRoute(path: '/open-api', builder: (_, __) => const OpenApiScreen()),
      GoRoute(path: '/backup', builder: (_, __) => const BackupScreen()),
    ],
  );
});
