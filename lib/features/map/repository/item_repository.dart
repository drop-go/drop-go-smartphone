// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:drop_go_smartphone/constants/constants.dart' as constants;
import 'package:drop_go_smartphone/features/map/model/file/file_model.dart';
import 'package:drop_go_smartphone/features/map/model/item_model.dart';

final itemRepositoryProvider =
    Provider.autoDispose<ItemRepository>((ref) => ItemRepositoryImpl());

abstract class ItemRepository {
  Future<List<ItemModel>> fetchItems(String id);
  Future<FileModel> fetchFile(String eventId, String itemId);
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

  @override
  Future<FileModel> fetchFile(String eventId, String itemId) async {
    final url =
        Uri.parse("${constants.baseURL}/event/$eventId/item/$itemId/download");
    final res = await http.get(url);
    return FileModel.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
  }
}
