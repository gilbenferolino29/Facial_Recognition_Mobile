import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceUser {
  final String name, date, time, department, remarks;
  final num attendanceID, employeeID, classcode;

  AttendanceUser(
      {required this.attendanceID,
      required this.classcode,
      required this.date,
      required this.department,
      required this.employeeID,
      required this.name,
      required this.remarks,
      required this.time});

  static AttendanceUser fromDocumentSnap(DocumentSnapshot snap) {
    Map<String, dynamic> json = snap.data() as Map<String, dynamic>;
    return AttendanceUser(
      attendanceID: json['attendance'] ?? '',
      classcode: json['classcode'] ?? '',
      date: json['date'] ?? '',
      department: json['department'] ?? '',
      employeeID: json['employee'] ?? '',
      name: json['name'] ?? '',
      remarks: json['remarks'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> get json => {
        'attendanceID': attendanceID,
        'classcode': classcode,
        'date': date,
        'department': department,
        'employeeID': employeeID,
        'name': name,
        'remarks': remarks,
        'time': time,
      };

  static List<AttendanceUser> fromQuerySnap(QuerySnapshot snap) {
    try {
      return snap.docs.map(AttendanceUser.fromDocumentSnap).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Stream<List<AttendanceUser>> currentAttendance() =>
      FirebaseFirestore.instance
          .collection('attendance')
          .orderBy('date')
          .where('field')
          .snapshots()
          .map(AttendanceUser.fromQuerySnap);
}
