import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../utils/colors.dart';

class ResultContainerLoading extends StatelessWidget {
  const ResultContainerLoading({super.key});

  @override
  Widget build(final BuildContext context) {
    return Shimmer.fromColors(
      baseColor: loadingColor,
      highlightColor: primaryColor,
      child: Column(
        children: <Widget>[
          Container(
            height: 30,
            width: 140,
            color: loadingColor,
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            height: 24,
            color: loadingColor,
            width: 220,
          ),
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: loadingColor,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36),
            child: Column(
              children: <Widget>[
                Container(
                  height: 24,
                  color: loadingColor,
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: 24,
                  color: loadingColor,
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: 24,
                  color: loadingColor,
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: 24,
                  color: loadingColor,
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: 24,
                  color: loadingColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
