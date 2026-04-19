import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/features/onboarding/widget/ScreenWidget.dart';

import '../../core/routing/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  int current = 0;
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.lightBlue,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: PageView(
          controller: controller,
          onPageChanged: (i) {
            setState(() {
              current = i;
              isLast = (current == 2);
            });

            if (isLast) {
              Future.delayed(const Duration(milliseconds: 200), () {
                context.go(Routes.register);
              });
            }
          },

          children: [
            ScreenWidget(
              controller: controller,
              current: current,
              image: "assets/images/onbording1.png",
              title: "Explore the world \nhassle-free",
              subTitle: "Unlock the world with a tap",
            ),
            ScreenWidget(
              controller: controller,
              current: current,
              image: "assets/images/onbording2.png",
              title: "Navigate the world\nthe easy way",
              subTitle: "Explore more. Worry less.",
            ),
            ScreenWidget(
              controller: controller,
              current: current,
              image: "assets/images/onbording3.png",
              title: "Travel the world \neffortlessly",
              subTitle: "Plan, book, and explore — the easy way",
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildDot(bool active) {
  return Container(
    width: 16.w,
    height: 4.h,
    decoration: BoxDecoration(
      color: active ? const Color(0xff1C3C78) : const Color(0xffB3C0D1),
      borderRadius: BorderRadius.circular(20.r),
    ),
  );
}
