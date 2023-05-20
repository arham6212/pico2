import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/pallet_creation_controller.dart';
import '../screens/edit_screen.dart';
import '../theme/colors.dart';
import '../utils/utility.dart';

class PalletCreationBottomWidget extends StatelessWidget {
  PalletCreationBottomWidget(
      {Key? key, required this.onDelete, required this.totalWeight})
      : super(key: key);
  final VoidCallback onDelete;
  final String totalWeight;

  final PalletCreationController palletCreationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        palletCreationController.palletItemsList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Weight:',
                      style: Get.textTheme.bodyText2
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$totalWeight kg',
                      style: Get.textTheme.bodyText2
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              )
            : const Offstage(),
        const SizedBox(height: 15),
        Flexible(
          child: ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            reverse: true,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Pallet: ' +
                                (palletCreationController
                                        .palletItemsList[index].palletName ??
                                    ''),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(color: CupertinoColors.white),
                          ),
                          Text(
                            'VAR: ' +
                                (palletCreationController
                                        .palletItemsList[index].variantName ??
                                    ''),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'SKU: ${palletCreationController.palletItemsList[index].skuName ?? ''} dhjhdjsdhjshdjshdsjdhjshdsjhdsjdh',
                            style: const TextStyle(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Weight: ${palletCreationController.palletItemsList[index].weight} Kg',
                            style: const TextStyle(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      color: Colors.white,
                      width: 2,
                      height: 50,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${int.parse(palletCreationController.palletItemsList[index].weight ?? '0') / 20} C',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => EditScreen(
                                  index: index,
                                ));
                          },
                          child: Icon(
                            Icons.edit,
                            color: kBlueColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Utility.alertBox(
                                titleText: 'Are you sure you want to delete?',
                                successButtonText: 'Delete',
                                successButtonFunction: onDelete);
                          },
                          child: Icon(
                            Icons.delete,
                            color: kThemeOrangeColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            itemCount: palletCreationController.palletItemsList.length,
          ),
        ),
      ],
    );
  }
}
