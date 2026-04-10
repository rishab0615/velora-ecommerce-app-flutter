import 'package:amici/app/helper_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../theme/app_colors.dart';

class SubmitButtonHelper extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  const SubmitButtonHelper({super.key, required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.h),
              color: Colors.black.withOpacity(0.16),
            ),
          ),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 7.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.h)
                )),
            child: TextWidget(
                text: text ?? "",
                size: 14.sp,
                alignment: TextAlign.center,
                color: whiteColor,
                bold: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
