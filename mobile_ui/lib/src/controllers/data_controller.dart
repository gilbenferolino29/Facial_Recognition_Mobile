import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DataController {
  final StreamController<String?> _controller = StreamController();
  Stream<String?> get stream => _controller.stream;
  late List allAccounts;
  late List allAttendance;
  DataController() {
    setAllData();
  }

  void setAllData() {
    setAllAccounts();
    setAllAttendance();
  }

  void setAllAccounts() async {
    _controller.add(null);
    try {
      final response = await getAllAccounts();

      if (response.statusCode == 200) {
        final jsonRes = convert.jsonDecode(response.body);
        allAccounts = jsonRes['data'];
        //print(allAccounts);

        _controller.add("success");
      } else {
        print(response.statusCode);
        _controller.addError(Future.error(response.statusCode));
      }
    } catch (e) {
      print(e);
      _controller.addError((e));
    }
  }

  void setAllAttendance() async {
    _controller.add(null);
    try {
      final response = await getAllAttendance();

      if (response.statusCode == 200) {
        final jsonRes = convert.jsonDecode(response.body);
        allAttendance = jsonRes['data'];
        print(allAttendance);
        _controller.add("success");
      } else {
        print(response.statusCode);
        _controller.addError(Future.error(response.statusCode));
      }
    } catch (e) {
      print(e);
      _controller.addError((e));
    }
  }

  static DataController fromSnap(http.Response response) {
    return convert.jsonDecode(response.body);
  }

  Future<http.Response> getAllAccounts() async {
    final url = Uri.https(
        'us-central1-facial-recognition-syste-c82ae.cloudfunctions.net',
        'api/user/getAllAccounts', {});

    final response = await http.get(url);
    return response;
  }

  Future<http.Response> getAllAttendance() async {
    final url = Uri.https(
        'us-central1-facial-recognition-syste-c82ae.cloudfunctions.net',
        'api/user/getAllAttendance', {});

    final response = await http.get(url);
    // try {
    //   if (response.statusCode == 200) {
    //     final jsonRes = convert.jsonDecode(response.body);
    //     allAttendance = jsonRes['data'];
    //     print(allAttendance);
    //     _controller.add("success");
    //   } else {
    //     print(response.statusCode);
    //     _controller.addError(Future.error(response.statusCode));
    //   }
    // } catch (e) {
    //   print(e);
    //   _controller.addError((e));
    // }
    return response;
  }
}
