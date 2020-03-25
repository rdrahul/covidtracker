import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class BrandSelector extends StatefulWidget {
  final List<String> brands;
  BrandSelector({@required this.brands});
  @override
  _BrandSelectorState createState() => _BrandSelectorState();
}

class _BrandSelectorState extends State<BrandSelector> {
  int currentIndex = 0;
  bool isSelected;
  List<Widget> _buildShoeBrands(){
     return widget.brands.map((brand){
       var index = widget.brands.indexOf(brand);
       isSelected = currentIndex == index;

       return Padding(
         padding: EdgeInsets.only( left : ScreenUtil().setWidth(70) ),
         child: GestureDetector(
           onTap: (){
             setState(() {
               currentIndex = index;
             });
           },
           child: Text(
             brand , style: 
             TextStyle(
               color:  isSelected ? Colors.black : Colors.grey,
               fontSize: isSelected ? 22 : 20,
               fontFamily: "Montserrat",
               fontWeight:  FontWeight.w700
               ),
           ),
         ),
       );
     }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
       children: _buildShoeBrands()
    );
  }
} 