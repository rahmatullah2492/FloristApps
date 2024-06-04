import 'package:Florist/model/tanaman/data_tanaman.dart';

class ApiResponseTanaman {
  List<DataTanaman>? tanaman;
  String? error;

  ApiResponseTanaman({this.tanaman, this.error});

  set userId(userId) {}

  Future<List<DataTanaman>> getTanaman() {
    return Future<List<DataTanaman>>.value(tanaman!);
  }
}

