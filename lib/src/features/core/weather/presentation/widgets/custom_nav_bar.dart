import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/colors.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({required this.currentIndex, super.key});

  final int currentIndex;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(final BuildContext context) {
    final bool isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return Container(
      margin: isIos ? const EdgeInsets.fromLTRB(24, 8, 24, 24) : null,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isIos ? BorderRadius.circular(32) : null,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0xFFCFCFCF),
            spreadRadius: 3,
            blurRadius: 15,
          ),
        ],
      ),
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: _NavBarButton(
                icon: Icons.wb_cloudy_outlined,
                label: 'Weather',
                isActive: widget.currentIndex == 0,
                onTap: () => _onTap(0),
              ),
            ),
            Expanded(
              child: _NavBarButton(
                icon: Icons.search,
                label: 'Search',
                isActive: widget.currentIndex == 1,
                onTap: () => _onTap(1),
              ),
            ),
            Expanded(
              child: _NavBarButton(
                icon: Icons.person,
                label: 'Friends',
                isActive: widget.currentIndex == 2,
                onTap: () => _onTap(2),
              ),
            ),
            Expanded(
              child: _NavBarButton(
                icon: Icons.settings,
                label: 'Settings',
                isActive: widget.currentIndex == 3,
                onTap: () => _onTap(3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(final int value) {
    switch (value) {
      case 0:
        return context.go('/');
      case 1:
        return context.go('/searches');
      case 2:
        return context.go('/friends');
      case 3:
        return context.go('/settings');
      default:
        return context.go('/');
    }
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isActive,
    // super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: isActive ? detailColor : null,
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive ? detailColor : null,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
