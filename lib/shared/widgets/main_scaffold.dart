import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  DateTime? _lastExitAttemptAt;

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/tasks')) return 1;
    if (location.startsWith('/logs')) return 2;
    if (location.startsWith('/envs')) return 3;
    if (location.startsWith('/more')) return 4;
    return 0;
  }

  Future<void> _handleBackPress(bool didPop) async {
    if (didPop) {
      return;
    }

    final now = DateTime.now();
    if (_lastExitAttemptAt == null ||
        now.difference(_lastExitAttemptAt!) > const Duration(seconds: 5)) {
      _lastExitAttemptAt = now;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('5秒内再按一次返回键退出应用'),
            duration: Duration(seconds: 5),
          ),
        );
      return;
    }

    await SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final idx = _currentIndex(context);

    return PopScope<void>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _handleBackPress(didPop),
      child: Scaffold(
        body: widget.child,
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 12,
            left: 16,
            right: 16,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: isLight
                      ? Colors.white.withAlpha(180)
                      : AppColors.slate900.withAlpha(180),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isLight
                        ? Colors.white.withAlpha(160)
                        : AppColors.slate700.withAlpha(120),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isLight
                          ? AppColors.slate900.withAlpha(25)
                          : Colors.black.withAlpha(80),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        _NavItem(
                          icon: Icons.space_dashboard_outlined,
                          activeIcon: Icons.space_dashboard,
                          label: '主页',
                          isActive: idx == 0,
                          onTap: () => context.go('/dashboard'),
                        ),
                        _NavItem(
                          icon: Icons.schedule_outlined,
                          activeIcon: Icons.schedule,
                          label: '任务',
                          isActive: idx == 1,
                          onTap: () => context.go('/tasks'),
                        ),
                        _NavItem(
                          icon: Icons.terminal_outlined,
                          activeIcon: Icons.terminal,
                          label: '日志',
                          isActive: idx == 2,
                          onTap: () => context.go('/logs'),
                        ),
                        _NavItem(
                          icon: Icons.key_outlined,
                          activeIcon: Icons.key,
                          label: '变量',
                          isActive: idx == 3,
                          onTap: () => context.go('/envs'),
                        ),
                        _NavItem(
                          icon: Icons.menu_outlined,
                          activeIcon: Icons.menu,
                          label: '更多',
                          isActive: idx == 4,
                          onTap: () => context.go('/more'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.slate400;
    final bgColor = isActive
        ? AppColors.primary.withAlpha(20)
        : Colors.transparent;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isActive ? activeIcon : icon, size: 22, color: color),
                const SizedBox(height: 2),
                SizedBox(
                  height: 12,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 11,
                        color: color,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
