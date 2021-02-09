import 'package:flutter/material.dart';
import 'package:hacker_news/src/widgets/news_list_tile.dart';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
        stream: bloc.topIds,
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData) {
            return Center(child: Text("wahala be like bicycle"));
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                bloc.fetchItem(snapshot.data[index]);
                return NewsListTile(itemId: snapshot.data[index]);
              });
        });
  }
}
