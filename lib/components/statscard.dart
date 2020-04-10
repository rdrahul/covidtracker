
import 'package:corona/models/stats.dart';
import 'package:corona/pages/details.page.dart';
import 'package:corona/utils/styles.dart';
import 'package:corona/utils/utilities.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatsCard extends StatelessWidget {
  final Stats stats;
  final int cardNum;
  const StatsCard({this.stats, this.cardNum});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(700),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(40),
                ),
                child: InkWell(
                                    
                  onTap: (){ 
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(stats: stats),
                        ), // opens the details page
                      );
                   },

                  child: Container(
                      width: ScreenUtil().setWidth(680),
                      height: ScreenUtil().setHeight(850),
                      decoration: BoxDecoration(
                        color : Colors.white,
                        // gradient: LinearGradient(
                        //     colors: stats.colors,
                        //     begin: Alignment.topRight,
                        //     end: Alignment.bottomLeft),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              color: Colors.black12,
                              offset: Offset(0, 4))
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: CardContents(stats)),
                ),
              )),
        ],
      ),
    );
  }

  Widget CardContents(Stats stats) {
    return Stack(
      
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(60),
              right: ScreenUtil().setWidth(60),
              top: ScreenUtil().setHeight(100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title(stats, cardNum),
                indicator(stats)
              ],
            ))
      ],
    );
  }

  Widget title(stats, number){
    return Row(children: <Widget>[
      Text("${number+1}. ${stats.name}",
                style: TextStyle(
                    color: textColor,
                    fontSize: ScreenUtil().setSp(60),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700)
      )
    ],);
  }



  Widget label(text, number){
    return Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(text , style : style() ),
        Text(FormatNumber(number) , style : numeric() ),
      ],
    );
  }


  Widget indicator( Stats stats){
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
                // padding: EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                    label("Total", stats.totalCases),
                    SizedBox(
                      height: 10,
                    ),
                    createIndicator( int.parse(stats.totalCases) , int.parse(stats.totalCases) , Color(0xff4384fe)),
                    SizedBox(
                      height: 30,
                    ),
                    label("Recovered" , stats.recovered ),
                    SizedBox(
                      height: 10,
                    ),
                    createIndicator(int.parse(stats.recovered), int.parse(stats.totalCases), Color(Yellow)),

                    SizedBox(
                      height: 30,
                    ),
                    label("Deaths" , stats.totalDeaths),
                    SizedBox(
                      height: 10,
                    ),
                    createIndicator(int.parse(stats.totalDeaths), int.parse(stats.totalCases), Color(Red))

                  ],
                ),
              );
  }

  LinearPercentIndicator createIndicator( int value, int total , Color color){
    double percent = double.parse((value / total).toStringAsFixed(2)) ;
    return LinearPercentIndicator(
                      width: 180.0,
                      lineHeight: 8.0,
                      percent: percent,
                      backgroundColor:color.withAlpha(20) ,
                      progressColor: color,
                    );
  }

  TextStyle style(){
    return TextStyle(
      fontSize: ScreenUtil().setSp(40),
      color: Colors.blue.shade900,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w700
    );
  }

  TextStyle numeric(){
    return TextStyle(fontSize: ScreenUtil().setSp(40),
      color: Colors.blue.shade900,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w500 );
  }
}
