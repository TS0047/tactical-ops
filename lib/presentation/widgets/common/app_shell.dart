import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routing/route_names.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      body: child,
      bottomNavigationBar: _TacticalNavBar(currentLocation: location),
    );
  }
}

class _TacticalNavBar extends StatelessWidget {
  const _TacticalNavBar({required this.currentLocation});

  final String currentLocation;

  int _indexForLocation(String loc) {
    if (loc.startsWith(Routes.tasks)) return 1;
    if (loc == Routes.matrix) return 2;
    if (loc == Routes.briefing || loc == Routes.debrief) return 3;
    if (loc.startsWith(Routes.opsLog) || loc.startsWith('/debrief/')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Routes.dashboard);
      case 1:
        context.go(Routes.tasks);
      case 2:
        context.go(Routes.matrix);
      case 3:
        final hour = DateTime.now().hour;
        context.go(hour < 14 ? Routes.briefing : Routes.debrief);
      case 4:
        context.go(Routes.opsLog);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = _indexForLocation(currentLocation);

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: selected,
        onTap: (i) => _onTap(context, i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: AppStrings.navSitrep,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_outlined),
            activeIcon: Icon(Icons.checklist),
            label: AppStrings.navObjectives,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'MATRIX',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.military_tech_outlined),
            activeIcon: Icon(Icons.military_tech),
            label: AppStrings.navOps,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: AppStrings.navLog,
          ),
        ],
      ),
    );
  }
}
