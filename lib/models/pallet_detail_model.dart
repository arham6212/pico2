class PalletDetailModel {
  Data? data;

  PalletDetailModel({this.data});

  PalletDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? id;
  int? masterPalletId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  MasterPallet? masterPallet;
  List<PalletDetails>palletDetails=[];

  Data(
      {this.id,
        this.masterPalletId,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.masterPallet,
        required this.palletDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    masterPalletId = json['master_pallet_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    masterPallet = json['master_pallet'] != null
        ? MasterPallet.fromJson(json['master_pallet'])
        : null;
    if (json['pallet_details'] != null) {
      palletDetails = [];
      json['pallet_details'].forEach((v) {
        palletDetails.add(PalletDetails.fromJson(v));
      });
    }
  }

}

class MasterPallet {
  int? id;
  String? name;
  int? isEmpty;

  MasterPallet({this.id, this.name, this.isEmpty});

  MasterPallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isEmpty = json['is_empty'];
  }

}

class PalletDetails {
  int? id;
  int? palletId;
  int? skuCodeId;
  int? variantId;
  int? weight;
  String? batch;
  String?skuName ;
  String?variantName ;
  String? createdAt;
  String? updatedAt;

  PalletDetails(
      {this.id,
        this.palletId,
        this.skuCodeId,
        this.variantId,
        this.weight,
        this.batch,
        this.skuName ,
        this.variantName ,

        this.createdAt,
        this.updatedAt});

  PalletDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    palletId = json['pallet_id'];
    skuName = json['sku_code']['name'];
    skuCodeId = json['sku_code_id'];
    variantName = json['variant']['name'];
    variantId = json['variant_id'];
    weight = json['weight'];
    batch = json['batch'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pallet_id'] = palletId;
    data['sku_code_id'] = skuCodeId;
    data['variant_id'] = variantId;
    data['weight'] = weight;
    data['batch'] = batch;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
