import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey;

  GeminiService({required this.apiKey});

  /// 🔥 إرسال رسالة إلى Gemini
  Future<String> ask(String message, {String modelName = "gemini-3-flash-preview"}) async {
    try {
      // تعديل: يفضل تعريف الـ Model مرة واحدة أو التأكد من الإصدار
      final generativeModel = GenerativeModel(
        model: modelName,
        apiKey: apiKey,
        // إضافة هذا السطر تحل مشكلة "Not Found" في أغلب الأحيان
      );

      final content = [Content.text(message)];
      final response = await generativeModel.generateContent(content);

      return response.text ?? "⚠️ No response from model.";
    } catch (e) {
      // طباعة الخطأ في الكونسول للمطور للمساعدة في التتبع
      print("Gemini Error: $e");
      return "❌ Error communicating with Gemini:\n$e";
    }
  }

  /// 🔥 جلب الموديلات المتاحة لمفتاح الـ API الخاص بك
}