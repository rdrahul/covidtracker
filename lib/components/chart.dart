import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatsChartDonut extends StatelessWidget {

  final List<charts.Series> seriesList;
  final bool animate;

  const StatsChartDonut(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
      animate : animate ,
      behaviors: [new charts.DatumLegend()],
      
      defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 40,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]
          )
    );
  }
}