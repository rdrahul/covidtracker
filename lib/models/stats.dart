import 'package:corona/utils/utilities.dart';
import 'package:flutter/material.dart';

class Stats {
  final String name ;
  final String totalCases;
  final String activeCases;
  final String recovered;
  final String newCases;
  final String newDeaths;
  final String seriousCritical;
  final List<Color> colors = GetGradientColor();

  Stats({this.name , this.totalCases, this.activeCases, this.recovered , this.newCases, this.newDeaths , this.seriousCritical });

}