import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/components/expenses_list/expenses_list.dart';
import 'package:expense_tracker/components/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Espresso Freddo",
      amount: 2.50,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Flight Tickets",
      amount: 250,
      date: DateTime.parse(
        '2023-04-09 20:18:04Z',
      ),
      category: Category.travel,
    ),
    Expense(
      title: "Dental Filling",
      amount: 65,
      date: DateTime.parse(
        '2023-04-19 14:18:04Z',
      ),
      category: Category.food,
    ),
  ];

  void addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpenseFromList(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _addNewExpenseBottomModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(
        sendNewExpenseData: addNewExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Constantine's Expense Tracker",
          ),
          actions: [
            IconButton(
              onPressed: _addNewExpenseBottomModal,
              icon: const Icon(Icons.add),
            )
          ]),
      body: Column(
        children: <Widget>[
          const Text(
            "The chart...",
          ),
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
              onDismissingExpense: _removeExpenseFromList,
            ),
          ),
        ],
      ),
    );
  }
}
