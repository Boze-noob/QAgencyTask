import 'package:q_agency_task/_all.dart';

abstract class Db {
  Future<bool> put(String key, dynamic data);

  Future<dynamic> get(String key);
}

class DbImpl implements Db {
  FlutterSecureStorage storage;

  DbImpl({required this.storage});

  @override
  Future<dynamic> get(String key) async {
    final result = await storage.read(key: key);
    return result != null ? jsonDecode(result) : null;
  }

  //TODO try to catch error
  @override
  Future<bool> put(String key, dynamic data) async {
    bool result = true;
    await storage.write(key: key, value: jsonEncode(data)).catchError((onError) => result = false);
    return result;
  }
}
