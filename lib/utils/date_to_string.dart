// Package imports:
import 'package:intl/intl.dart';

String dateFormat(DateTime date) {
  var dateText = '';
  final DateFormat formatter = DateFormat('yyyy/MM/dd');
  final now = DateTime.now();

  if (date.isAtSameMomentAs(now)) {
    dateText = '今日';
  } else if (date.isAtSameMomentAs(now.subtract(const Duration(days: 1)))) {
    dateText = '昨日';
  } else {
    dateText = formatter.format(date);
  }
  return dateText;
}
