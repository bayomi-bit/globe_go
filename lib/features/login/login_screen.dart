import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/theming/styles.dart';
import 'package:graduation/features/login/ui/widgets/login_form.dart';

import '../../core/routing/routes.dart';
import '../../core/theming/colors.dart';
import '../../core/widgets/app_login_button.dart';
import '../../core/widgets/dialog.dart';
import '../../core/widgets/loading_widget.dart';
import 'logic/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.lighterGray,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset("assets/images/fly_login.png")),
              Text(
                "Welcome Back",
                style: TextStyles.font36darkBlueBoldLemon.copyWith(
                  fontSize: 32.sp,
                ),
              ),
              Text(
                "Sign in to access your account",
                style: TextStyles.font14GrayRegular.copyWith(
                  fontSize: 12.sp,
                  color: ColorsManger.black,
                ),
              ),
              LoginForm(),
              SizedBox(height: 140.h),
              
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.h),
                child: AppLoginButton(onPressed: () {
                  context.read<LoginCubit>().login();
                }, buttonText: 'Login', backgroundColor: ColorsManger.darkBlue, textStyle: TextStyle(fontSize: 20.sp, color: ColorsManger.white),),
              ),
              RichText(
                text: TextSpan(
                  text: 'Don’t have an account? ',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go(Routes.register);
                        },
          
          
          
          
                      text: 'SignUp',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ],
                ),
              ),
          
              BlocListener<LoginCubit, LoginState>(
                child: Container(),
                listener: (context, state) {
                  if (state is LoginLoading) {
                    PrettyLoadingWidget();
                  }
                  if (state is LoginError) {
                    DialogManager.showErrorDialog(
                      context: context,
                      title: 'Error',
                      description: state.message,
                      onPress: () {
                        Navigator.pop(context);
                      },
                    );
                  }
                  if (state is LoginSuccess) {
                    DialogManager.showSuccessDialog(
                      context: context,
                      title: 'Success',
                      description: 'Login successful',
                      onPress: () {
                        context.go(Routes.home);
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
