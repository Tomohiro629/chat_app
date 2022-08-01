import 'package:intl/intl.dart';

String getDateString(DateTime date) {
  return DateFormat("HH:mm").format(date);
}

String getPartnerUserId(String currentUserId, List<String> userIds) {
  return userIds.firstWhere((userId) => currentUserId != userId);
}
