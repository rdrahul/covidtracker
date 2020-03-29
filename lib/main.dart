import 'package:corona/repository/stats.repository.dart';
import 'package:corona/utils/profileclipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/statscard.dart';

import 'models/stats.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CoronaTracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(child: MyHomePage(title: 'CovidTracker Home Page')));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Map<String,dynamic>> futureStats;
  Stats totalStats;

  @override
  void initState() {
    super.initState();
    futureStats = null;
    futureStats = getStats();
    futureStats.then( (val) => {
      setState( () => {
        totalStats = val["total"]
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1125, height: 2436, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Navbar(),
            Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(70),
                    right: ScreenUtil().setWidth(10),
                    top: ScreenUtil().setHeight(100),
                    bottom: ScreenUtil().setHeight(140)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
                      // ---------- heading -------- 
                      child: Text("COVID-19",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(102),
                            color: Colors.black54,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                          )),
                    ),

                    // ---------- First Row  --------
                    Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(40),
                            bottom: ScreenUtil().setHeight(40)),
                        child: statsRow(
                          totalStats != null ? totalStats.totalCases : "0",
                          "Total Cases",
                        )),

                    // ---------- Second Row  --------
                    Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                        child:
                            statsRow(
                              totalStats != null ? totalStats.totalDeaths : "0",
                               "Total Deaths", fontSize: 130)),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                    left: ScreenUtil().setWidth(70)),
                child: statsRow("Statistics By Countries", "", fontSize: 50)),
            SizedBox(height: ScreenUtil().setHeight(50)),
            SizedBox(
              height: ScreenUtil().setHeight(1100),
              child: FutureBuilder<Map<String, dynamic>>(
                future: futureStats,
                builder: displayStats,
              ),
            )
          ])),
    );
  }

  Widget statsRow(String number, String title, {int fontSize = 150}) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: <Widget>[
        Text(number,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(fontSize),
              color: Colors.black,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            )),
        Text(title,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(52),
              color: Colors.black,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }

  Widget Navbar() {
    return Container();
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(80),
          left: ScreenUtil().setWidth(40),
          right: ScreenUtil().setWidth(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "COVID-19",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(102),
                color: Colors.black54,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700),
          ),

          // IconButton(
          //   icon : Icon(Icons.menu),
          //   onPressed: ( ){},
          // ),
          ClipOval(
              clipper: ProfileClipper(),
              child: Image.asset("assets/images/corona.jpeg",
                  width: ScreenUtil().setWidth(120),
                  height: ScreenUtil().setHeight(120),
                  fit: BoxFit.cover)),
          // SizedBox(width: 30,),
        ],
      ),
    );
  }

  /**
   * The Statistics Wrapper 
   * Supplies Data to Listview and Renders the StatsCard
   */
  Widget displayStats(context, snapshot) {
    if (snapshot.hasData) {
      List<Stats> stats = snapshot.data["all"];
      

      return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: stats.length,
        itemBuilder: (context, index) {
          Stats stat = stats[index];
          return Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(50),
                left: ScreenUtil().setWidth(100)),
            child: StatsCard(stats: stat, cardNum: index),
          );
        },
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    // By default, show a loading spinner.
    return  SizedBox( 
      width: ScreenUtil().setHeight(50), 
      height: ScreenUtil().setWidth(50), 
      child: CircularProgressIndicator()) ;
  }

  //Formats the number with commas
  //3445456 => 3,445,456
  String FormatNumber(String number){
    String formatted = "";
    int len = number.length;
    for( var i=0;i<len;i--){
      if ( len -i % 3 == 0){
        formatted += ',';
      }
      formatted += number[i];
    }
    return formatted;
  }
}
