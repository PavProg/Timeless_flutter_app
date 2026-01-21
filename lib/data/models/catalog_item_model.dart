class CatalogItemModel {
  final int id;
  final String name;
  final List<WeightOption> weightOptions;

  CatalogItemModel({
    required this.id,
    required this.name,
    required this.weightOptions,
  });

  factory CatalogItemModel.fromJson(Map<String, dynamic> json) {
    print('Получен JSON: $json');

    return CatalogItemModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] as String? ?? 'Без названия',
      weightOptions: (json['weight_options'] as List<dynamic>?)
        ?.map((opt) => WeightOption.fromJson(opt))
        .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight_options': weightOptions.map((opt) => opt.toJson()).toList(),
    };
  }
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

  factory WeightOption.fromJson(Map<String, dynamic> json) {
    return WeightOption(
      weight: json['weight'] as int,
      price: (json['price'] is int
      ? (json['price'] as int).toDouble()
      : json['price'] as double),
      quantity: json['quantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'price': price,
      'quantity': quantity,
    };
  }
}