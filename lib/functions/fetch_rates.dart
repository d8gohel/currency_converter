import 'package:http/http.dart' as http;

import '../models/allcurrencies.dart';
import '../models/rates_model.dart';
import '../utils/key.dart';


Future<RatesModel> fetchRates()async{
  var responce = await http.get(Uri.parse('https://openexchangerates.org/api/latest.json?app_id='+key));
  final result = ratesModelFromJson(responce.body);
  return result;
}
Future<Map> fetchCurrencies()async{
  var responce = await http.get(Uri.parse('https://openexchangerates.org/api/currencies.json?app_id='));
  final allcurrency = allCurrenciesFromJson(responce.body);
  return allcurrency;
}

String convertUsd(Map exchangerates, String usd, String currency){
  String outPut = ((exchangerates[currency] * double.parse(usd)).toStringAsFixed(2)).toString();
  return outPut;
}

String convertAny(Map exchangeRates, dynamic amount, String currencyBase, String currencyFinal){
  String output = (double.parse(amount) / exchangeRates[currencyBase] * exchangeRates[currencyFinal]).toStringAsFixed(2).toString();
  return output;
}