import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(
            expense.title,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: <Widget>[
              Text(
                "\$${expense.amount.toStringAsFixed(2)}",
              ),
              const Spacer(),
              Row(
                children: <Widget>[
                  Icon(
                    iconForCategory[expense.category],
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    expense.formattedDate,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
