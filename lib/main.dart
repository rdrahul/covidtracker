import 'package:corona/components/banner.dart';
import 'package:corona/repository/stats.repository.dart';
import 'package:corona/utils/profileclipper.dart';
import 'package:corona/utils/utilities.dart';
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
  Future<Map<String, dynamic>> futureStats;
  Stats totalStats;

  @override
  void initState() {
    super.initState();
    futureStats = null;
    futureStats = getStats();
    futureStats.then((val) => {
          setState(() => {totalStats = val["total"]})
        });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1125, height: 2436, allowFontScaling: true);
    return Scaffold(
      backgroundColor:  Color(0xfffdfdfd), //Colors.grey.shade200,
      body: SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Navbar(),
              Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(10),
                      right: ScreenUtil().setWidth(10),
                      top: ScreenUtil().setHeight(50),
                      bottom: ScreenUtil().setHeight(40)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(20), left : ScreenUtil().setWidth(60)),
                        // ---------- heading --------
                        child: Text("COVID-19",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(68),
                              color: Colors.black54,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            )),
                      ),

                      // ---------- First Row  --------
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                        children: <Widget>[
                              Row(
                        children: <Widget>[
                          
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(40),
                                  bottom: ScreenUtil().setHeight(40)),
                              child: heroStatsCard(
                                  totalStats != null
                                      ? FormatNumber(totalStats.totalCases)
                                      : "0",
                                  " Cases", Color(0xff544df3) ) ,   ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setHeight(40)),
                              child: heroStatsCard(
                                  totalStats != null
                                      ? FormatNumber(totalStats.totalDeaths)
                                      : "0",
                                  " Deaths" , Color(0xffff5053) )),
                          
                          Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setHeight(40)),
                              child: heroStatsCard(
                                  totalStats != null
                                      ? FormatNumber(totalStats.totalDeaths)
                                      : "0",
                                  " Recovered" , Color(0xffffad3d) )),
                                  


                        ],
                      ),


                          
                        ],
                      ),
                      ),

                      // ---------- Second Row  --------
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(50),
                      left: ScreenUtil().setWidth(70)),
                  child: statsRow("Statistics By Countries", "", fontSize: 50)),
              SizedBox(height: ScreenUtil().setHeight(20)),
              SizedBox(
                height: ScreenUtil().setHeight(1000),
                child: FutureBuilder<Map<String, dynamic>>(
                  future: futureStats,
                  builder: displayStats,
                ),
              ),
              Guidelines()
            ]),
      )),
    );
  }

  Widget heroStatsCard(number, title , color ) {
    return Container(
        margin: EdgeInsets.only(left : 10),
        width: 150,
        alignment: Alignment.centerLeft,
        
        padding: EdgeInsets.only(
            left: 10,
            top: ScreenUtil().setHeight(100),
            bottom: ScreenUtil().setHeight(100)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),


          //purrpl = 0xff544df3
          //red = 0xffff5053
          //yel = 0xffffad3d
          //background : 0xffe9e9ff

          color : color,
          // gradient: LinearGradient(colors: [
          //   Colors.grey.shade200,
          //   Colors.blue.shade200
          // ]),
          boxShadow: [BoxShadow(
                              blurRadius: 4,
                              color: color.withAlpha(200) ,
                              offset: Offset(0, 1)) 
          ],
        ),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          
          Text(
            number,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(67),
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(title , textAlign: TextAlign.left,
            style: TextStyle(
               fontSize: ScreenUtil().setSp(40),
              color: Colors.white70,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
           ),
        ]));
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
                left: ScreenUtil().setWidth(50)),
            child: StatsCard(stats: stat, cardNum: index),
          );
        },
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    // By default, show a loading spinner.
    return SizedBox(
        width: ScreenUtil().setHeight(50),
        height: ScreenUtil().setWidth(50),
        child: CircularProgressIndicator());
  }
}
