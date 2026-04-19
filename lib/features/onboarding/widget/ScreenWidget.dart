import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/theming/styles.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../onboarding_screen.dart';

class ScreenWidget extends StatelessWidget {
  final PageController controller;
  final int current;
  final String image;
  final String title;
  final String subTitle;

  const ScreenWidget({
    super.key,
    required this.controller,
    required this.current,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(60),
        Center(
          child: Text("GlobeGo", style: TextStyles.font36darkBlueBoldLemon),
        ),
        verticalSpace(100),
        Image.asset(image, width: 170.w, height: 188.h),
        verticalSpace(100),
        Padding(
          padding: EdgeInsets.only(right: 80.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyles.font36darkBlueBoldLemon.copyWith(
                  fontSize: 24.sp,
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 10.sp,

                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lemon',
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                spacing: 3,
                children: [
                  buildDot(current == 0 ? true : false),
                  buildDot(current == 1 ? true : false),
                  buildDot(current == 2 ? true : false),

                  GestureDetector(
                    onTap: () {
                      controller.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorsManger.darkBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.navigate_next,
                        color: ColorsManger.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
