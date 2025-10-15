class CatalogItemModel {
  final String id;
  final String name;
  final List<WeightOption> weightOptions;

  CatalogItemModel({
     required this.id,
     required this.name,
     required this.weightOptions,
  });
}

class WeightOption {
  final int weight;
  final double price;
  int quantity;

  WeightOption({
    required this.weight,
    required this.price,
    this.quantity = 0,
  });
}