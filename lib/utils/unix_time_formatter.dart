// Package imports:
import 'package:intl/intl.dart';

String unixToDate(int t) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(t);
  String time = DateFormat("MM月dd日").format(date).toString();
  return time;
}
