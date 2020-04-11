import 'dart:developer';

import 'package:corona/components/chart.dart';
import 'package:corona/components/herocard.dart';
import 'package:corona/components/statscard.dart';
import 'package:corona/models/stats.dart';
import 'package:corona/repository/stats.repository.dart';
import 'package:corona/utils/styles.dart';
import 'package:corona/utils/utilities.dart';
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
  Future<Map<String, dynamic>> futureStats;
  final Stats stats;
  
  _DetailsPageState(this.stats);

  @override
  void initState() {
    super.initState();
    futureStats = null;
    futureStats = getCountryWise(stats.name);
  
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              
              header(),
              Padding(
                padding: EdgeInsets.only( left : 20, top:20 ),
                child: totalCard( "All Cases",stats.totalCases  , Color(Purple) )
               ),
              pieRow(stats),
              

              Container( 
                height: 300,
                padding: EdgeInsets.all(2), child:FutureBuilder<Map<String, dynamic>>(
                  future: futureStats,
                  builder: displayStats,
                )),
            
          ],) ,
        ) 
        
      ),
    );
  }

  Widget pieRow(Stats stats){
    return Row(
      children: <Widget>[
      Expanded(flex: 1, 
        child: Container( 
                  padding: EdgeInsets.only(top : 16 , bottom :16),
                  height : ScreenUtil().setHeight(800),
                  child: StatsChartDonut(drawChart(stats)
                )
              ),
      ),
      Expanded(flex:1 , child : Container(
        child: Column(children: <Widget>[
          HeroCard( stats.activeCases , "Active" , Color(Purple) ),
          HeroCard(stats.totalDeaths , "Deaths" , Color(Red)),
          HeroCard(stats.recovered ,"Recovered" , Color(Yellow) )
        ],),
      ))
    ],
    );
  }


  // Widget stateWiseData( statesFuture ){
  //   return FutureBuilder<List<dynamic>>(
  //     future: statesFuture,
  //     builder: stateWiseListBuilder,
  //   );

  
  // }

    Widget displayStats(context, AsyncSnapshot snapshot) {
    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done ) {
      if ( snapshot.data["all"].length == 0 ){
        return notFound();
      }
      List<Stats> stats = snapshot.data["all"];
      
      log("Hererere");
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: stats.length,
        itemBuilder: (context, index) {
          Stats stat = stats[index];
          return Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(50),
                left: ScreenUtil().setWidth(50)),
            child: StatsCard(stats: stat, cardNum: index, gestureEnabled: false),
          );
        },
      );
    } else if (snapshot.hasError) {
      return notFound();
    }
    
    return Padding( 
      padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(50),
                left: ScreenUtil().setWidth(50)),
      child : 
      Container(
        width : 250 ,
        height : 50 ,  
        child : CircularProgressIndicator())
      )
      ;
  }

  Widget errorPlaceholder(){
    return Container(width: 150, height: 50,child: Text("Details not found"));
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(30),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            iconSize: 30,
            color: Color(0xff0f2e81),
            icon : BackButtonIcon(),
            onPressed: ( ){
              Navigator.pop(context);
            },
          ),
          Text(
            "${stats.name} ",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(62),
                color: Color(0xff0f2e81),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
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
        id: 'Cases',
        domainFn: (ChartData cases, _) => cases.label,
        measureFn: (ChartData cases, _) => cases.value,
        colorFn: (ChartData cases , _){
          if( cases.label == "Recovered" ){
            return charts.Color.fromHex(code:"#ffad3d");
          }else if ( cases.label == "Deaths"){
            return charts.Color.fromHex(code:"#ff5053");
          }else {
            return charts.Color.fromHex(code:"#544df3");
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

  Widget notFound(){
    return Container(
      width: double.infinity,
      height: 300,
      child: Column(children: <Widget>[
        Container(
          width: 80,
          height: 80,
          margin: EdgeInsets.only(top : 20,bottom : 20),
          decoration: BoxDecoration(
            color: Color(Purple),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(blurRadius: 8, 
              color:  Color(Purple).withAlpha(200)
              )
            ]
            ),
          padding: EdgeInsets.all(16),
          child: Image.asset("assets/images/coronicon.png")),
        Text( "Could not fetch details" ,style: TextStyle(
          fontFamily:FontFamily ,
          fontSize: 16,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w700
          ) ,)
        ],
      )
      ,);    
  }

  Widget totalCard(title , number , color ){
    return Container(
      
      margin: EdgeInsets.only(right : 40),
        width: double.infinity,
        // height: 100,
        
        
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color : color,
        ),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
          
          Text(
            FormatNumber(number),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 10,),
          Text(title , textAlign: TextAlign.left,
            style: TextStyle(
               fontSize: 16,
              color: Colors.white70,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
           ),
        ]));
  }


}

class ChartData{
  final String label ;
  final int value ;

  ChartData( this.label , this.value);
}