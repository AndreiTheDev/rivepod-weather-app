import 'package:flutter/material.dart';

import '../../error_handling/logger.dart';

class SearchesView extends StatelessWidget {
  const SearchesView({super.key});

  @override
  Widget build(final BuildContext context) {
    getLogger(SearchesView).d('build');

    return const Center(
      child: Text('searches'),
    );
  }
}
