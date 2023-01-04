// Dart imports:
import 'dart:io';
import 'dart:math';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

final savefileRepositoryProvider =
    Provider.autoDispose<SavefileRepository>((ref) => SavefileRepositoryImpl());

abstract class SavefileRepository {
  Future<List<Map<String, Object>>> fetchFiles();
}

class SavefileRepositoryImpl implements SavefileRepository {
  @override
  Future<List<Map<String, Object>>> fetchFiles() async {
    final List<Map<String, Object>> fileMapList = [];

    final path = (await getApplicationDocumentsDirectory()).path;
    final dir = Directory(path);
    final files = dir.listSync();
    for (var file in files) {
      final contentType = lookupMimeType(file.path) ?? '';
      final stat = await file.stat();
      if (stat.type == FileSystemEntityType.directory) {
        continue;
      }
      if (p.extension(file.path).split('.').length != 2) {
        continue;
      }
      final map = {
        'name': p.basenameWithoutExtension(file.path),
        'extension': p.extension(file.path).split('.')[1],
        'fileSize': _convertSizeText(stat.size),
        'date': stat.modified,
        'contentType': contentType.split('/')[0],
        'path': file.path,
      };
      fileMapList.add(map);
    }
    fileMapList.sort(
      (a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime),
    );
    return fileMapList;
  }

  String _convertSizeText(int byte) {
    var sizeText = '';
    if (pow(10, 9) < byte) {
      sizeText = '${(byte / pow(10, 9)).toStringAsFixed(2)} GB';
    } else if (pow(10, 6) < byte) {
      sizeText = '${(byte / pow(10, 6)).toStringAsFixed(2)} MB';
    } else if (pow(10, 3) < byte) {
      sizeText = '${(byte / pow(10, 3)).round()} KB';
    } else {
      sizeText = '$byte B';
    }
    return sizeText;
  }
}
