import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pico2/controller/pallet_creation_controller.dart';
import 'package:pico2/theme/colors.dart';
import 'package:pico2/widgets/added_pallet_item_widget.dart';
import 'package:pico2/widgets/button_widget.dart';
import 'package:pico2/widgets/weight_indicator_widget.dart';

class PalletListScreen extends StatelessWidget {
  const PalletListScreen({
    Key? key,
    required this.onSave,
    required this.buttonTitle,
    required this.onAddPallet,
  }) : super(key: key);

  final VoidCallback onSave;
  final VoidCallback onAddPallet;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<PalletCreationController>(
          builder: (palletCreationController) {
            if (palletCreationController.palletItemsList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.archive,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'You haven\'t added any pallets yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      color: kBlueColor,
                      onPressed: onAddPallet,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Add Pallet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  WeightSummaryWidget(weightsAdded: 97, totalWeight: 100),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      // reverse: true,
                      padding: EdgeInsets.zero,
                      itemCount:
                          palletCreationController.palletItemsList.length,
                      itemBuilder: (context, index) {
                        final pallet =
                            palletCreationController.palletItemsList[index];
                        return AddedPalletItemWidget(
                          index: index,
                          palletName: pallet.palletName ?? '',
                          variantName: pallet.variantName ?? '',
                          skuName: pallet.skuName ?? '',
                          weight: pallet.weight ?? '',
                          onSuccessfulDeletion: () {},
                        );
                      },
                    ),
                  ),
                  ButtonWidget(
                    icon: Icon(Icons.save),
                    onButtonPressed: onSave,
                    buttonLabel: buttonTitle,
                  ),
                  const SizedBox(height: 18),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
