import 'package:easy_localization/easy_localization.dart';


class TimeFormatter{
  // Formatter for time stamps
  String formatTimeAgo(String time) {
    DateTime dateTime = DateTime.parse(time);
    Duration diff = DateTime.now().difference(dateTime);

    if (diff.inDays >= 1) {
      return '${diff.inDays} ' + "daysAgo".tr().toString();
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} ' + "hoursAgo".tr().toString();
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} ' + "minutesAgo".tr().toString();
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} ' + "secondsAgo".tr().toString();
    } else if (diff.inDays < 0) {
      Duration positiveTime = diff.abs();
      return "in".tr().toString() +
          ' ${positiveTime.inDays} ' +
          "days".tr().toString();
    } else if (diff.inHours < 0) {
      Duration positiveTime = diff.abs();
      return "in".tr().toString() +
          ' ${positiveTime.inHours} ' +
          "hours".tr().toString();
    } else if (diff.inMinutes < 0) {
      Duration positiveTime = diff.abs();
      return "in".tr().toString() +
          ' ${positiveTime.inMinutes} ' +
          "minutes".tr().toString();
    } else if (diff.inSeconds < 0) {
      Duration positiveTime = diff.abs();
      return "in".tr().toString() +
          ' ${positiveTime.inSeconds} ' +
          "seconds".tr().toString();
    } else {
      return 'justNow'.tr().toString();
    }
  }
}

