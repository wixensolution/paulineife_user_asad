import 'package:flutter/material.dart';
import 'package:paulineife_user/helpers/helpers.dart';

extension MyExtensions on num {
  double toMiles() {
    return this * 0.000621371192;
  }

  get daysFromNow {
    var currentDate = DateTime.now();
    var oldDate = DateTime.fromMillisecondsSinceEpoch(this as int);
    return currentDate.difference(oldDate).inDays;
  }

  get toDuration {
    return _printDuration(Duration(seconds: this.toInt()));
  }
}

extension SheetStatusExtensions on BottomSheetType {
  Color get statusColor {
    switch (this) {
      case BottomSheetType.success:
        return Colors.green;
      case BottomSheetType.error:
        return Colors.red;
      case BottomSheetType.warning:
        return Colors.blue;
      default:
        return getThemeBlack;
    }
  }
}

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  /*${twoDigits(duration.inHours)}:*/
  return "$twoDigitMinutes:$twoDigitSeconds";
}
