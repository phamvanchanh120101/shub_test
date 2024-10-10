part of 'create_transaction_bloc.dart';

sealed class CreateTransactionEvent extends Equatable {
  const CreateTransactionEvent();

  @override
  List<Object> get props => [];
}

final class DateSelected extends CreateTransactionEvent {
  const DateSelected({required this.date});

  final String date;

  @override
  List<Object> get props => [date];
}

final class QuantityChanged extends CreateTransactionEvent {
  const QuantityChanged({required this.quantity});

  final String quantity;

  @override
  List<Object> get props => [quantity];
}

final class PumpNumberSelected extends CreateTransactionEvent {
  const PumpNumberSelected({required this.pumpNumber});

  final String pumpNumber;

  @override
  List<Object> get props => [pumpNumber];
}

final class RevenueChanged extends CreateTransactionEvent {
  const RevenueChanged({required this.revenue});

  final String revenue;

  @override
  List<Object> get props => [revenue];
}

final class UnitPriceChanged extends CreateTransactionEvent {
  const UnitPriceChanged({required this.unitPrice});

  final String unitPrice;

  @override
  List<Object> get props => [unitPrice];
}

final class FormSubmitted extends CreateTransactionEvent {}
