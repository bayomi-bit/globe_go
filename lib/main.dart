import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://pdykztyodxjvtsovxdgp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBkeWt6dHlvZHhqdnRzb3Z4ZGdwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzEwOTcwMjUsImV4cCI6MjA4NjY3MzAyNX0.F3KflfOG8DoKuQm2b1tsbu64AxiLyMyQjG3OGSOPWjg',
  );
  setupLocator();

  runApp(const GlobeGoApp());
}

class GlobeGoApp extends StatelessWidget {
  const GlobeGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 835),
      builder: (_, __) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
