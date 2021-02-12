import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  final ListView child;
  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc
            .fetchTopIds(); //await so we tell onRefresh to chill until we are done with this call before the refresh indicator goes away
      },
    );
  }
}
