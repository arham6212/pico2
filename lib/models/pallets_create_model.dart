class PalletsCreate {
  Data? data;

  PalletsCreate({this.data});

  PalletsCreate.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<MasterPallets>? masterPallets;
  List<SkuCodes>? skuCodes;
  List<Variants>? variants;
  List<Locations>? locations;

  Data({this.masterPallets, this.skuCodes, this.variants, this.locations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['masterPallets'] != null) {
      masterPallets = <MasterPallets>[];
      json['masterPallets'].forEach((v) {
        masterPallets!.add(MasterPallets.fromJson(v));
      });
    }
    if (json['skuCodes'] != null) {
      skuCodes = <SkuCodes>[];
      json['skuCodes'].forEach((v) {
        skuCodes!.add(SkuCodes.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
  }

}

class MasterPallets {
  int? id;
  String? name;
  int? isEmpty;

  MasterPallets({this.id, this.name, this.isEmpty});

  MasterPallets.fromJson(Map<String, dynamic> json) {
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

class SkuCodes {
  int? id;
  String? name;

  SkuCodes({this.id, this.name});

  SkuCodes.fromJson(Map<String, dynamic> json) {
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
class Variants {
  int? id;
  String? name;

  Variants({this.id, this.name});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}

class Locations {
  int? id;
  String? name;
  String? abbr;
  String? type;

  Locations({this.id, this.name, this.abbr, this.type});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    abbr = json['abbr'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['abbr'] = abbr;
    data['type'] = type;
    return data;
  }
}
