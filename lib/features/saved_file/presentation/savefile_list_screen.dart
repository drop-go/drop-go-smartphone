// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animations/animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:drop_go_smartphone/common_widgets/common_loading.dart';
import 'package:drop_go_smartphone/features/providers.dart';
import 'package:drop_go_smartphone/features/saved_file/presentation/preview_screen/image_preview.dart';
import 'package:drop_go_smartphone/features/saved_file/presentation/preview_screen/other_preview.dart';
import 'package:drop_go_smartphone/features/saved_file/presentation/preview_screen/video_preview.dart';
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
          "アイテム一覧",
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
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: fileList.length,
      itemBuilder: (context, index) {
        final file = fileList[index];
        if (file['extension'].toString() == 'link') {
          final url = Uri.parse(file['url'].toString());
          return InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: const Text('注意'),
                  content: const Text('外部ブラウザが起動します'),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'キャンセル',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async => await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4069FF),
                      ),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _ifIcon(file),
                    const SizedBox(width: 16),
                    _saveFilePart(file),
                  ],
                ),
              ),
            ),
          );
        }
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
                    _ifIcon(file),
                    const SizedBox(width: 16),
                    _saveFilePart(file),
                  ],
                ),
              ),
            );
          },
          openBuilder: (context, action) {
            switch (file['contentType'].toString()) {
              case 'image':
                return ImagePreview(file: file);
              case 'video':
                return VideoPreview(file: file);
              default:
                return const OtherPreview();
            }
          },
        );
      },
    );
  }

  Widget _saveFilePart(Map<String, Object> file) {
    return Flexible(
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
                      file['title'].toString(),
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
    );
  }

  Widget _ifIcon(Map<String, Object> file) {
    final Map<String, Icon> iconList = {
      'image': const Icon(Icons.image, color: Color(0xFF4069FF)),
      'video': const Icon(Icons.video_file, color: Color(0xFF4069FF)),
      'audio': const Icon(Icons.audio_file, color: Color(0xFF4069FF)),
    };
    final contentType = file['contentType'].toString();

    if (iconList.containsKey(contentType)) {
      return iconList[contentType]!;
    } else {
      if (file['extension'].toString() == 'link') {
        return const Icon(
          Icons.travel_explore,
          color: Color(0xFF4069FF),
        );
      }
    }

    return const Icon(
      Icons.file_copy,
      color: Color(0xFF4069FF),
    );
  }
}
