import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';
import 'app_text_button.dart';


class AppLoginButton extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  const AppLoginButton({super.key, required this.onPressed , required this.buttonText, required this.backgroundColor, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Center(
        child: AppTextButton(
          buttonText: buttonText,
          backgroundColor: backgroundColor,
          borderRadius: 16.0.r,
          buttonHeight: 55.h,
          buttonWidth: 400.w,

          textStyle:textStyle?? TextStyles.font22WhiteNunito,
          onPressed: onPressed,
        ),
      ),
    );
  }
}