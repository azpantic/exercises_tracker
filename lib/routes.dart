import 'package:flutter/material.dart';
import 'package:flutter_mobile_application_template/subpages/settings_subpage.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'controllers/main_controller.dart';
import 'i18n/strings.g.dart';

import 'pages/calendar_page.dart';
import 'pages/list_page.dart';
import 'pages/settings_page.dart';

final MainController _controller = Get.find();
final _rootNavigationKey = GlobalKey<NavigatorState>();
final _shellNavigationKey = GlobalKey<NavigatorState>();

class _destination {
  late String path;
  late String name;
  late Icon icon;
  late Icon selectedIcon;
}

final _destinations = <_destination>[
  _destination()
    ..path = '/calendar'
    ..name = t.navbar.calendar
    ..icon = const Icon(Icons.calendar_month_outlined)
    ..selectedIcon = const Icon(Icons.calendar_month),
  _destination()
    ..path = '/list'
    ..name = t.navbar.list
    ..icon = const Icon(Icons.list_outlined)
    ..selectedIcon = const Icon(Icons.list),
  _destination()
    ..path = '/settings'
    ..name = t.navbar.settings
    ..icon = const Icon(Icons.settings_outlined)
    ..selectedIcon = const Icon(Icons.settings),
];

final router = GoRouter(
  navigatorKey: _rootNavigationKey,
  initialLocation:'/calendar',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigationKey,
      // ShellRoute показывает UI-оболочку вокруг соответствующего дочернего маршрута
      builder: (context, state, child) {
        // UI-оболочка - это Scaffold с NavigationBar
        return Obx(() => Scaffold(
              bottomNavigationBar: NavigationBar(
                selectedIndex: _controller.page(),
                onDestinationSelected: (index) {
                  _controller.page(index);
                  return context.go(
                    _destinations[index].path,
                  );
                },
                destinations: _destinations
                    .map((e) => NavigationDestination(
                        icon: e.icon,
                        selectedIcon: e.selectedIcon,
                        label: e.name))
                    .toList(),
              ),
              body: child,
            ));
      },
      // Вложенные маршруты для каждой вкладки
      routes: [
        GoRoute(
          path: _destinations[0].path,
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: CalendarPage(),
          ),
          routes: const [],
        ),
        GoRoute(
          path: _destinations[1].path,
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: ListPage(),
          ),
          routes: const [],
        ),
        GoRoute(
          path: _destinations[2].path,
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: SettingsPage(),
          ),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigationKey,
              path: 'theme_setting',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const SettingsSubpage(),
              ),
              routes: const [],
            ),
          ],
        ),
      ],
    ),
  ],
);
