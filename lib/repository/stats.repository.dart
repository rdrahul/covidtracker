import 'dart:developer';

import 'package:corona/config/config.dart';
import 'package:corona/mocks.dart';
import 'package:corona/models/stats.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Stats>> getStats() async {
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
      return allStats;
    }else{
       throw Exception('Failed to load Data');
    }
  }catch(err){
    log(err.toString());
    return Statistics;
  }


}