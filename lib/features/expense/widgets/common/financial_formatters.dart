import 'package:intl/intl.dart';

class FinancialFormatters {
  const FinancialFormatters._();

  static String amount(double value) {
    if (value == value.roundToDouble()) {
      return '\$${value.toStringAsFixed(0)}';
    }
    return '\$${value.toStringAsFixed(2)}';
  }

  static String amountInput(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(2);
  }

  static String date(DateTime value) {
    return DateFormat('yyyy-MM-dd').format(value);
  }

  static String dateTime(DateTime value) {
    return DateFormat('yyyy-MM-dd HH:mm').format(value);
  }

  static String rate(double value) {
    if (value == value.roundToDouble()) {
      return '${value.toStringAsFixed(0)}%';
    }
    return '${value.toStringAsFixed(2)}%';
  }

  static String rateInput(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(2);
  }

  static String period(int value) {
    if (value == 1) {
      return '1 month';
    }
    return '$value months';
  }
}
