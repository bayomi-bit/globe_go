import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class TextStyles{
static final TextStyle font36darkBlueBoldLemon=TextStyle(
    fontSize: 36.sp,
    color: ColorsManger.darkBlue,
    fontWeight: FontWeight.bold,
    fontFamily: 'Lemon'


);
static TextStyle font14GrayRegular = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  color: ColorsManger.gray,
);
static TextStyle font14DarkBlueMedium = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
  color: ColorsManger.darkBlue,
);
static final TextStyle  font22WhiteNunito =  TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 22.sp,
    color: ColorsManger.white);

}