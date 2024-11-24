import 'package:expance_tracker/widget/expence_list/expences_list.dart';
import 'package:expance_tracker/widget/new_expence.dart';
import 'package:flutter/material.dart';
import 'package:expance_tracker/model/expence.dart';
import 'package:expance_tracker/widget/chart/chart.dart';

class Expances extends StatefulWidget {
  const Expances({super.key});

  @override
  State<Expances> createState() {
    return _ExpancesState();
  }
}

class _ExpancesState extends State<Expances> {
  //const _Expances({super.key});
  final List<Expence> _registerExpenses = [
    Expence(
      amount: 399,
      date: DateTime.now(),
      title: "flutter course",
      category: Category.work,
    ),
    Expence(
      amount: 299,
      date: DateTime.now(),
      title: "Cinema",
      category: Category.leisure,
    ),
  ];

  void _openAddExpanceOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpence(onAddExpence: _addExpence),
    );
  }

  void _addExpence(Expence expence) {
    setState(() {
      _registerExpenses.add(expence);
    });
  }

  void _removeExpence(Expence expance) {
    final expenceIndex = _registerExpenses.indexOf(expance);
    setState(() {
      _registerExpenses.remove(expance);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted."),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenceIndex, expance);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No Expense found. Start adding some! "),
    );
    if (_registerExpenses.isNotEmpty) {
      mainContent = ExpencesList(
        expences: _registerExpenses,
        onRemoveExpense: _removeExpence,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Flutter ExpencesTracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpanceOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registerExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registerExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
