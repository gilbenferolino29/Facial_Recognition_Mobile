import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_ui/src/models/attendance_model.dart';

class UserController with ChangeNotifier {
  late StreamSubscription _attendanceSub;
  List attendance = [];

  UserController() {
    _attendanceSub =
        AttendanceUser.currentAttendance().listen(userUpdateHandler);
  }
  @override
  void dispose() {
    _attendanceSub.cancel();
    super.dispose();
  }

  userUpdateHandler(List<AttendanceUser> update) {
    attendance = update;
  }
}
