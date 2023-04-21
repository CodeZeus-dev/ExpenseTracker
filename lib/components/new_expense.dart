import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.sendNewExpenseData,
  });

  final void Function(Expense expense) sendNewExpenseData;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;

  void _datePicker() async {
    final today = DateTime.now();
    final datePicked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(
        today.year - 1,
        today.month,
        today.day,
      ),
      lastDate: today,
    );
    setState(() {
      _selectedDate = datePicked;
    });
  }

  void _saveExpenseData() {
    final invalidTitle = _titleController.text.trim().isEmpty;
    final invalidDate = _selectedDate == null;
    final expenseAmount = double.tryParse(_amountController.text);
    final invalidAmount = expenseAmount == null || expenseAmount <= 0;
    final invalidExpenseData = invalidAmount || invalidTitle || invalidDate;

    if (invalidExpenseData) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            "Invalid Input",
          ),
          content: const Text(
            "Please make sure you've entered a valid title, picked a valid date and entered the right amount 🧐",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("No worries 👌"),
            ),
          ],
        ),
      );
      return;
    }

    widget.sendNewExpenseData(
      Expense(
          title: _titleController.text.trim(),
          amount: expenseAmount!,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text(
                "Title",
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _amountController,
                  // maxLength: 50,
                  decoration: const InputDecoration(
                    prefixText: "\$ ",
                    label: Text(
                      "Amount",
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _selectedDate == null
                          ? "No date selected"
                          : formatter.format(_selectedDate!),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: _datePicker,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: <Widget>[
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                ),
              ),
              ElevatedButton(
                onPressed: _saveExpenseData,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple[900],
                ),
                child: const Text(
                  "Save Expense",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
