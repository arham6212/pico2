import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pico2/common/common_widgets.dart';
import 'package:pico2/controller/pallet_creation_controller.dart';
import 'package:pico2/theme/colors.dart';

import 'search_screen.dart';

class EditScreen extends StatefulWidget {

  final int index;

  const EditScreen({
    Key? key,

    required this.index,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController skuController = TextEditingController(),
      weightController = TextEditingController(),
      variantController = TextEditingController();
  final PalletCreationController palletController = Get.find();
  var skuData, variantData;
  @override
  void initState() {
    super.initState();
    weightController.text =
        palletController.palletItemsList[widget.index].weight ?? '';
    skuController.text =
        palletController.palletItemsList[widget.index].skuName ?? '';
    variantController.text =
        palletController.palletItemsList[widget.index].variantName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCommonAppBar(title: 'Edit Pallet Sku'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Divider(color: Colors.white, height: 10),
            const SizedBox(height: 20),
            Text(
              'Pallet no. ${palletController.palletItemsList[widget.index].palletName}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text('SKU'),
            InkWell(
              onTap: () async {
           skuData   = await Get.to(() => SearchScreen(
                      data: palletController
                              .palletCreationModel?.data?.skuCodes ??
                          [],
                      hintText: 'Search SKU',
                    ));
                if (skuData != null) {
                  skuController.text = skuData?.name ?? "";
                }
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: skuController,
                  decoration: const InputDecoration(
                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Edit SKU',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Variant'),
                      InkWell(
                        onTap: () async {
                           variantData = await Get.to(() => SearchScreen(
                                data: palletController
                                        .palletCreationModel?.data?.variants ??
                                    [],
                                hintText: 'Search Variant',
                              ));
                          if (variantData != null) {
                            variantController.text = variantData?.name ?? "";
                          }
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: variantController,
                            decoration: const InputDecoration(
                                hintText: 'Edit Variant',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Weight'),
                      TextFormField(
                        controller: weightController,
                        decoration: const InputDecoration(
                            hintText: 'Edit Weight',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              child: MaterialButton(
                onPressed: () {
                  palletController.palletItemsList[widget.index].weight = weightController.text;

                  if(variantData!=null) {
                    palletController.palletItemsList[widget.index].variantId =
                        variantData.id.toString();
                    palletController.palletItemsList[widget.index].variantName = variantData.name;
                  }
                  if(skuData!=null) {
                    palletController.palletItemsList[widget.index].skuName =
                        skuData.name;
                    palletController.palletItemsList[widget.index].skuId =
                        skuData.id.toString();
                  }
                  palletController.update();
                  Get.back();
                },
                child: const Text('Update'),
                color: kBlueColor,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
