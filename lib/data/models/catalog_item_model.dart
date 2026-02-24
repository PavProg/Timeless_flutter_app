// ==================== WeightOption ====================
class WeightOption {
  final int id;           // уникальный ID конкретного товара (варианта)
  final int weight;
  final double price;
  int quantity;           // количество на складе

  WeightOption({
    required this.id,
    required this.weight,
    required this.price,
    this.quantity = 0,
  });

  factory WeightOption.fromJson(Map<String, dynamic> json) {
    return WeightOption(
      id: json['id'] as int,
      weight: json['weight'] as int,
      price: (json['price'] as num).toDouble(),
      quantity: json['numbers'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'price': price,
      'numbers': quantity,
    };
  }
}

// ==================== CatalogItemModel ====================

class CatalogItemModel {
  final int id;
  final String name;
  final List<WeightOption> weightOptions; // все варианты веса
  final String brand;
  final String supplier;

  CatalogItemModel({
    required this.id,
    required this.name,
    required this.weightOptions,
    this.brand = '',
    this.supplier = '',
  });

  factory CatalogItemModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final aroma = json['aroma'] as String? ?? '';
    final brand = json['brand'] as String? ?? '';
    final supplier = json['supplier'] as String? ?? '';
    final weight = json['weight'] as int;
    final price = (json['price'] as num).toDouble();
    final numbers = json['numbers'] as int? ?? 0;

    // Создаём один вариант веса
    final weightOption = WeightOption(
      id: id,
      weight: weight,
      price: price,
      quantity: numbers,
    );

    return CatalogItemModel(
      id: id,
      name: aroma,
      weightOptions: [weightOption],
      brand: brand,
      supplier: supplier,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aroma': name,
      'brand': brand,
      'supplier': supplier,
      'weight_options': weightOptions.map((opt) => opt.toJson()).toList(),
    };
  }
}