import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:task2_validate_form/presentation/pages/create_transaction/bloc/create_transaction_bloc.dart';
import 'create_transaction/components/header_widget.dart';
import 'create_transaction/components/transaction_form_widget.dart';

class CreateTransactionPage extends StatelessWidget {
  const CreateTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTransactionBloc, CreateTransactionState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.inProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Submitting...')),
            );
        }
        if (state.status == FormzSubmissionStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Updated'), backgroundColor: Colors.green),
            );
        }
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              HeaderWidget(),
              SizedBox(height: 10),
              TransactionForm(),
            ],
          ),
        ),
      ),
    );
  }
}
