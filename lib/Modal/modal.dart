class DataModel {
  List<Country> country;
  String name;

  DataModel({required this.country, required this.name});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> countryList = json['country'];
    List<Country> parsedCountryList =
        countryList.map((item) => Country.fromJson(item)).toList();

    return DataModel(
      country: parsedCountryList,
      name: json['name'],
    );
  }
}

class Country {
  String countryId;
  double probability;

  Country({required this.countryId, required this.probability});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryId: json['country_id'],
      probability: json['probability'].toDouble(),
    );
  }
}
