import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pico2/common/common_widgets.dart';
import 'package:pico2/common/events.dart';
import 'package:pico2/controller/pallet_creation_controller.dart';
import 'package:pico2/controller/search_controller.dart';
import 'package:pico2/models/id_txt_model.dart';
import 'package:pico2/models/pallet_items_model.dart';
import 'package:pico2/screens/search_screen.dart';
import 'package:pico2/utils/constants.dart';
import 'package:pico2/widgets/custom_app_bar.dart';

import '../widgets/drop_pallete_button.dart';
import '../widgets/pallete_creation_bottom_widget.dart';
import '../widgets/save_button.dart';
import '../widgets/scan_pallet_code_button.dart';
import '../widgets/search_homw_widget.dart';

class PickingPalletReachTruckScreen extends StatefulWidget {
  const PickingPalletReachTruckScreen({Key? key}) : super(key: key);

  @override
  State<PickingPalletReachTruckScreen> createState() =>
      _PickingPalletReachTruckScreenState();
}

class _PickingPalletReachTruckScreenState
    extends State<PickingPalletReachTruckScreen> {
  final palletCreationController = Get.put(PalletCreationController());
  final searchController = Get.put(SearchController());

  var variantNode = FocusNode();
  var skuNode = FocusNode();
  var crateNode = FocusNode();

  var warehouseController = TextEditingController();
  var dropLocationController = TextEditingController();
  var palletTextController = TextEditingController();
  var skuController = TextEditingController();
  var dateController = TextEditingController();
  var weightController = TextEditingController();
  bool scanned = false;

  var variantController = TextEditingController();

  // 1.general
  // 2.A.1.1
  // 3.A.1.2
  // 4.A.2.1
  // 5.B.1.1
  // 6.B.1.2
  // 7.C.2.1
  // 8.C.2.2
  String? barcodeScanResCrate;
  List<IdTextModel> warehouseList = [
    IdTextModel('1', 'General'),
    IdTextModel('2', 'A.1.1'),
    IdTextModel('3', 'A.1.2'),
    IdTextModel('4', 'A.2.1'),
    IdTextModel('5', 'B.1.1'),
    IdTextModel('6', 'B.1.2'),
    IdTextModel('7', 'C.2.1'),
    IdTextModel('8', 'C.2.2'),
  ];
  var skuData, variantData, palletData, warehouseData, dropLocationData;
  int totalWeightSum = 0;

  late final int index;
  String updateId = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  dispose() {
    super.dispose();
    resetValues();
  }

  init({bool afterSave = false}) async {
    if (!afterSave) index = Get.arguments?['index'] ?? 0;
    getCurrentDate();
    resetValues();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await palletCreationController.getPalletCreate(toUpdate: !afterSave);
    });
  }

  getCurrentDate() {
    String dateFormat = DateFormat("dd-MM-yyyy").format(DateTime.now());
    dateFormat = dateFormat.replaceAll("-", "");
    dateController.text = dateFormat;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<PalletCreationController>(builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
              title: Get.arguments['appBarTitle'] ?? "",
              action: AnimatedButton(
                index: index,
                onSave: () => onSave(),
              )),
          body: palletCreationController.palletCreationModel == null
              ? Center(
                  child: LoadingAnimationWidget.bouncingBall(
                    color: Colors.white,
                    size: 100,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SearchHomeWidget(
                          textController: warehouseController,
                          onTap: () async {
                            warehouseData = await Get.to(() => SearchScreen(
                                  data: warehouseList,
                                  hintText: 'Search Warehouse',
                                ));
                            if (warehouseData != null) {
                              warehouseController.text = warehouseData.name;
                            }
                          },
                          label: 'Search Warehouse',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: SearchHomeWidget(
                                onTap: () async {
                                  palletData = await Get.to(
                                    () => SearchScreen(
                                      data: palletCreationController
                                              .palletCreationModel
                                              ?.data
                                              ?.masterPallets ??
                                          [],
                                      hintText: 'Search Pallets',
                                    ),
                                  );
                                  if (palletData != null) {
                                    scanned = false;
                                    palletCreationController.palletItemsList
                                        .clear();
                                    palletTextController.text = palletData.name;
                                    palletCreationController.update();
                                  }
                                },
                                textController: palletTextController,
                                label: 'Search Pallet',
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                                child: ScanPalletCodeButton(
                                    onTap: onBarCodeScanPallet)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SearchHomeWidget(
                          textController: dropLocationController,
                          onTap: () async {
                            dropLocationData = await Get.to(() => SearchScreen(
                                  data: warehouseList,
                                  hintText: 'Search Drop Location',
                                ));
                            if (dropLocationData != null) {
                              dropLocationController.text =
                                  dropLocationData.name;
                            }
                          },
                          label: 'Search Drop Location',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropPalletButton(
                          onTap: onAddButtonPress,
                        ),
                      )
                    ],
                  ),
                ),
          bottomSheet:
              KeyboardVisibilityBuilder(builder: (context, isKeyBoardVisible) {
            return isKeyBoardVisible
                ? const Offstage()
                : SizedBox(
                    height: Get.mediaQuery.size.height * 0.3,
                    child: PalletCreationBottomWidget(
                      onDelete: () {
                        setState(
                          () {
                            totalWeightSum -= int.parse(palletCreationController
                                    .palletItemsList[index].weight ??
                                '0');
                            palletCreationController.palletItemsList
                                .removeAt(index);
                          },
                        );
                        Get.back();
                      },
                      totalWeight: totalWeightSum.toString(),
                    ),
                  );
          }),
        );
      }),
    );
  }

  onSave() async {
    List<Map<String, dynamic>> palletCreationIdList = [];

    if (palletCreationController.palletItemsList.isEmpty) {
      return eventBus.fire(const EventErrorSheet(
          message: 'Please add pallets first before saving'));
    }
    if (warehouseController.text == '') {
      return eventBus
          .fire(const EventErrorSheet(message: 'Please select location'));
    }
    if (palletTextController.text == '') {
      return eventBus
          .fire(const EventErrorSheet(message: 'Please select pallets'));
    }
    if (totalWeightSum < 10) {
      return eventBus.fire(
          const EventErrorSheet(message: 'Should be more than or equal to 10'));
    }
    for (var element in palletCreationController.palletItemsList) {
      palletCreationIdList.add({
        'id': element.mainId,
        'sku_code_id': element.skuId,
        'weight': element.weight,
        'batch': element.batchNumber,
        'variant_id': element.variantId,
      });
    }
    Map<String, dynamic> finalBody = {
      'master_pallet_id':
          palletCreationController.palletDetailModel?.data != null
              ? palletCreationController.palletDetailModel?.data?.masterPalletId
              : palletData.id,
      'location_id': warehouseData.id,
      'pallet_details': palletCreationIdList,
      'created_by': Constants.user.id.toString()
    };
    var store = await palletCreationController.storePalletCreation(
      palletDetails: finalBody,
      update: palletCreationController.palletDetailModel?.data != null,
      id: palletCreationController.palletDetailModel?.data?.id.toString(),
    );
    if (store) {
      createToast('Successfully saved');
      init(afterSave: true);
    } else {}
  }

  resetValues() {
    palletCreationController.palletItemsList.clear();
    palletTextController.text = '';
    skuController.text = '';
    warehouseController.text = '';
    warehouseData = null;
    skuData = null;
    variantData = null;
    weightController.text = '';
    variantController.text = '';
  }

  void onAddButtonPress() {
    if (variantController.text == '') {
      return eventBus.fire(const EventErrorSheet(
          message: 'Please select variant before adding'));
    }
    if (weightController.text == '') {
      return eventBus.fire(
          const EventErrorSheet(message: 'Please select weight before adding'));
    }
    if (palletCreationController.palletItemsList.length == 10) {
      createToast('Pallets cannot be entered more than 10', error: true);
      return;
    }
    if (warehouseController.text == '') {
      createToast('Please enter location', error: true);
      return;
    }
    totalWeightSum = 0;
    for (var element in palletCreationController.palletItemsList) {
      totalWeightSum =
          totalWeightSum + (int.tryParse(element.weight ?? '0') ?? 0);
    }
    totalWeightSum = totalWeightSum + int.parse(weightController.text);
    if (totalWeightSum > 900) {
      totalWeightSum -= int.parse(weightController.text);
      createToast('Total weight could not be more than 900 kg', error: true);
      return;
    }

    /// todo: uncomment on production
    if (!scanned) {
      createToast('Please scan bar code ', error: true);
      return;
    }
    palletCreationController.palletItemsList.add(
      PalletItemsModel(
        palletId: palletCreationController
            .palletDetailModel?.data?.masterPalletId
            .toString(),
        palletName: palletCreationController.palletDetailModel?.data == null
            ? palletData.name
            : palletCreationController
                .palletDetailModel?.data?.masterPallet?.name,
        batchNumber: warehouseData.abbr + dateController.text,
        skuId: skuData.id.toString(),
        skuName: skuData.name.toString(),
        date: dateController.text,
        weight: weightController.text,
        variantName: variantData.name.toString(),
        variantId: variantData?.id.toString(),
        locationId: warehouseData.id.toString(),
        createdBy: Constants.user.id.toString(),
      ),
    );
    weightController.text = '';
    variantController.text = '';
    skuController.text = '';
    palletCreationController.update();
  }

  onBarCodeScanPallet() async {
    String palletFromBarCode;

    palletFromBarCode = await FlutterBarcodeScanner.scanBarcode(
      "#808080",
      "CANCEL",
      false,
      ScanMode.BARCODE,
    );

    if (palletFromBarCode != '-1') {
      scanned = true;
      if (!(validatePallet(palletFromBarCode))) {
        return eventBus.fire(const EventErrorSheet(
            message: 'The scanned barcode is not of pallet'));
      } else {
        palletTextController.text = palletFromBarCode;
        var palletDetails = await palletCreationController.getPalletDetails(
            palletName: palletFromBarCode);
        if (palletDetails) {
          palletCreationController.palletItemsList.clear();
          totalWeightSum = 0;
          palletCreationController.palletDetailModel?.data?.palletDetails
              .forEach((palletDetailItem) {
            totalWeightSum += palletDetailItem.weight ?? 0;

            palletCreationController.palletItemsList.add(PalletItemsModel(
              mainId: palletDetailItem.id.toString(),
              skuName: palletDetailItem.skuName ?? '',
              palletName: palletCreationController
                      .palletDetailModel?.data?.masterPallet?.name ??
                  '',
              palletId: palletDetailItem.palletId.toString(),
              variantName: palletDetailItem.variantName ?? "",
              skuId: palletDetailItem.skuCodeId.toString(),
              variantId: palletDetailItem.variantId.toString(),
              weight: palletDetailItem.weight.toString(),
              batchNumber: palletDetailItem.batch,
            ));
          });
          palletCreationController.update();
        }
      }
    }
  }
}
