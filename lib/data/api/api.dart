import '../../_all.dart';

abstract class Api {
  Future<Result> get(String path, Map<String, dynamic>? queryParameters);
}

class ApiImpl implements Api {
  final Dio dio;

  ApiImpl({required this.dio});

  @override
  Future<Result> get(String path, Map<String, dynamic>? queryParameters) async {
    try {
      final result = await dio.get(path, queryParameters: queryParameters);
      return Result(data: json.decode(result.toString()));
    } on DioError catch (e) {
      return Result(exception: e);
    }
  }
}
