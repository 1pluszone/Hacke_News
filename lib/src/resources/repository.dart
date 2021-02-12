import 'dart:async';
import 'news_api.dart';
import 'news_db.dart';

import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDb, //instance of NewsDb()
    NewsApi(),
  ];

  List<Cache> caches = <Cache>[
    newsDb, // same instance of NewsDb()
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds(); //fetch from api only. wire up db later
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clearTable();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clearTable();
}
