import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/theming/styles.dart';

import '../theming/colors.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final TextInputType? textInputType;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  final Function? onSaved;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.textInputType,
    this.prefixIcon,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.readOnly,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onSaved: onSaved as void Function(String?)?,
      keyboardType:textInputType ,

      readOnly: readOnly ?? false,
      controller: controller,

      decoration: InputDecoration(
        prefixIcon: prefixIcon,

        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManger.darkBlue,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(25.0.r),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(


              borderSide: BorderSide(
                color: ColorsManger.lightGray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(25.0.r),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintStyle: hintStyle ?? TextStyles.font14GrayRegular,
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? ColorsManger.moreLightGray,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyles.font14DarkBlueMedium,
      validator: (value) {
        return validator(value);
      },
    );
  }
}