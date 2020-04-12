import 'package:corona/pages/guidelines.dart';
import 'package:corona/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Guidelines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(550),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GuidelinePage()));
          },
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setHeight(60),
                    vertical: ScreenUtil().setHeight(90)),
                padding: EdgeInsets.all(ScreenUtil().setWidth(60)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color( background )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("COVID Guidelines",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff0f2e81),
                            )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: ScreenUtil().setWidth(600),
                        child: Text("General Public Health Information",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xff0f2e81)
                                )))
                  ],
                ),
              ),
              Positioned(
                top: ScreenUtil().setWidth(10),
                right: ScreenUtil().setHeight(-60),
                child: Image.asset(
                  'assets/images/cdc.png',
                  width: ScreenUtil().setWidth(450),
                  height: ScreenUtil().setHeight(500),
                ),
              )
            ],
          ),
        ));
  }
}
