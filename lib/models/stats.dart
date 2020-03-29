import 'package:corona/utils/utilities.dart';
import 'package:flutter/material.dart';

class Stats {
  final String name ;
  final String totalCases;
  final String totalDeaths;
  final String activeCases;
  final String recovered;
  final String newCases;
  final String newDeaths;
  final String seriousCritical;
  final List<Color> colors = GetGradientColor();

  Stats({this.name , this.totalCases,this.totalDeaths , this.activeCases, this.recovered , this.newCases, this.newDeaths , this.seriousCritical });

  Stats.fromJson( Map<String,dynamic>  data  )
    : name = data["name"],
    totalDeaths = data["totalDeaths"],
    totalCases = data["totalCases"],
    activeCases = data["active"],
    recovered = data["recovered"],
    newCases = data["newCases"],
    newDeaths = data["newDeaths"],
    seriousCritical = data["serious"];
      
}