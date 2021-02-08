import 'package:hacker_news/src/resources/news_api.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchtopIds returns a list of ids', () async {
//setup of test case
    final newsApi = NewsApi();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();
//expectation
    expect(ids, [1, 2, 3, 4]);
  });

  test('fetchItem returns an instance of an item model', () async {
    final newsApi = NewsApi();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}
