import 'package:flutter/material.dart';

import '../screens/edit_screen.dart';
import '../utils/utility.dart';

class AddedPalletItemWidget extends StatelessWidget {
  const AddedPalletItemWidget({
    Key? key,
    required this.index,
    required this.palletName,
    required this.variantName,
    required this.skuName,
    required this.weight,
    required this.onSuccessfulDeletion,
  }) : super(key: key);

  final int index;
  final String palletName;
  final String variantName;
  final String skuName;
  final String weight;
  final VoidCallback onSuccessfulDeletion;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditScreen(index: index)),
          );
        },
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: const Text(
            'P',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        title: Text(
          palletName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SKU: $skuName',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              variantName,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Weight: ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 8),
                Text(
                  weight,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
            Text(
              '${int.parse(weight ?? '0') / 20} C',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(index: index),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
                size: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                Utility.alertBox(
                  titleText: 'Are you sure you want to delete?',
                  successButtonText: 'Delete',
                  successButtonFunction: onSuccessfulDeletion,
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
