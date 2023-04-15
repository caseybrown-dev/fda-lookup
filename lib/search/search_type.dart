enum SearchType {
  brandName(displayName: 'Brand Name', param: 'brand_name'),
  genericName(displayName: 'Generic Name', param: 'generic_name'),
  ndc11(displayName: 'NDC11', param: 'packaging.package_ndc'),
  ndc9(displayName: 'NDC9', param: 'product_ndc');

  const SearchType({required this.displayName, required this.param});
  final String displayName;
  final String param;
}
