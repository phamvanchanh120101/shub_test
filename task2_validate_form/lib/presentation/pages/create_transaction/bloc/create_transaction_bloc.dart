import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:task2_validate_form/utils/validations/transaction_pump_number.dart';
import 'package:task2_validate_form/utils/validations/transaction_quanlity.dart';
import 'package:task2_validate_form/utils/validations/transaction_revenue.dart';
import 'package:task2_validate_form/utils/validations/transaction_time.dart';
import 'package:task2_validate_form/utils/validations/transaction_unit_price.dart';

part 'create_transaction_event.dart';
part 'create_transaction_state.dart';

class CreateTransactionBloc
    extends Bloc<CreateTransactionEvent, CreateTransactionState> {
  CreateTransactionBloc() : super(const CreateTransactionState()) {
    on<DateSelected>(_onDateSelected);
    on<QuantityChanged>(_onQuantityChanged);
    on<PumpNumberSelected>(_onPumpNumberSelected);
    on<RevenueChanged>(_onRevenueChanged);
    on<UnitPriceChanged>(_onUnitPriceChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onDateSelected(
      DateSelected event, Emitter<CreateTransactionState> emit) {
    final selectedDate = TransactionDate.dirty(event.date);

    emit(
      state.copyWith(
        selectedDate: selectedDate.isValid
            ? selectedDate
            : TransactionDate.pure(event.date),
        isValid: Formz.validate([state.selectedDate]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onQuantityChanged(
      QuantityChanged event, Emitter<CreateTransactionState> emit) {
    final quantity = TransactionQuantity.dirty(event.quantity);

    emit(
      state.copyWith(
        quantity: quantity.isValid
            ? quantity
            : TransactionQuantity.pure(event.quantity),
        isValid: Formz.validate([state.selectedDate, quantity]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onPumpNumberSelected(
      PumpNumberSelected event, Emitter<CreateTransactionState> emit) {
    final selectedPumpNumber = TransactionPumpNumber.dirty(event.pumpNumber);
    emit(
      state.copyWith(
        pumpNumber: selectedPumpNumber.isValid
            ? selectedPumpNumber
            : TransactionPumpNumber.pure(event.pumpNumber),
        isValid: Formz.validate(
            [state.selectedDate, state.quantity, selectedPumpNumber]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onRevenueChanged(
      RevenueChanged event, Emitter<CreateTransactionState> emit) {
    final revenue = TransactionRevenue.dirty(event.revenue);
    emit(
      state.copyWith(
        revenue:
            revenue.isValid ? revenue : TransactionRevenue.pure(event.revenue),
        isValid: Formz.validate(
            [state.selectedDate, state.quantity, state.pumpNumber, revenue]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onUnitPriceChanged(
      UnitPriceChanged event, Emitter<CreateTransactionState> emit) {
    final unitPrice = TransactionUnitPrice.dirty(event.unitPrice);
    emit(state.copyWith(
      unitPrice: unitPrice.isValid
          ? unitPrice
          : TransactionUnitPrice.pure(event.unitPrice),
      isValid: Formz.validate([
        state.selectedDate,
        state.quantity,
        state.pumpNumber,
        state.revenue,
        unitPrice
      ]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<CreateTransactionState> emit,
  ) async {
    final selectedDate = TransactionDate.dirty(state.selectedDate.value);
    final quantity = TransactionQuantity.dirty(state.quantity.value);
    final selectedPumpNumber =
        TransactionPumpNumber.dirty(state.pumpNumber.value);
    final revenue = TransactionRevenue.dirty(state.revenue.value);
    final unitPrice = TransactionUnitPrice.dirty(state.unitPrice.value);
    emit(
      state.copyWith(
        selectedDate: selectedDate,
        quantity: quantity,
        pumpNumber: selectedPumpNumber,
        revenue: revenue,
        unitPrice: unitPrice,
        isValid: Formz.validate(
            [selectedDate, quantity, selectedPumpNumber, revenue, unitPrice]),
        status: FormzSubmissionStatus.initial,
      ),
    );
    print(state.isValid);
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    }
  }
}
