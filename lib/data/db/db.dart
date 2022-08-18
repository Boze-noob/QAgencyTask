import 'package:q_agency_task/_all.dart';

abstract class Db {
  Future<bool> put(String key, dynamic data);

  Future<dynamic> get(String key);
}

class DbImpl implements Db {
  Box box;

  DbImpl({required this.box});

  @override
  Future<dynamic> get(String key) async {
    final result = await box.get(key);
    return result;
    //final result = await storage.read(key: key);
    //return result != null ? jsonDecode(result) : null;
  }

  @override
  Future<bool> put(String key, dynamic data) async {
    bool result = true;
    await box.put(key, data).catchError((onError) => result = false);
    return result;
    //bool result = true;
    //await storage.write(key: key, value: jsonEncode(data)).catchError((onError) => result = false);
    //return result;
  }
}
