import 'package:pico2/utils/tools.dart';

class CrateDetailsForPalletModel {
  int? id;
  int? crateCodeId;
  int? skuCodeId;
  int? variantId;
  int? locationId;
  String? date;
  num? weight;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? batchNo;
  SkuCode? skuCode;
  SkuCode? variant;
  var location;
  PalletCrateCodeCreation? palletCrateCodeCreation;
  CrateCode? crateCode;

  CrateDetailsForPalletModel(
      {this.id,
      this.crateCodeId,
      this.skuCodeId,
      this.variantId,
      this.locationId,
      this.date,
      this.weight,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.batchNo,
      this.skuCode,
      this.variant,
      this.location,
      this.palletCrateCodeCreation,
      this.crateCode});

  CrateDetailsForPalletModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      crateCodeId = json['crate_code_id'];
      skuCodeId = json['sku_code_id'];
      variantId = json['variant_id'];
      locationId = json['location_id'];
      date = json['date'];
      weight = json['weight'];
      createdBy = json['created_by'];
      updatedBy = json['updated_by'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
      batchNo = json['batch_no'];
      skuCode =
          json['sku_code'] != null ? SkuCode.fromJson(json['sku_code']) : null;
      variant =
          json['variant'] != null ? SkuCode.fromJson(json['variant']) : null;
      location = json['location'];
      palletCrateCodeCreation = json['pallet_crate_code_creation'] != null
          ? PalletCrateCodeCreation.fromJson(json['pallet_crate_code_creation'])
          : null;
      crateCode = json['crate_code'] != null
          ? CrateCode.fromJson(json['crate_code'])
          : null;
    } catch (e, s) {
      printLog(e);
      printLog(s);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['crate_code_id'] = crateCodeId;
    data['sku_code_id'] = skuCodeId;
    data['variant_id'] = variantId;
    data['location_id'] = locationId;
    data['date'] = date;
    data['weight'] = weight;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['batch_no'] = batchNo;
    if (skuCode != null) {
      data['sku_code'] = skuCode!.toJson();
    }
    if (variant != null) {
      data['variant'] = variant!.toJson();
    }
    data['location'] = location;
    if (palletCrateCodeCreation != null) {
      data['pallet_crate_code_creation'] = palletCrateCodeCreation!.toJson();
    }
    if (crateCode != null) {
      data['crate_code'] = crateCode!.toJson();
    }
    return data;
  }
}

class SkuCode {
  int? id;
  String? name;

  SkuCode({this.id, this.name});

  SkuCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class PalletCrateCodeCreation {
  int? id;
  int? palletCreationId;
  int? crateCodeCreationId;
  String? createdAt;
  String? updatedAt;
  PalletCreation? palletCreation;

  PalletCrateCodeCreation(
      {this.id,
      this.palletCreationId,
      this.crateCodeCreationId,
      this.createdAt,
      this.updatedAt,
      this.palletCreation});

  PalletCrateCodeCreation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    palletCreationId = json['pallet_creation_id'];
    crateCodeCreationId = json['crate_code_creation_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    palletCreation = json['pallet_creation'] != null
        ? PalletCreation.fromJson(json['pallet_creation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pallet_creation_id'] = palletCreationId;
    data['crate_code_creation_id'] = crateCodeCreationId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (palletCreation != null) {
      data['pallet_creation'] = palletCreation!.toJson();
    }
    return data;
  }
}

class PalletCreation {
  int? id;
  int? locationId;
  int? palletId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  Pallet? pallet;

  PalletCreation(
      {this.id,
      this.locationId,
      this.palletId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.pallet});

  PalletCreation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['location_id'];
    palletId = json['pallet_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pallet = json['pallet'] != null ? Pallet.fromJson(json['pallet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['location_id'] = locationId;
    data['pallet_id'] = palletId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pallet != null) {
      data['pallet'] = pallet!.toJson();
    }
    return data;
  }
}

class Pallet {
  int? id;
  String? name;
  int? isEmpty;

  Pallet({this.id, this.name, this.isEmpty});

  Pallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isEmpty = json['is_empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['is_empty'] = isEmpty;
    return data;
  }
}

class CrateCode {
  int? id;
  String? name;
  String? type;
  int? isEmpty;
  String? state;

  CrateCode({this.id, this.name, this.type, this.isEmpty, this.state});

  CrateCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    isEmpty = json['is_empty'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['is_empty'] = isEmpty;
    data['state'] = state;
    return data;
  }
}
