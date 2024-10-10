import 'package:formz/formz.dart';

enum TransactionPumpNumberValidationError { empty }

final class TransactionPumpNumber
    extends FormzInput<String, TransactionPumpNumberValidationError> {
  const TransactionPumpNumber.pure([super.value = '']) : super.pure();
  const TransactionPumpNumber.dirty([super.value = '']) : super.dirty();

  @override
  TransactionPumpNumberValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return TransactionPumpNumberValidationError.empty;
    }
    return null;
  }
}

extension Explanation on TransactionPumpNumberValidationError {
  String? get errorText {
    switch (this) {
      case TransactionPumpNumberValidationError.empty:
        return 'Vui lòng chọn trụ bơm';
      default:
        return null;
    }
  }
}
