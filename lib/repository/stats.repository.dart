import 'dart:developer';

import 'package:corona/config/config.dart';
import 'package:corona/mocks.dart';
import 'package:corona/models/stats.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String , dynamic>> getStats() async {
  try{
    final String url = URL + '/all';
    final response = await http.get(url);
    List<Stats> allStats = [];
    if ( response.statusCode == 201){
      var responseBody = jsonDecode(response.body.replaceAll(new RegExp(r'"{'), '{').replaceAll(new RegExp(r'}"') , '}') );
      
      var items = responseBody["all"];
      for ( var i=0;i<items.length ;i++){
        allStats.add(Stats.fromJson(items[i]));
      }

      var total = responseBody["total"];
      total = Stats.fromJson(total);

      return { "all":allStats,  "total":total};

    }else{
       throw Exception('Failed to load Data');
    }
  }catch(err){
    log(err.toString());
    return { "all" : Statistics , "total" : Statistics[0]};
  }
}


Future<Map<String , dynamic>> getCountryWise(country) async {
  try{
    final String url = URL + '/country/' + country ;
    final response = await http.get(url);
    List<Stats> allStats = [];
    if ( response.statusCode == 201){
      var responseBody = jsonDecode(response.body.replaceAll(new RegExp(r'"{'), '{').replaceAll(new RegExp(r'}"') , '}') );
      
      var items = responseBody["all"];
      for ( var i=0;i<items.length ;i++){
        allStats.add(Stats.fromJson(items[i]));
      }

      var total = responseBody["total"];
      total = Stats.fromJson(total);

      return { "all":allStats,  "total":total};

    }else{
       throw Exception('Failed to load Data');
    }
  }catch(err){
    log(err.toString());
    return { "all" : [] , "total" :  null };
  }
}


