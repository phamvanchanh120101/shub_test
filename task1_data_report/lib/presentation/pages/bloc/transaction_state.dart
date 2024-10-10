part of 'transaction_bloc.dart';

enum TransactionStatus { initial, loading, success, error }

final class TransactionState extends Equatable {
  const TransactionState({
    this.status = TransactionStatus.initial,
    this.selectedFileName,
    this.fileErrorMesssage = '',
    this.transactions = const [],
    this.startTime,
    this.endTime,
    this.timeErrorMessage = '',
    this.totalPayment = 0.0,
  });

  final TransactionStatus status;
  final String? selectedFileName;
  final String fileErrorMesssage;
  final List<Transaction> transactions;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String timeErrorMessage;
  final double totalPayment;

  TransactionState copyWith({
    TransactionStatus? status,
    String? selectedFileName,
    String? fileErrorMesssage,
    List<Transaction>? transactions,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? timeErrorMessage,
    double? totalPayment,
  }) {
    return TransactionState(
      status: status ?? this.status,
      selectedFileName: selectedFileName ?? this.selectedFileName,
      fileErrorMesssage: fileErrorMesssage ?? this.fileErrorMesssage,
      transactions: transactions ?? this.transactions,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timeErrorMessage: timeErrorMessage ?? this.timeErrorMessage,
      totalPayment: totalPayment ?? this.totalPayment,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedFileName,
        fileErrorMesssage,
        transactions,
        startTime,
        endTime,
        timeErrorMessage,
        totalPayment,
      ];
}
