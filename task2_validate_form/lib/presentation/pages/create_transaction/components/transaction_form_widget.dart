import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2_validate_form/presentation/pages/create_transaction/bloc/create_transaction_bloc.dart';
import 'package:task2_validate_form/presentation/widgets/text_field_base.dart';
import 'package:task2_validate_form/utils/date_time_picker.dart';
import 'package:task2_validate_form/utils/extensions.dart';
import 'package:task2_validate_form/utils/validations/transaction_pump_number.dart';
import 'package:task2_validate_form/utils/validations/transaction_quanlity.dart';
import 'package:task2_validate_form/utils/validations/transaction_revenue.dart';
import 'package:task2_validate_form/utils/validations/transaction_time.dart';
import 'package:task2_validate_form/utils/validations/transaction_unit_price.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            children: [
              _DateSelectedInput(),
              SizedBox(height: 20),
              _QuantityInput(),
              SizedBox(height: 20),
              _PumpNumberSelectedInput(),
              SizedBox(height: 20),
              _RevenueInput(),
              SizedBox(height: 20),
              _UnitPriceInput(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateSelectedInput extends StatefulWidget {
  const _DateSelectedInput();

  @override
  State<_DateSelectedInput> createState() => _DateSelectedInputState();
}

class _DateSelectedInputState extends State<_DateSelectedInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTransactionBloc, CreateTransactionState>(
      builder: (context, state) {
        return TextFieldBase(
          onTap: () => _selectDate(),
          lableText: "Thời gian",
          readOnly: true,
          hintText: state.selectedDate.value,
          suffixIcon: const Icon(
            Icons.date_range,
            color: Colors.grey,
          ),
          errorText: state.selectedDate.displayError?.errorText,
        );
      },
    );
  }

  Future<void> _selectDate() async {
    final dateTime = await DateTimePicker.pickDateTime(context);
    if (dateTime != null && mounted) {
      final formattedDate = dateTime.format();
      context
          .read<CreateTransactionBloc>()
          .add(DateSelected(date: formattedDate));
    }
  }
}

class _QuantityInput extends StatelessWidget {
  const _QuantityInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTransactionBloc, CreateTransactionState>(
      builder: (context, state) {
        return TextFieldBase(
          lableText: "Số lượng",
          onChanged: (value) => context
              .read<CreateTransactionBloc>()
              .add(QuantityChanged(quantity: value!)),
          errorText: state.quantity.displayError?.errorText,
        );
      },
    );
  }
}

class _PumpNumberSelectedInput extends StatefulWidget {
  const _PumpNumberSelectedInput();

  @override
  State<_PumpNumberSelectedInput> createState() =>
      _PumpNumberSelectedInputState();
}

class _PumpNumberSelectedInputState extends State<_PumpNumberSelectedInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTransactionBloc, CreateTransactionState>(
      builder: (context, state) {
        return TextFieldBase(
          lableText: "Trụ",
          onTap: () {
            _showDropdownDialog(
              (pumpNumber) => context
                  .read<CreateTransactionBloc>()
                  .add(PumpNumberSelected(pumpNumber: pumpNumber)),
            );
          },
          hintText: state.pumpNumber.value,
          readOnly: true,
          errorText: state.pumpNumber.displayError?.errorText,
          suffixIcon: const Icon(
            size: 30,
            Icons.arrow_drop_down,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  void _showDropdownDialog(ValueChanged<String> onItemSelected) {
    List<String> items = ["Trụ 1", "Trụ 2", "Trụ 3", "Trụ 4"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Chọn trụ bơm"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    onItemSelected(items[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _RevenueInput extends StatelessWidget {
  const _RevenueInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTransactionBloc, CreateTransactionState>(
      builder: (context, state) {
        return TextFieldBase(
          lableText: "Doanh thu",
          onChanged: (value) => context
              .read<CreateTransactionBloc>()
              .add(RevenueChanged(revenue: value!)),
          errorText: state.revenue.displayError?.errorText,
        );
      },
    );
  }
}

class _UnitPriceInput extends StatelessWidget {
  const _UnitPriceInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTransactionBloc, CreateTransactionState>(
      builder: (context, state) {
        return TextFieldBase(
          lableText: "Đơn giá",
          onChanged: (value) => context
              .read<CreateTransactionBloc>()
              .add(UnitPriceChanged(unitPrice: value!)),
          errorText: state.unitPrice.displayError?.errorText,
        );
      },
    );
  }
}
