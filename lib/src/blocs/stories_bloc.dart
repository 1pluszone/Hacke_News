import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>(); // similar to StreamController

//getters to streams
  Observable<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (cache, int id, _) {
        // will be invovoked everytime a new item is added to our stream
      },
      <int, Future<ItemModel>>{}, //initial value.. we need it empty
    );
  }

  dispose() {
    _topIds.close();
  }
}
