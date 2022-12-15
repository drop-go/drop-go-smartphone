import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:drop_go_smartphone/model/item/item_model.dart';
import 'package:drop_go_smartphone/config/constants.dart' as constants;

final itemRepositoryProvider =
    Provider.autoDispose<ItemRepository>((ref) => ItemRepositoryImpl());

abstract class ItemRepository {
  Future<List<ItemModel>> fetchItems(String id);
}

class ItemRepositoryImpl implements ItemRepository {
  @override
  Future<List<ItemModel>> fetchItems(String id) async {
    List<ItemModel> items = [];
    final url = Uri.parse("${constants.baseURL}/event/$id/item");

    final res = await http.get(url);
    if (res.statusCode != 200) {
      return items;
    }

    final List itemMap = jsonDecode(utf8.decode(res.bodyBytes));
    for (var item in itemMap) {
      items.add(ItemModel.fromJson(item));
    }

    return items;
  }
}
