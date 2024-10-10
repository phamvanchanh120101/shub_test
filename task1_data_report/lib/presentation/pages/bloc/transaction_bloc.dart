import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task1_data_report/data/models/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(const TransactionState()) {
    on<PickFileEvent>(_onPickFile);
    on<LoadFileEvent>(_onLoadFile);
    on<SelectStartTimeEvent>(_onSelectStartTime);
    on<SelectEndTimeEvent>(_onSelectEndTime);
    on<CalculateTotalEvent>(_calculateTotal);
  }

  Future<void> _onPickFile(
      PickFileEvent event, Emitter<TransactionState> emit) async {
    try {
      emit(state.copyWith(status: TransactionStatus.loading));

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'csv'],
      );

      if (result != null) {
        String filePath = result.files.single.path!;
        emit(state.copyWith(selectedFileName: result.files.single.name));
        add(LoadFileEvent(filePath));
      } else {
        emit(
          state.copyWith(
            status: TransactionStatus.error,
            fileErrorMesssage: "No File Selected",
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          fileErrorMesssage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadFile(
      LoadFileEvent event, Emitter<TransactionState> emit) async {
    try {
      var file = File(event.filePath);
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

      List<Transaction> loadedTransactions = [];

      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table]!;

        // Đọc các giao dịch
        for (int i = 8; i < sheet.maxRows; i++) {
          var row = sheet.row(i);
          if (row.isEmpty || row[0]?.value == null) break;

          loadedTransactions.add(Transaction(
            id: int.tryParse(getCellValue(row, 0)) ?? 0,
            date: parseDate(getCellValue(row, 1)),
            time: getCellValue(row, 2),
            station: getCellValue(row, 3),
            pump: getCellValue(row, 4),
            product: getCellValue(row, 5),
            quantity: double.tryParse(getCellValue(row, 6)) ?? 0,
            unitPrice: double.tryParse(getCellValue(row, 7)) ?? 0,
            totalAmount: double.tryParse(getCellValue(row, 8)) ?? 0,
            paymentStatus: getCellValue(row, 9),
            customerCode: getCellValue(row, 10),
            customerName: getCellValue(row, 11),
            customerType: getCellValue(row, 12),
            paymentDate: parseDate(getCellValue(row, 13)),
            employee: getCellValue(row, 14),
            vehicleNumber: getCellValue(row, 15),
            invoiceStatus: getCellValue(row, 16),
          ));
        }
      }

      emit(
        state.copyWith(
          status: TransactionStatus.success,
          transactions: loadedTransactions,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: TransactionStatus.error,
          fileErrorMesssage: error.toString(),
        ),
      );
    }
  }

  String getCellValue(dynamic cell, dynamic index) {
    if (cell is List) {
      return cell[index]?.value?.toString() ?? '';
    } else if (cell is Sheet) {
      return cell.cell(CellIndex.indexByString(index)).value?.toString() ?? '';
    }
    return '';
  }

  DateTime parseDate(String dateString) {
    try {
      return DateFormat("dd/MM/yyyy").parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
  }

  Future<void> _onSelectStartTime(
      SelectStartTimeEvent event, Emitter<TransactionState> emit) async {
    emit(state.copyWith(startTime: event.startTime));
  }

  Future<void> _onSelectEndTime(
      SelectEndTimeEvent event, Emitter<TransactionState> emit) async {
    emit(state.copyWith(endTime: event.endTime));
  }

  Future<void> _calculateTotal(
      CalculateTotalEvent event, Emitter<TransactionState> emit) async {
    // Ensure startTime and endTime are selected
    if (state.startTime == null || state.endTime == null) {
      emit(state.copyWith(timeErrorMessage: "Vui lòng chọn time"));
      return;
    } else {
      emit(state.copyWith(timeErrorMessage: ""));
    }

    // Get the current date for creating DateTime objects with the current day
    final now = DateTime.now();
    final transactions = state.transactions;

    // Combine current date with selected start and end times
    final startDateTime = DateTime(now.year, now.month, now.day,
        state.startTime!.hour, state.startTime!.minute);
    final endDateTime = DateTime(now.year, now.month, now.day,
        state.endTime!.hour, state.endTime!.minute);

    // Filter the transactions based on the selected time range
    final filteredTransactions = transactions.where((transaction) {
      final transactionTime = parseTime(transaction.time);
      return transactionTime.isAfter(startDateTime) &&
          transactionTime.isBefore(endDateTime);
    }).toList();

    // Calculate the total amount from filtered transactions
    final total = filteredTransactions.fold(
        0.0, (sum, transaction) => sum + transaction.totalAmount);

    // Emit the new state with the calculated total payment
    emit(state.copyWith(totalPayment: total));
  }

// Helper function to parse time from a transaction's time string
  DateTime parseTime(String timeString) {
    final now = DateTime.now();
    final time = DateTime.parse(
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} $timeString',
    );
    return time;
  }
}
