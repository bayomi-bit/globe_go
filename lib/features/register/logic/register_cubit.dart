import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SupabaseClient supabase = Supabase.instance.client;

  RegisterCubit() : super(RegisterInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> signUp() async {
    if(!formKey.currentState!.validate()) return;

    emit(RegisterLoading());

    try {
      final AuthResponse response = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),

        data: {
          "name": nameController.text.trim(),
        },
      );

      if (response.user != null) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterError(message: "Registration failed"));
      }
    } catch (e) {
      emit(RegisterError(message: e.toString()));
    }
  }

  /// تسجيل دخول مستخدم
  // Future<void> login() async {
  //   emit(AuthLoading());
  //
  //   try {
  //     final AuthResponse response = await supabase.auth.signInWithPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );
  //
  //     if (response.session != null) {
  //       emit(AuthSuccess());
  //     } else {
  //       emit(AuthError(message: "Login failed"));
  //     }
  //   } catch (e) {
  //     emit(AuthError(message: e.toString()));
  //   }
  // }
}
