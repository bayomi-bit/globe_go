import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DialogManager {
  static void showSuccessDialog({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onPress,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: title,
      desc: description,
      btnOkOnPress: onPress,
      btnOkColor: Colors.green,

      headerAnimationLoop: false, // Prevent looping animation
    ).show();
  }

  static void showErrorDialog({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onPress,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: title,
      desc: description,
      btnOkOnPress: onPress,
      btnOkColor: Colors.red,
      headerAnimationLoop: false, // Prevent looping animation
    ).show();
  }
}