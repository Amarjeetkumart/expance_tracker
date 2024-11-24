import 'package:expance_tracker/model/expence.dart';
import 'package:flutter/material.dart';

class ExpenceItems extends StatelessWidget {
  const ExpenceItems(this.expence, {super.key});

  final Expence expence;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expence.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text("\$${expence.amount.toStringAsFixed(2)}"),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcon[expence.category]),
                      const SizedBox(height: 8),
                      Text(expence.formattedDate),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
