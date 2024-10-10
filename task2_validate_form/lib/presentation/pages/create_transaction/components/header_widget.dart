import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2_validate_form/presentation/pages/create_transaction/bloc/create_transaction_bloc.dart';
import 'package:task2_validate_form/presentation/widgets/button_base.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 235, 234, 234),
            offset: Offset(0, 8),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 6),
                  Text(
                    'Đóng',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Nhập giao dịch',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          ButtonBase(
            text: 'Cập nhật',
            onPressed: () {
              context.read<CreateTransactionBloc>().add(FormSubmitted());
            },
          ),
        ],
      ),
    );
  }
}
