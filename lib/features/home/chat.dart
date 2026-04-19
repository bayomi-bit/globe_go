import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'open_ai.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
   String apiKey= "AIzaSyACRXhgzmlyW58PABl-zzs9fiY7gyjU7p4";
    return ChatBotScreen(apiKey: apiKey);
  }
}
