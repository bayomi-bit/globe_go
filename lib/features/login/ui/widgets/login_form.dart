import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text_form_field.dart';
import '../../logic/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Form(
      key: cubit.formKey,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          spacing: 15,
          children: [
            AppTextFormField(
              controller: cubit.emailController,
              hintText: 'Email',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email!';
                }
                return null;
              },

              backgroundColor: Colors.grey.withOpacity(0.1),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(14.0.r),
              ),
              textInputType: TextInputType.emailAddress,
            ),
            AppTextFormField(
              controller: cubit.passwordController,
              hintText: 'Password',

              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },

              backgroundColor: Colors.grey.withOpacity(0.1),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(14.0.r),
              ),
              textInputType: TextInputType.visiblePassword,
            ),
          ],
        ),
      ),
    );
  }
}
