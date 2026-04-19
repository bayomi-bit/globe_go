import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/core/widgets/loading_widget.dart';
import 'open_ai.dart';

class ChatBotScreen extends StatefulWidget {
  final String apiKey;

  const ChatBotScreen({super.key, required this.apiKey});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  late GeminiService gemini;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    gemini = GeminiService(apiKey: widget.apiKey);
  }

  Future<void> sendMessage() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "content": text});
      controller.clear();
      loading = true;
    });

    final reply = await gemini.ask(text);

    setState(() {
      messages.add({"role": "assistant", "content": reply});
      loading = false;
    });
  }

  Widget bubble(Map<String, String> msg) {
    final isUser = msg["role"] == "user";

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg["content"]!,
          style: TextStyle(
            fontSize: 16,
            color: isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GlobeGo Assistant", style: TextStyle(color: Colors.white),),
        backgroundColor: ColorsManger.darkBlue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (_, i) => bubble(messages[i]),
            ),
          ),

          if (loading)
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w,vertical:  8.h),
              child: PrettyLoadingWidget(),
            ),

          Container(
            margin:  EdgeInsets.symmetric(horizontal: 5.w,vertical:  5.h),
            padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ask GlobeGo Assistant",
                    ),
                  ),
                ),
                 SizedBox(width: 8.w),
                IconButton(
                  onPressed: sendMessage,
                  icon:  Icon(Icons.send, size: 28.sp, color: ColorsManger.darkBlue,),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
