part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class PickFileEvent extends TransactionEvent {}

class LoadFileEvent extends TransactionEvent {
  final String filePath;

  const LoadFileEvent(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class SelectStartTimeEvent extends TransactionEvent {
  final TimeOfDay startTime;

  const SelectStartTimeEvent(this.startTime);

  @override
  List<Object> get props => [startTime];
}

class SelectEndTimeEvent extends TransactionEvent {
  final TimeOfDay endTime;

  const SelectEndTimeEvent(this.endTime);

  @override
  List<Object> get props => [endTime];
}

class CalculateTotalEvent extends TransactionEvent {}
