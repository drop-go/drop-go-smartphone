// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:drop_go_smartphone/features/saved_file/model/savefile_state.dart';
import 'package:drop_go_smartphone/features/saved_file/repository/savefile_repository.dart';

class SavefileViewModel extends StateNotifier<SavefileState> {
  SavefileViewModel(this.read) : super(const SavefileState()) {
    _init();
  }

  final read;

  Future<void> _init() async {
    final saveFileRepository = read(savefileRepositoryProvider);
    try {
      if (!mounted) {
        return;
      }
      state = state.copyWith(isLoading: true);
      final savefileList = await saveFileRepository.fetchFiles();

      if (!mounted) {
        return;
      }
      state = state.copyWith(fileList: savefileList);
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }
      state = state.copyWith(errorMessage: e.toString());
    }
    if (!mounted) {
      return;
    }
    state = state.copyWith(isLoading: false);
  }

  String getUrl(String path) {
    return '';
  }
}
