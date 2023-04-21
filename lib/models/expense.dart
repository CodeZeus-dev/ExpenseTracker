import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMMMMd();

enum Category {
  food,
  travel,
  leisure,
  work,
  health,
}

const iconForCategory = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_land,
  Category.leisure: Icons.pedal_bike,
  Category.work: Icons.work_outline,
  Category.health: Icons.health_and_safety
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}
