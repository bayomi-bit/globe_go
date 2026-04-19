import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/core/widgets/app_login_button.dart';
import 'package:graduation/core/widgets/dialog.dart';
import 'package:graduation/core/widgets/loading_widget.dart';
import 'package:graduation/features/register/ui/widgets/register_form.dart';

import '../../core/routing/routes.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/app_text_form_field.dart';
import 'logic/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.lighterGray,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(child: Image.asset("assets/images/fly.png")),
              Text(
                'Get Started',
                style: TextStyles.font36darkBlueBoldLemon.copyWith(
                  fontSize: 32.sp,
                ),
              ),
              Text(
                'Start opening your new acconut',
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
              RegisterForm(),
              SizedBox(height: 60.h),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 19,
                  vertical: 0,
                ),
                child: AppLoginButton(
                  onPressed: () {
                    context.read<RegisterCubit>().signUp();
                  },
                  buttonText: 'Sign Up',
                  backgroundColor: ColorsManger.darkBlue,

                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    color: ColorsManger.white,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Already have an account ',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go(Routes.login);
                        },




                      text: 'Login',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),
              BlocListener<RegisterCubit, RegisterState>(
                child: Container(),
                listener: (context, state) {
                  if (state is RegisterLoading) {
                    PrettyLoadingWidget();
                  }
                  if (state is RegisterError) {
                    DialogManager.showErrorDialog(
                      context: context,
                      title: 'Error',
                      description: state.message,
                      onPress: () {
                        Navigator.pop(context);
                      },
                    );
                  }
                  if (state is RegisterSuccess) {
                    DialogManager.showSuccessDialog(
                      context: context,
                      title: 'Success',
                      description: 'Registration successful',
                      onPress: () {
                        context.goNamed(Routes.home);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
