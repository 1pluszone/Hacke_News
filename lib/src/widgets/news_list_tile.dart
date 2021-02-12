import 'package:flutter/material.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/widgets/loading_list_tile.dart';
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
          return LoadingListTile();
        }
        return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (cotext, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingListTile();
              }
              return buildTile(context, itemSnapshot.data);
            });
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.title),
          subtitle: Text("${item.score} votes"),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
        ),
        Divider(
          height: 10.0,
        ),
      ],
    );
  }
}
