import 'package:expance_tracker/widget/expence_list/expence_items.dart';
import 'package:flutter/material.dart';
import 'package:expance_tracker/model/expence.dart';

class ExpencesList extends StatelessWidget {
  const ExpencesList({
    super.key,
    required this.expences,
    required this.onRemoveExpense,
  });

  final List<Expence> expences;
  final void Function(Expence expence) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expences.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expences[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expences[index]);
        },
        child: ExpenceItems(
          expences[index],
        ),
      ),
    );
  }
}
