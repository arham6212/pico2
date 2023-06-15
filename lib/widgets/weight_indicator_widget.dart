import 'package:flutter/material.dart';

class WeightSummaryWidget extends StatelessWidget {
  final int weightsAdded;
  final double totalWeight;

  const WeightSummaryWidget({
    Key? key,
    required this.weightsAdded,
    required this.totalWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double maxWeight = 100.0;
    final double addedWeightPercentage = weightsAdded / maxWeight;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     Container(
          //       width: 180,
          //       height: 180,
          //       decoration:
          //           BoxDecoration(shape: BoxShape.circle, color: kGreenColor),
          //     ),
          //     Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           'Weight Added',
          //           style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         ),
          //         SizedBox(height: 8),
          //         Text(
          //           '${weightsAdded.toString()} kg',
          //           style: TextStyle(
          //             fontSize: 32,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildWeightInfo('Total Weight',
                  '${totalWeight.toStringAsFixed(2)} kg', Colors.deepPurple),
              buildWeightInfo(
                  'Remaining',
                  '${(maxWeight - weightsAdded).toStringAsFixed(2)} kg',
                  Colors.deepPurple),
            ],
          ),
        ],
      ),
    );
  }

  Column buildWeightInfo(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
