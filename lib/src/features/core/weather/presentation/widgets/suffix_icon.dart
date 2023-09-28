import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart' as colors;

class SuffixIcon extends StatelessWidget {
  const SuffixIcon({required this.isActive, required this.onTap, super.key});

  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isActive ? colors.detailColor : const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              if (isActive)
                const BoxShadow(
                  color: colors.detailColor,
                  spreadRadius: -2,
                  blurRadius: 10,
                ),
              if (!isActive)
                const BoxShadow(
                  color: Color(0xFF666666),
                  spreadRadius: -2,
                  blurRadius: 10,
                ),
            ],
          ),
          child: Icon(
            Icons.done,
            color: isActive ? colors.primaryColor900 : colors.secondaryColor,
          ),
        ),
      ),
    );
  }
}
