import 'package:flutter/material.dart';
import 'package:hacker_news/src/models/item_model.dart';
import '../blocs/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  Widget build(context) {
    print("i am here");
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Still Loading");
        }
        return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (cotext, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Text("futrue builder $itemId still loading");
              }
              return Text(itemSnapshot.data.title);
            });
      },
    );
  }
}
