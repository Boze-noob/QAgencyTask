import 'package:q_agency_task/_all.dart';

abstract class Db {
  Future<void> put(String key, dynamic data);

  Future<Result> get(String key);
}

class DbImpl implements Db {
  var box = Hive.box('myDb');

  @override
  Future<Result> get(String key) async {
    final result = await box.get(key);
    return result != null
        ? Result(data: result)
        : Result(exception: Exception("No data in database with this key $key"));
  }

  //TODO try to catch error
  @override
  Future<void> put(String key, data) async {
    await box.put(key, data);
  }
}
