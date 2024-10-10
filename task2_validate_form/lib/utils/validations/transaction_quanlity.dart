import 'package:formz/formz.dart';

enum TransactionQuantityValidationError { empty, invalid }

final class TransactionQuantity
    extends FormzInput<String, TransactionQuantityValidationError> {
  const TransactionQuantity.pure([super.value = '']) : super.pure();
  const TransactionQuantity.dirty([super.value = '']) : super.dirty();

  @override
  TransactionQuantityValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return TransactionQuantityValidationError.empty;
    }

    final numberRegex = RegExp(r'^\d+(\.\d+)?$');
    if (!numberRegex.hasMatch(value)) {
      return TransactionQuantityValidationError.invalid;
    }

    return null;
  }
}

extension Explanation on TransactionQuantityValidationError {
  String? get errorText {
    switch (this) {
      case TransactionQuantityValidationError.empty:
        return 'Vui lòng nhập số lượng';
      case TransactionQuantityValidationError.invalid:
        return 'Vui lòng nhập một số hợp lệ';
      default:
        return null;
    }
  }
}
