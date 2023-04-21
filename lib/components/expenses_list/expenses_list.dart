import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/components/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onDismissingExpense,
  });

  final void Function(Expense expense) onDismissingExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(
          expenses[index],
        ),
        onDismissed: (direction) => onDismissingExpense(
          expenses[index],
        ),
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
