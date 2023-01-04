// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animations/animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:drop_go_smartphone/common_widgets/common_loading.dart';
import 'package:drop_go_smartphone/features/providers.dart';
import 'package:drop_go_smartphone/utils/date_to_string.dart';

class SavefileListScreen extends ConsumerWidget {
  const SavefileListScreen({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => const SavefileListScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(savefileViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "ファイル一覧",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            FilePanel(list: state.fileList),
            CommonLoading(visible: state.isLoading),
          ],
        ),
      ),
    );
  }
}

class FilePanel extends StatelessWidget {
  const FilePanel({super.key, required List<Map<String, Object>> list})
      : fileList = list;

  final List<Map<String, Object>> fileList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ListView.builder(
        itemCount: fileList.length,
        itemBuilder: (context, index) {
          final file = fileList[index];
          return OpenContainer(
            closedElevation: 0,
            transitionType: ContainerTransitionType.fadeThrough,
            transitionDuration: const Duration(milliseconds: 500),
            closedBuilder: (context, action) {
              return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.file_copy,
                        color: Color(0xFF4069FF),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        file['name'].toString(),
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${file['extension']}ファイル",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${dateFormat(file['date'] as DateTime)} - ${file['fileSize']}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            openBuilder: (context, action) {
              switch (file['contentType'].toString()) {
                case 'image':
                  return ImagePreview(saveFile: file);
                default:
                  return OtherPreview(saveFile: file);
              }
            },
          );
        },
      ),
    );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required Map<String, Object> saveFile})
      : file = saveFile;

  final Map<String, Object> file;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Image.file(
                File(file['path'].toString()),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: FloatingActionButton(
                  heroTag: "close",
                  backgroundColor: Colors.white.withOpacity(0.5),
                  elevation: 0,
                  onPressed: () => Navigator.of(context).pop(),
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherPreview extends StatelessWidget {
  const OtherPreview({super.key, required Map<String, Object> saveFile})
      : file = saveFile;

  final Map<String, Object> file;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            const Center(
              child: Text('このファイルはプレビュー対象外です'),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: FloatingActionButton(
                  heroTag: "close",
                  backgroundColor: Colors.white.withOpacity(0.5),
                  elevation: 0,
                  onPressed: () => Navigator.of(context).pop(),
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
