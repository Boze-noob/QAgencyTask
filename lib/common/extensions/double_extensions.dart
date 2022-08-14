extension DoubleExtensions on double {
  String roundTo(int decimalPlaces) {
    return toStringAsFixed(decimalPlaces);
  }
}

extension DoubleNullableExtensions on double? {
  double get value => this ?? 0;
  String toPrice([int numberOfDecimals = 2]) => this != null
      ? (this! - this!.floor() == 0 ? this!.toStringAsFixed(0) : this!.toStringAsFixed(numberOfDecimals))
      : '';
}
