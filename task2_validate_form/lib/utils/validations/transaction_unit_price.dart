import 'package:formz/formz.dart';

enum TransactionUnitPriceValidationError { empty, invalid }

final class TransactionUnitPrice
    extends FormzInput<String, TransactionUnitPriceValidationError> {
  const TransactionUnitPrice.pure([super.value = '']) : super.pure();
  const TransactionUnitPrice.dirty([super.value = '']) : super.dirty();

  @override
  TransactionUnitPriceValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return TransactionUnitPriceValidationError.empty;
    }

    final numberRegex = RegExp(r'^\d+(\.\d+)?$');
    if (!numberRegex.hasMatch(value)) {
      return TransactionUnitPriceValidationError.invalid;
    }

    return null;
  }
}

extension Explanation on TransactionUnitPriceValidationError {
  String? get errorText {
    switch (this) {
      case TransactionUnitPriceValidationError.empty:
        return 'Vui lòng nhập đơn giá';
      case TransactionUnitPriceValidationError.invalid:
        return 'Vui lòng nhập một số hợp lệ';
      default:
        return null;
    }
  }
}
