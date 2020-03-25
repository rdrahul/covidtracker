import 'dart:developer';

import 'package:corona/models/stats.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

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
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(40),
                ),
                child: InkWell(
                                    
                  onTap: (){log("Tapped -- "); },
                  child: Container(
                      width: ScreenUtil().setWidth(680),
                      height: ScreenUtil().setHeight(1190),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: stats.colors,
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 0))
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: CardContents(stats)),
                ),
              )),
        ],
      ),
    );
  }

  Widget CardContents(stats) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: ScreenUtil().setHeight(50),
            left: ScreenUtil().setWidth(50),
            right: ScreenUtil().setWidth(50),
            child: Text("${stats.name}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(50),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700))),
        Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(100),
              top: ScreenUtil().setHeight(150),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SubHeading("Total Cases"),
                Stat("81,923"),
                SubHeading("Total Deaths"),
                Stat("3,303"),
                SubHeading("Total Recovered"),
                Stat("73,159"),
              ],
            ))
      ],
    );
  }

  Widget SubHeading(text) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(45)),
      child: Text(text,
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: ScreenUtil().setSp(55),
              fontWeight: FontWeight.w500,
              color: Colors.white)),
    );
  }

  Widget Stat(text) {
    return Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: ScreenUtil().setSp(110),
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 3.0),
        ));
  }
}
