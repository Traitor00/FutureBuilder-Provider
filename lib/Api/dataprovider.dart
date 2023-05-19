import 'dart:convert';
import 'package:bbuilder/Modal/modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

//class to fetch data from given api
class DataProvider extends ChangeNotifier {
  Future<DataModel> fetchData() async {
    final url = 'https://api.nationalize.io/?name=nathaniel';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) //checking whether we got data or not
    {
      final jsonData = json.decode(response.body);
      final countryList = jsonData['country'];
      final name = jsonData['name'];

      List<Country> countries = [];

      for (var countryData in countryList) {
        final countryId = countryData['country_id'];
        final probability = countryData['probability'];

        Country country =
            Country(countryId: countryId, probability: probability);
        countries.add(country);
      }

      DataModel dataModel = DataModel(country: countries, name: name);

      return dataModel;
    } else {
      //error handling
      throw Exception('Failed to fetch data');
    }
  }
}
