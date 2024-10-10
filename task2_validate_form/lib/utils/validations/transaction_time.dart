import 'package:formz/formz.dart';

enum TransactionDateValidationError { empty }

final class TransactionDate
    extends FormzInput<String, TransactionDateValidationError> {
  const TransactionDate.pure([super.value = '']) : super.pure();
  const TransactionDate.dirty([super.value = '']) : super.dirty();

  @override
  TransactionDateValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return TransactionDateValidationError.empty;
    }
    return null;
  }
}

extension Explanation on TransactionDateValidationError {
  String? get errorText {
    switch (this) {
      case TransactionDateValidationError.empty:
        return 'Vui lòng chọn thời gian';
      default:
        return null;
    }
  }
}
