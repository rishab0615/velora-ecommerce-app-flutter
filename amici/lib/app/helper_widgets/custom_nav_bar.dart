import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import 'hex_color.dart';

class CustomNavBarItem extends StatelessWidget {
  final String svg;
  final String selectedSvg;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  CustomNavBarItem({
    required this.svg,
    required this.label,
    required this.isSelected,
    required this.onTap, required this.selectedSvg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.5.h,
      padding: EdgeInsets.only(top: 1.4.h),

      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
             isSelected? selectedSvg.toString():svg.toString(),
              height: 3.h,
              color: isSelected?Colors.red: HexColor("#626262"),
            ),
            // SizedBox(height: 0.4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                color: HexColor("#626262"),
              ),
            ),

             // SizedBox(height: 0.3.h) ,
             SizedBox(height: 1.5.h,),


          ],
        ),
      ),
    );
  }
}




