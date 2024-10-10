import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task1_data_report/data/models/transaction.dart';
import 'package:task1_data_report/presentation/pages/bloc/transaction_bloc.dart';
import '../widgets/button_base.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text(
          'Chi tiết doanh thu'.toUpperCase(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _UploadButton(),
                  SizedBox(width: 8),
                  Flexible(child: _FileNameText()),
                ],
              ),
              Divider(height: 20),
              _PaymentTotalCalculatorWidget(),
              Expanded(child: _TransactionList()),
            ],
          ),
        ),
      ),
    );
  }
}

class _UploadButton extends StatelessWidget {
  const _UploadButton();

  @override
  Widget build(BuildContext context) {
    return ButtonBase(
      text: "Tải lên file Excel",
      onPressed: () {
        context.read<TransactionBloc>().add(PickFileEvent());
      },
    );
  }
}

class _FileNameText extends StatelessWidget {
  const _FileNameText();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Text(
          _getFileName(state),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        );
      },
    );
  }

  String _getFileName(TransactionState state) {
    if (state.status == TransactionStatus.loading) {
      return "Đang tải...";
    } else if (state.status == TransactionStatus.success) {
      return "File: ${state.selectedFileName}";
    } else if (state.status == TransactionStatus.error) {
      return state.fileErrorMesssage;
    }
    return 'Chưa chọn tệp tin';
  }
}

class _PaymentTotalCalculatorWidget extends StatelessWidget {
  const _PaymentTotalCalculatorWidget();

  @override
  Widget build(BuildContext context) {
    Future<void> selectTime(bool isStartTime) async {
      final bloc = context.read<TransactionBloc>();
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null) {
        if (isStartTime) {
          bloc.add(SelectStartTimeEvent(picked));
        } else {
          bloc.add(SelectEndTimeEvent(picked));
        }
      }
    }

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state.transactions.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Chọn time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      readOnly: true,
                      onTap: () => selectTime(true),
                      decoration: InputDecoration(
                        hintText: state.startTime != null
                            ? state.startTime!.format(context)
                            : 'Start Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      readOnly: true,
                      onTap: () => selectTime(false),
                      decoration: InputDecoration(
                        hintText: state.endTime != null
                            ? state.endTime!.format(context)
                            : 'End Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (state.timeErrorMessage != "")
                Text(
                  state.timeErrorMessage,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    ButtonBase(
                      backgroundColor: Colors.redAccent,
                      text: 'Submit',
                      onPressed: () {
                        context
                            .read<TransactionBloc>()
                            .add(CalculateTotalEvent());
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Tổng: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${NumberFormat('#,##0').format(state.totalPayment)} đ",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const Divider(height: 20),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _TransactionList extends StatelessWidget {
  const _TransactionList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state.transactions.isEmpty) {
          return const Center(child: Text('Không có giao dịch nào.'));
        }

        return ListView.builder(
          itemCount: state.transactions.length,
          itemBuilder: (context, index) {
            final transaction = state.transactions[index];
            return _TransactionListItem(transaction: transaction);
          },
        );
      },
    );
  }
}

class _TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const _TransactionListItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(transaction.product),
      subtitle: Text(
        '${DateFormat('dd/MM/yyyy').format(transaction.date)} - ${transaction.time}',
      ),
      trailing: Text(
        NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0)
            .format(transaction.totalAmount),
      ),
    );
  }
}
