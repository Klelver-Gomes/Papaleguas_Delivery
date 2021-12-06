class Address {
  late String _city;
  late String _street;
  late String _district;
  late int _number;
  late String _state;

  Address({
    String? city,
    String? street,
    String? district,
    int? number,
    String? state,
    //String? country,
  })
  {
    this._city = city ?? "";
    this._street = street ?? "";
    this._district = district ?? "";
    this._number = number ?? 0;
    this._state = state ?? "";
  }


  @override
  String toString() {
    return 'Address{_city: $_city, _street: $_street, _district: $_district, _number: $_number, _state: $_state}';
  }

  String get city => _city;
  set city(String value) => _city = value;

  String get street => _street;
  set street(String value) => _street = value;

  String get district => _district;
  set district(String value) => _district = value;

  int get number => _number;
  set number(int value) => _number = value;

  String get state => _state;
  set state(String value) => _state = value;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      street: json['street'],
      district: json['district'],
      number: json['number'],
      state: json['state'],
    );
  }
}
