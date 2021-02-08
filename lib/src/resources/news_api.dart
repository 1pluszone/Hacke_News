import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import '../models/item_model.dart';
import 'repository.dart';

class NewsApi implements Source {
  Client client = Client();

  final String _root = "https://hacker-news.firebaseio.com/v0";

  @override
  Future<List<int>> fetchTopIds() async {
    Response response = await client.get("$_root/topstories.json");
//    final List<int> ids = json.decode(response.body);
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    Response response = await client.get("$_root/item/$id.json");
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
