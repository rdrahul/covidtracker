import 'package:corona/utils/profileclipper.dart';
import 'package:corona/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuidelinePage extends StatefulWidget {
  GuidelinePage({Key key}) : super(key: key);

  @override
  _GuidelinePageState createState() => _GuidelinePageState();
}

class _GuidelinePageState extends State<GuidelinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Color(0xff093ad2),

          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Header(),
                banner("5 Symptoms of Covid-19" , "assets/images/symptoms.png" , -4.0),
                symptoms(),
                Divider(color: Color(Purple) , thickness: 2, indent: 20, endIndent: 20 ),
                SizedBox(height: 20,),
                banner("Prevention from Covid-19" , "assets/images/prevention.png" , -10.0 ),
                prevention(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[tab("Symptoms"), tab("Prevention")],
                // ),
                Container(
                    child: Column(
                  children: <Widget>[],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tab(String name ) {
    bool selected = false;
    if ( name == "Symptoms"){
      selected = true;
    }
    return Container(
      margin: EdgeInsets.symmetric( horizontal : 8 , vertical : 24),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
                color: selected ? Colors.grey.shade300 : Colors.white,
                boxShadow: selected ? [
                      BoxShadow(
                          color: Colors.black45,
                          // offset: Offset(0, 4),
                          blurRadius: 26),
                      BoxShadow(
                          color: Colors.black26,
                          // offset: Offset(0, -3),
                          blurRadius: 20)
                    ] : [],
              ),
        
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(16),
              
              alignment: Alignment.center,
              child: Image.asset('assets/images/cdc.png' )),
          Text(name)
        ],
      ),
    );
  }

  Widget Header() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(30),
          bottom: ScreenUtil().setWidth(40)),
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
            "General Guidelines",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(62),
                color: Color(0xff0f2e81),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700),
          ),

          // IconButton(
          //   icon : Icon(Icons.menu),
          //   onPressed: ( ){},
          // ),
          // ClipOval(
          //     clipper: ProfileClipper(),
          //     child: Image.asset("assets/images/corona.jpeg",
          //         width: ScreenUtil().setWidth(120),
          //         height: ScreenUtil().setHeight(120),
          //         fit: BoxFit.cover)),
          // SizedBox(width: 30,),
        ],
      ),
    );
  }

  //"5 Symptoms of Covid-19"
  //"assets/images/symptoms.png"
  Widget banner( title , image, top ){
    return Container(
      margin: EdgeInsets.symmetric(horizontal :20, vertical :10 ),
       //Color(0xff0f2e81).withAlpha(100),
      width: double.infinity,
      height: ScreenUtil().setHeight(400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(background)
      ),
      child: Stack( 
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: top,
            left: -10.0,
            child: Image.asset(image , width: 150,)
          ),
          Container(
            width: 180,
            margin: EdgeInsets.only(left : 150),
            padding: EdgeInsets.only(top: 30 ),
            child: Text(title, style : 
              TextStyle(
                fontSize: ScreenUtil().setSp(62),
                color: Color(0xff0f2e81),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700
                )),
          )

        ],
      ),
      );
  }

  Widget symptoms(){
    List<dynamic> symps = [
      
      { "image":"assets/images/cough.png" , "title":"Dry Cough" },
      { "image":"assets/images/tiredness.png" , "title":"Tiredness" },
      { "image":"assets/images/breath.png" , "title":"Difficulty breathing" }, 
      { "image":"assets/images/fever.png" , "title":"Fever" },
    ];
    List<Widget> rowItems = symps.map( (item){
      return infoCard(item["image"] , item["title"]);
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.only(top:30,bottom:30),
      scrollDirection: Axis.horizontal,
      child: Row(children: rowItems)
    );
    

  }

  Widget infoCard( String image, String title){
    return 
      Container(
          margin: EdgeInsets.only(left:20),
          padding: EdgeInsets.only( top : 16 , left: 16, right : 16 , bottom:8),
          height: 200,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color : Color(background), width: 2),
            
            borderRadius: BorderRadius.circular(8)
           ),
          child : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(image, width: 100,height: 100, fit: BoxFit.contain),
          Padding(padding: EdgeInsets.only(top:20),
            child:           
            Text( title, style: TextStyle(
              fontSize: 20,
                color: Color(0xff0f2e81),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700
              ), ),
          ),

          // Text("headache ajks skjfs ajdasd fsfsafdsf sd the creafas.")
        ],) ,
        );
      
  
  }

  Widget prevention(){
    var prevs = [
      { "image" :"assets/images/mask.png" , "title" : "War mas", "description" :  "sdfasf asf dsfa sdf asf asdf asfsdf"},
      { "image" :"assets/images/mask.png" , "title" : "War mas", "description" :  "sdfasf asf dsfa sdf asf asdf asfsdf"},
      { "image" :"assets/images/mask.png" , "title" : "War mas", "description" :  "sdfasf asf dsfa sdf asf asdf asfsdf"}
      ];
    List<Widget> widg = prevs.map( (item) {
      return detailInfoCard();
    }).toList();
    return Container(margin: EdgeInsets.all(20) ,
      child: Column(children: widg,),
    );
  }

  Widget detailInfoCard(){
    return Row(
      
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
      Expanded(
        flex: 1,
        child: Image.asset("assets/images/mask.png" , width: 80, height: 80,),),
      Expanded(
        flex: 2,
        child: Container(
        height: 100,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        // height:MediaQuery.of(context).size.width * 0.9 ,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only( topRight : Radius.circular(8)  , bottomRight: Radius.circular(8)  ),
          
        ),
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Text("Wear Mask" , style: TextStyle( 
            fontFamily: FontFamily,
            fontWeight: FontWeight.w700,
            color: textColor , 
            fontSize: 24),),
          Text("Wear Mask at all the times"),
      ],),
      ),
      ),

    ],);
  }
}
