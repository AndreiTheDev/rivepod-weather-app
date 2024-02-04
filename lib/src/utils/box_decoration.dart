import 'package:flutter/material.dart';

import 'colors.dart' as colors;

final boxDecoration = BoxDecoration(
  color: colors.primaryColor900,
  borderRadius: BorderRadius.circular(16),
  boxShadow: const <BoxShadow>[
    BoxShadow(
      color: Color(0xFFFFFFFF),
      blurRadius: 8,
      offset: Offset(-7, -7),
    ),
    BoxShadow(
      color: Color(0xFFDDDDDD),
      blurRadius: 13,
      offset: Offset(7, 7),
    ),
  ],
);
