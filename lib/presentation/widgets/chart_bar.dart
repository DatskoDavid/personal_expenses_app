import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percenteFromAll;

  ChartBar({
    required this.label,
    required this.amount,
    required this.percenteFromAll,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                // fit: BoxFit.fill,
                child: Text(
                  '\$${amount.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.06),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(220, 220, 220, 1),
                    ),
                  ),
                  FractionallySizedBox(
                    // alignment: Alignment.bottomCenter,
                    heightFactor: percenteFromAll,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.06),
            SizedBox(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
