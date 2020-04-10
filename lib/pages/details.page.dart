import 'package:corona/components/chart.dart';
import 'package:corona/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsPage extends StatefulWidget {
  
  final Stats stats;
  DetailsPage({Key key , @required this.stats }) ;

  @override
  _DetailsPageState createState() => _DetailsPageState( this.stats );
}

class _DetailsPageState extends State<DetailsPage> {
  
  final Stats stats;
  
  _DetailsPageState(this.stats);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar( title: Text( widget.stats.name) 
      ),
      body: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top:16,left : 16 , bottom: 8),
              child: Text( "Total Cases",style: TextStyle(fontFamily: "Montserrat" , fontSize:20 ), ),
            ),
            Padding(padding: EdgeInsets.only(left:16, bottom:30),
                            child: Text( stats.activeCases ,style: TextStyle(fontFamily: "Montserrat" , fontSize:64 ), ),
            ),
            Padding(padding: EdgeInsets.only(left:16, bottom:10),
                            child: Text( "Case Wise Chart" ,style: TextStyle(fontFamily: "Montserrat" , fontSize:20 ), ),
            ),
            Card(
              margin : EdgeInsets.all(0.0),
              
              child : Container( 
                padding: EdgeInsets.only(top : 16 , bottom :16),
                height : ScreenUtil().setHeight(1000),
                child: StatsChartDonut(drawChart(stats)
              )
            ),
          ),

          Padding(padding: EdgeInsets.only(left:16, top:16),
                            child: Text( "City Wise Data - Coming Soon" ,style: TextStyle(fontFamily: "Montserrat" , fontSize:20 ), ),
          ),
          
        ],) ,
      ) 
      
    );
  }

  Widget stateWiseData( statesFuture ){
    return FutureBuilder<List<dynamic>>(
      future: statesFuture,
      builder: stateWiseListBuilder,
    );
  }

  //converts the stats into plottable data and returns the Chart.Series Method
  List<charts.Series<ChartData, String>> drawChart(Stats stats){
    var data = [
      new ChartData("Recovered", int.parse(stats.recovered)),
      new ChartData("Active", int.parse(stats.activeCases)),
      new ChartData("Deaths", int.parse(stats.totalDeaths)),

    ];
    return [
      new charts.Series<ChartData, String>(
        id: 'Sales',
        domainFn: (ChartData cases, _) => cases.label,
        measureFn: (ChartData cases, _) => cases.value,
        colorFn: (ChartData cases , _){
          if( cases.label == "Recovered" ){
            return charts.MaterialPalette.green.shadeDefault;
          }else if ( cases.label == "Deaths"){
            return charts.MaterialPalette.red.shadeDefault;
          }else {
            return charts.MaterialPalette.blue.shadeDefault;
          }
        },
        
        
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (ChartData row, _) => '${row.value}',
      )
    ];
  }

  
  /// Returns the list of the details state wise if available
  Widget stateWiseListBuilder( BuildContext context , snapshot){
    List<dynamic> data = snapshot.data;
    return ListView();
  }


}

class ChartData{
  final String label ;
  final int value ;

  ChartData( this.label , this.value);
}