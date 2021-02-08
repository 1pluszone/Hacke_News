import 'dart:async';
import 'news_api.dart';
import 'news_db.dart';

import '../models/item_model.dart';

class Repository {
  NewsDb newsDb = NewsDb();
  NewsApi newsApi = NewsApi();

  Future<List<int>> fetchTopIds() {
    return newsApi.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await newsDb.fetchItem(id);
    if (item != null) {
      return item;
    }
    item = await newsApi.fetchItem(id);
    newsDb.addItem(item);

    return item;
  }
}
