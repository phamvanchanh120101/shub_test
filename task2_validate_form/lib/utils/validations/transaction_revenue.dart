import 'package:formz/formz.dart';

enum TransactionRevenueValidationError { empty, invalid }

final class TransactionRevenue
    extends FormzInput<String, TransactionRevenueValidationError> {
  const TransactionRevenue.pure([super.value = '']) : super.pure();
  const TransactionRevenue.dirty([super.value = '']) : super.dirty();

  @override
  TransactionRevenueValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return TransactionRevenueValidationError.empty;
    }

    final numberRegex = RegExp(r'^\d+(\.\d+)?$');
    if (!numberRegex.hasMatch(value)) {
      return TransactionRevenueValidationError.invalid;
    }

    return null;
  }
}

extension Explanation on TransactionRevenueValidationError {
  String? get errorText {
    switch (this) {
      case TransactionRevenueValidationError.empty:
        return 'Vui lòng nhập doanh thu';
      case TransactionRevenueValidationError.invalid:
        return 'Vui lòng nhập một số hợp lệ';
      default:
        return null;
    }
  }
}
