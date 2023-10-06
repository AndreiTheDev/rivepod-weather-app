import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_nav_bar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: child,
      bottomNavigationBar: CustomNavBar(
        currentIndex: _calculateSelectedIndex(context),
      ),
    );
  }
}

int _calculateSelectedIndex(final BuildContext context) {
  final String route = GoRouterState.of(context).uri.toString();
  if (route == '/') {
    return 0;
  }
  if (route.startsWith('/searches')) {
    return 1;
  }
  if (route.startsWith('/friends')) {
    return 2;
  }
  if (route.startsWith('/settings')) {
    return 3;
  }
  return 0;
}
