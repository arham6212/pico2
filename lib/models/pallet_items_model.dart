class PalletItemsModel {
   String? palletId,
  mainId,
      palletName,
      variantId,
      variantName,
      locationId,
      weight,
  skuName,
      skuId,
      date,
      createdBy,
  batchNumber,
      updatedBy;

  PalletItemsModel( {
      this.skuName,
      this.mainId,this.batchNumber,
      this.palletName,
      this.variantName,
      this.skuId,
      this.palletId,
      this.variantId,
      this.locationId,
      this.weight,
      this.date,
      this.createdBy,
      this.updatedBy});
}
