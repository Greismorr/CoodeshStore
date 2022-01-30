import 'package:intl/intl.dart';

mixin HaveDate {
  //Esta função converte o timestamp para o formato dd/MM/yyyy
  //timestamps normalmente são um long, mas o int do dart também abrange longs
  String getTimeDate(int timestamp) {
    try {
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');

      DateTime dateFromTimestamp =
          DateTime.fromMillisecondsSinceEpoch(timestamp);
      return dateFormat.format(dateFromTimestamp);
    } catch (e) {
      return "Something's went wrong...";
    }
  }
}
