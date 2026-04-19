import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SupabaseClient supabase = Supabase.instance.client;
  LoginCubit() : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

Future<void> login() async {
  if(!formKey.currentState!.validate()) return;

  emit(LoginLoading());

  try {
    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (response.session != null) {
      emit(LoginSuccess());
    } else {
      emit(LoginError(message: "Login failed"));
    }
  } catch (e) {
    emit(LoginError(message: e.toString()));
  }
}
}
