part of 'create_transaction_bloc.dart';

final class CreateTransactionState extends Equatable {
  const CreateTransactionState({
    this.selectedDate = const TransactionDate.pure(),
    this.quantity = const TransactionQuantity.pure(),
    this.pumpNumber = const TransactionPumpNumber.pure(),
    this.revenue = const TransactionRevenue.pure(),
    this.unitPrice = const TransactionUnitPrice.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final TransactionDate selectedDate;
  final TransactionQuantity quantity;
  final TransactionPumpNumber pumpNumber;
  final TransactionRevenue revenue;
  final TransactionUnitPrice unitPrice;
  final bool isValid;
  final FormzSubmissionStatus status;

  CreateTransactionState copyWith({
    TransactionDate? selectedDate,
    TransactionQuantity? quantity,
    TransactionPumpNumber? pumpNumber,
    TransactionRevenue? revenue,
    TransactionUnitPrice? unitPrice,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return CreateTransactionState(
      selectedDate: selectedDate ?? this.selectedDate,
      quantity: quantity ?? this.quantity,
      pumpNumber: pumpNumber ?? this.pumpNumber,
      revenue: revenue ?? this.revenue,
      unitPrice: unitPrice ?? this.unitPrice,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        selectedDate,
        quantity,
        pumpNumber,
        revenue,
        unitPrice,
        status,
        isValid,
      ];
}
