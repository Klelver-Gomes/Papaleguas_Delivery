class Product {
  late String _name;
  late double _price;
  late String _description;
  late String _imageName;


  Product({
    required String nome,
    required double price,
    required String description,
    required String imageName,

  }) {
    this._name = nome;
    this._price = price;
    this._description = description;
    this._imageName = imageName;
  }

  String get name => _name;
  set name(String value) => _name = value;

  String get description => _description;
  set description(String value) => _description = value;

  double get price => _price;
  set price(double value) => _price = value;

  String get imageName => _imageName;
  set imageName(String value) => _imageName = value;


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      nome: json['name'],
      price: json['price'],
      description: json['description'],
      imageName: json['imageName'],

    );
  }

}
