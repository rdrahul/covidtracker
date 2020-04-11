import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class HeroCard extends StatelessWidget {

  final String number;
  final String title;
  final Color color;
  HeroCard( this.number, this.title , this.color   );

  @override
  Widget build(BuildContext context) {
    return heroStatsCard(this.number, this.title, this.color);
  }

  Widget heroStatsCard(number, title , color ) {
    return Container(
        
        margin: EdgeInsets.only(top:10),
        width: 130,
        
        alignment: Alignment.centerLeft,
        
        padding: EdgeInsets.only(
            left: 10,
            top: ScreenUtil().setHeight(30),
            bottom: ScreenUtil().setHeight(30)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color : color,
        ),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          
          Text(
            number,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(47),
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
}