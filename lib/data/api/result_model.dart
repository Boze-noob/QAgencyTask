import 'package:q_agency_task/_all.dart';

class Result<T> {
  T? data;
  DioError? exception;
  bool get hasData => (data is List && (data as List).isNotEmpty) || (data is! List && data != null);
  bool get isSuccess => !isError;
  bool get isError => exception != null;
  int? statusCode;
  String? statusMessage;

  Result({
    this.data,
    this.exception,
    this.statusCode = 200,
    this.statusMessage = '',
  });
}
