
import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pico2/common/common_widgets.dart';
import 'package:pico2/common/events.dart';
import 'package:pico2/controller/pallet_creation_controller.dart';
import 'package:pico2/controller/search_controller.dart';
import 'package:pico2/models/pallet_items_model.dart';
import 'package:pico2/screens/edit_screen.dart';
import 'package:pico2/screens/search_screen.dart';
import 'package:pico2/theme/colors.dart';
import 'package:pico2/utils/constants.dart';
import 'package:pico2/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PalletCreationScreen extends StatefulWidget {
  const PalletCreationScreen({Key? key}) : super(key: key);

  @override
  State<PalletCreationScreen> createState() => _PalletCreationScreenState();
}

class _PalletCreationScreenState extends State<PalletCreationScreen> {
  final palletCreationController = Get.put(PalletCreationController());
  final searchController = Get.put(SearchController());

  var locationNode = FocusNode();
  var variantNode = FocusNode();
  var skuNode = FocusNode();
  var crateNode = FocusNode();

  var locationController = TextEditingController();
  var palletTextController = TextEditingController();
  var skuController = TextEditingController();
  var dateController = TextEditingController();
  var weightController = TextEditingController();
  bool scanned = false;

  var variantController = TextEditingController();

  String? barcodeScanResCrate;

  var skuData, variantData, palletData, locationData;
  int totalWeightSum = 0;
  int totalCratesSum = 0;

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
    if (!afterSave) index = Get.arguments['index'];
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
          appBar: getCommonAppBar(
            title: index == 0 ? 'Pallet Create' : 'Return Pallet',
            action: MaterialButton(
              color: kBlueColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () => onSave(),
              child: Text(
                index == 1 ? 'Update' : 'Save',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
                        child: InkWell(
                          onTap: () async {
                            locationData = await Get.to(() => SearchScreen(
                                  data: palletCreationController
                                          .palletCreationModel
                                          ?.data
                                          ?.locations ??
                                      [],
                                  hintText: 'Search Location',
                                ));
                            if (locationData != null) {
                              locationController.text = locationData.name;
                            }
                          },
                          child: IgnorePointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 8),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Search Location',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.normal),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              controller: locationController,
                              style: Get.textTheme.bodyText2
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            index == 0
                                ? Expanded(
                                    child: InkWell(
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
                                          palletCreationController
                                              .palletItemsList
                                              .clear();
                                          palletTextController.text =
                                              palletData.name;
                                          palletCreationController.update();
                                        }
                                      },
                                      child: IgnorePointer(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0, horizontal: 8),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: 'Search Pallet',
                                            hintStyle: const TextStyle(
                                                fontWeight: FontWeight.normal),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          controller: palletTextController,
                                          style: Get.textTheme.bodyText2
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  )
                                : const Offstage(),
                            SizedBox(width: index == 0 ? 8 : 0),
                            Expanded(
                              child: Center(
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  disabledColor: Colors.grey,
                                  color: kThemeOrangeColor,
                                  onPressed: onBarCodeScanPallet,
                                  height: 45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Scan Pallet Code'),
                                      SizedBox(width: 4),
                                      Icon(Icons.qr_code_2)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  skuData = await Get.to(() => SearchScreen(
                                        data: palletCreationController
                                                .palletCreationModel
                                                ?.data
                                                ?.skuCodes ??
                                            [],
                                        hintText: 'Search SKU',
                                      ));
                                  if (skuData != null) {
                                    skuController.text = skuData?.name ?? '';
                                  }
                                },
                                child: IgnorePointer(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 8),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Search SKU',
                                      hintStyle: const TextStyle(
                                          fontWeight: FontWeight.normal),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    controller: skuController,
                                    style: Get.textTheme.bodyText2
                                        ?.copyWith(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: <Widget>[
                                  TextFormField(
                                    controller: dateController,
                                    style: Get.textTheme.bodyText2
                                        ?.copyWith(color: kBlackColor),
                                    enabled: false,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        hintText: 'Enter Date',
                                        filled: true,
                                        fillColor: Colors.white),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: kBlueColor,
                                      ),
                                      onPressed: () async {
                                        DateTime selectedDate = DateTime.now();

                                        final DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: selectedDate,
                                                firstDate: DateTime(2015, 8),
                                                lastDate: DateTime(2101));
                                        if (pickedDate != null &&
                                            pickedDate != selectedDate) {
                                          setState(() {
                                            selectedDate = pickedDate;
                                            String dateFormat =
                                                DateFormat("dd-MM-yyyy")
                                                    .format(selectedDate);
                                            dateFormat =
                                                dateFormat.replaceAll("-", "");

                                            dateController.text = dateFormat;
                                          });
                                        }
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  variantData = await Get.to(() => SearchScreen(
                                        data: palletCreationController
                                                .palletCreationModel
                                                ?.data
                                                ?.variants ??
                                            [],
                                        hintText: 'Search Variant',
                                      ));
                                  if (variantData != null) {
                                    variantController.text =
                                        variantData?.name ?? "";
                                  }
                                },
                                child: IgnorePointer(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 8),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Search Variant',
                                      hintStyle: const TextStyle(
                                          fontWeight: FontWeight.normal),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    controller: variantController,
                                    style: Get.textTheme.bodyText2
                                        ?.copyWith(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                style: Get.textTheme.bodyText2
                                    ?.copyWith(color: kBlackColor),
                                controller: weightController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    fillColor: Colors.white,
                                    hintText: 'Enter Weight',
                                    filled: true,
                                    counterText: ''),
                                maxLength: 3,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: kBlueColor,
                                height: 45,
                                onPressed: onAddButtonPress,
                                child: const Text('Add'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.grey,
                                height: 45,
                                onPressed: () {},
                                // onPressed: onAddButtonPress,
                                child: const Text('Request Warehouse'),
                              ),
                            ),
                          ],
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        palletCreationController.palletItemsList.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(
                                      '$totalWeightSum kg/ 5 $totalCratesSum',
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.white)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Pallet: ' +
                                                (palletCreationController
                                                        .palletItemsList[index]
                                                        .palletName ??
                                                    ''),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: CupertinoColors.white),
                                          ),
                                          Text(
                                            'VAR: ' +
                                                (palletCreationController
                                                        .palletItemsList[index]
                                                        .variantName ??
                                                    ''),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'SKU: ${palletCreationController.palletItemsList[index].skuName ?? ''} dhjhdjsdhjshdjshdsjdhjshdsjhdsjdh',
                                            style: const TextStyle(
                                                color: Colors.white),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            'Weight: ${palletCreationController.palletItemsList[index].weight} Kg',
                                            style: const TextStyle(
                                                color: Colors.white),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${int.parse(palletCreationController.palletItemsList[index].weight ?? '0') / 20} C',
                                          maxLines: 1,overflow: TextOverflow.ellipsis,),

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
                                              titleText:
                                                  'Are you sure you want to delete?',
                                              successButtonText: 'Delete',
                                              successButtonFunction: () {
                                                setState(
                                                  () {
                                                    totalWeightSum -= int.parse(palletCreationController.palletItemsList[index].weight??'0');
                                                    palletCreationController
                                                        .palletItemsList
                                                        .removeAt(index);
                                                  },
                                                );
                                                Get.back();
                                              },
                                            );
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
                            itemCount:
                                palletCreationController.palletItemsList.length,
                          ),
                        ),
                      ],
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
    if (locationController.text == '') {
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
      'master_pallet_id':palletCreationController.palletDetailModel?.data!=null
          ? palletCreationController.palletDetailModel?.data?.masterPalletId
          : palletData.id,
      'location_id': locationData.id,
      'pallet_details': palletCreationIdList,
      'created_by': Constants.user.id.toString()
    };
    var store = await palletCreationController.storePalletCreation(
        palletDetails: finalBody, update: palletCreationController.palletDetailModel?.data!=null,
      id: palletCreationController.palletDetailModel?.data?.id.toString(),
    );
    if (store) {
      createToast('Successfully saved');
      init(afterSave: true);
    } else {
    }
  }

  resetValues() {
    palletCreationController.palletItemsList.clear();
    palletTextController.text = '';
    skuController.text = '';
    locationController.text = '';
    locationData = null;
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
    if (locationController.text == '') {
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
        palletId:  palletCreationController.palletDetailModel?.data?.masterPalletId
                .toString(),
        palletName: palletCreationController.palletDetailModel?.data==null
            ? palletData.name
            : palletCreationController
                .palletDetailModel?.data?.masterPallet?.name,
        batchNumber: locationData.abbr + dateController.text,
        skuId: skuData.id.toString(),
        skuName: skuData.name.toString(),
        date: dateController.text,
        weight: weightController.text,
        variantName: variantData.name.toString(),
        variantId: variantData?.id.toString(),
        locationId: locationData.id.toString(),
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
