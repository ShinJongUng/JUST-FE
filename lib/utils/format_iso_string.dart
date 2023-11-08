import 'package:intl/intl.dart';

String parseAndFormatIso8601String(String iso8601String) {
  DateTime dateTime = DateTime.parse(iso8601String);
  String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
  return formattedDate;
}
