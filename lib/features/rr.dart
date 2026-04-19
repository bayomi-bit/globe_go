import 'package:flutter/material.dart';
import 'package:graduation/core/theming/colors.dart';

// ============================================================
//  WelcomeBanner — ضعه فوق الـ AppBar في صفحة Trips
// ============================================================
//
//  الاستخدام:
//
//    Column(
//      children: [
//        WelcomeBanner(userName: 'أحمد', tripCount: 12),
//        // AppBar بتاعك
//        // باقي المحتوى
//      ],
//    )
//
// ============================================================

class WelcomeBanner extends StatelessWidget {
  final String userName;
  final int tripCount;
  final VoidCallback? onSearch;
  final VoidCallback? onFilter;

  const WelcomeBanner({
    super.key,
    this.userName = 'Welcome',
    this.tripCount = 0,
    this.onSearch,
    this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(

          fit: StackFit.expand,
          children: [
            // ① صورة الخلفية
            _buildPhoto(),

            // ② overlay أخضر داكن يمزج مع ألوان الشاشة
            _buildOverlay(),

            // ③ fade من الأسفل يربط البنر بالـ AppBar
            _buildFadeBottom(),

            // ④ المحتوى
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTopRow(),
                  _buildSearchBar(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── ① الصورة ────────────────────────────────────────────────
  Widget _buildPhoto() {
    return Image.network(
      'https://images.unsplash.com/photo-1539768942893-daf53e448371?w=800&q=80',
      fit: BoxFit.cover,
      alignment: const Alignment(0, -0.3),
      // ── لو حابب تستخدم صورة محلية بدل الـ network ──
      // استبدل Image.network بـ:
      // Image.asset('assets/images/egypt.jpg', fit: BoxFit.cover)
      errorBuilder: (_, __, ___) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A4A2E),
              Color(0xFF2D7A50),
              Color(0xFF1A3D28),
            ],
          ),
        ),
      ),
    );
  }

  // ── ② Overlay أخضر داكن ────────────────────────────────────
  Widget _buildOverlay() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x8C0F2314), // أخضر غابات داكن 55%
            Color(0x4D1E4632), // أخضر متوسط 30%
            Color(0xB80F2314), // أخضر داكن 72%
          ],
          stops: [0.0, 0.4, 1.0],
        ),
      ),
    );
  }

  // ── ③ Fade من الأسفل ────────────────────────────────────────
  Widget _buildFadeBottom() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Color(0xD90C1C12),
            ],
          ),
        ),
      ),
    );
  }

  // ── الصف العلوي: نص ترحيب + أفاتار ─────────────────────────
  Widget _buildTopRow() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // نص الترحيب
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome🌍',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xB8FFFFFF),
                  fontFamily: 'Cairo',
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    height: 1.2,
                    shadows: [
                      Shadow(
                        color: Color(0x660A1428),
                        blurRadius: 12,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  children: [
                    TextSpan(text: 'Discover '),
                    TextSpan(
                      text: 'Beauty',
                      style: TextStyle(color: Color(0xFF7EE8C0)),
                    ),
                    TextSpan(text: '\nEgypt'),
                  ],
                ),
              ),
            ],
          ),

          // أفاتار + badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.14),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.38),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text('🧭', style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(height: 7),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0x377EE8C0),
                  border: Border.all(color: const Color(0x807EE8C0)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$tripCount رحلة مكتملة',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF7EE8C0),
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── سيرش بار ─────────────────────────────────────────────────
  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: onSearch,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.96),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x450A1C12),
              blurRadius: 20,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              // أيقونة بحث
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A3D28),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF7EE8C0),
                  size: 16,
                ),
              ),
              const SizedBox(width: 9),

              // نصوص
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'اختار وجهتك',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF2D8A5E),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      'Where to next?',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF999999),
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),

              // زرار الفلتر
              GestureDetector(
                onTap: onFilter,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4F0),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: Color(0xFF1A3D28),
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
//  مثال كامل: صفحة Trips مع البنر
// ============================================================

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: Column(
        children: [

          // ① البنر الترحيبي مع الصورة
          WelcomeBanner(
            userName: 'أحمد',
            tripCount: 12,
            onSearch: () {
              debugPrint('Search tapped');
            },
            onFilter: () {
              debugPrint('Filter tapped');
            },
          ),

          // ② AppBar مخصص
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4F8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 14,
                      color: Color(0xFF1A2A3A),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Trips',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A2A3A),
                  ),
                ),
              ],
            ),
          ),

          // ③ باقي المحتوى
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: const [
                // ضع هنا كروت الرحلات المقترحة والشركات
              ],
            ),
          ),

        ],
      ),
    );
  }
}
























class MapBanner extends StatelessWidget {
  final VoidCallback? onTap;

  const MapBanner({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFE9E4F7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Explore on the map',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3C2E8A),
                    fontFamily: 'Cairo',
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Check out places near you',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF7B6FC0),
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color:  ColorsManger.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Open the map',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
