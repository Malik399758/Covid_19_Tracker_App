import 'dart:convert';

import 'package:covid_19_app/Model/WorldStateModel.dart';
import 'package:covid_19_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart'as http;

class StatesServices{
  Future<WorldStateModel> fetchWorldStateapi() async {
    final response =await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);

    }else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> fetchCountriesapi() async {
    var data;
    final response =await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');
    }
  }
}