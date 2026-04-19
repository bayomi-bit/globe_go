import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/core/theming/styles.dart';
import 'package:graduation/core/widgets/app_text_form_field.dart';
import 'package:graduation/features/home/icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/routing/routes.dart';
import '../test.dart';

class _NavItem {
  const _NavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // ensures the tap area includes gaps
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // Pill highlight only for the active tab.
          color: isActive ? AppColors.primaryLight : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: 22,
              color: isActive ? AppColors.primary : AppColors.textLight,
            ),
            const SizedBox(height: 3),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedDestination;
  int _selectedNav = 0;


  static const List<_NavItem> _navItems = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.explore_rounded, label: 'Explore'),
    _NavItem(icon: Icons.calendar_month_rounded, label: 'Plan'),
    _NavItem(icon: Icons.person_rounded, label: 'Profile'),
  ];
  Widget _buildScrollBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _HeroBanner(),
          const SizedBox(height: 24),
          _SearchBar(),
          const SizedBox(height: 28),
          _buildSectionHeader(),
          const SizedBox(height: 16),
          _buildDestinationGrid(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: 12,
        // Respect the device's home-indicator area.
        bottom: MediaQuery.of(context).padding.bottom + 12,
        left: 10,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_navItems.length, (i) {
          final isActive = _selectedNav == i;
          return _NavButton(
            item: _navItems[i],
            isActive: isActive,
            onTap: () => setState(() {
              _selectedNav = i;
              context.push(Routes.trips);
            } ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Force dark status-bar icons so they're readable over the light bg.
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.bg,
        body: Column(
          children: [
            _AppBar(),
            Expanded(child: _buildScrollBody()),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     bottomNavigationBar:   ConvexAppBar(
  //         style: TabStyle.react,
  //         color:  ColorsManger.lightGray,
  //         backgroundColor: ColorsManger.white,
  //         activeColor: ColorsManger.blue,
  //
  //         initialActiveIndex: 0,
  //         onTap: (index) {
  //           switch (index) {
  //             case 0:
  //               context.push(Routes.home);
  //               break;
  //             case 1:
  //               context.push(Routes.egyptScreen);
  //
  //               break;
  //             case 2:
  //               break;
  //             case 3:
  //               context.push(Routes.trips);
  //               break;
  //
  //           }
  //
  //         },
  //         items: [
  //           TabItem(icon:FontAwesomeIcons.home),
  //           TabItem(icon: FontAwesomeIcons.heart),
  //           TabItem(
  //             icon:FontAwesomeIcons.clock,
  //           ),
  //           TabItem(icon: FontAwesomeIcons.truckPlane),
  //         ]),
  //     backgroundColor: ColorsManger.lightBlue,
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           spacing: 30,
  //           children: [
  //             Expanded(child: _buildScrollBody()),
  //             _buildBottomNav(),
  //
  //
  //           ],
  //         ),
  //       ),
  //     ),
  //
  //   );
  // }
  Widget _buildDestinationGrid() {
    return GridView.builder(
      // Grid is inside a scroll view, so we disable its own scrolling.
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: kDestinations.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        // Slightly taller than wide to fit image + label.
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        final destination = kDestinations[index];
        final isSelected = _selectedDestination == index;

        return _DestinationCard(
          destination: destination,
          isSelected: isSelected,
          onTap: () => setState(() {
            // Toggle selection: tap again to deselect.
            _selectedDestination = isSelected ? null : index;
            context.push(Routes.places,extra: destination.name);
          }),
        );
      },
    );
  }

}
class _DestinationCard extends StatelessWidget {
  const _DestinationCard({
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final Destination destination;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          // Highlight border appears only when selected.
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.18)
                  : Colors.black.withOpacity(0.07),
              blurRadius: isSelected ? 16 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Photo section (takes most of the card height)
            Expanded(child: _buildPhoto()),
            // ── Text section (name + visitors)
            _buildLabel(),
          ],
        ),
      ),
    );
  }

  /// Clipped network image with a category tag overlay and an optional
  /// checkmark badge when the card is selected.
  Widget _buildPhoto() {
    return Stack(
      children: [
        // Main photo
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            destination.imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            // Show a light-blue shimmer while the image loads.
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return Container(
                color: AppColors.primaryLight,
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: AppColors.primary,
                  ),
                ),
              );
            },
          ),
        ),

        // Category tag pill (top-left)
        Positioned(
          top: 6,
          left: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
            decoration: BoxDecoration(
              color: destination.tagColor.withOpacity(0.92),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              destination.tag,
              style: const TextStyle(
                fontSize: 8,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),

        // Checkmark badge — only visible when selected (top-right)
        if (isSelected)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  /// Name headline and visitor count shown below the photo.
  Widget _buildLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 7, 8, 8),
      child: Column(
        children: [
          Text(
            destination.name,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              // Turn blue when selected for visual continuity with the border.
              color: isSelected ? AppColors.primary : AppColors.textDark,
              letterSpacing: 0.1,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          // Visitor count row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.people_alt_rounded,
                size: 9,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 2),
              Text(
                destination.visitors,
                style: const TextStyle(
                  fontSize: 9,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        bottom: 14,
      ),
      child: Row(
        children: [
          // ── Hamburger / drawer button
          AppBarButton(
            child: const Icon(
              Icons.menu_rounded,
              color: AppColors.primary,
              size: 20,
            ),
            onTap: () {
              // TODO: open drawer
            },
          ),

          const Spacer(),

          // ── Country title with emoji flag
          const Row(
            children: [
              Text('🇪🇬', style: TextStyle(fontSize: 18)),
              SizedBox(width: 6),
              Text(
                'Egypt',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A3A6B),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          const Spacer(),

          // ── User avatar (rounded, falls back to person icon on error)
          RoundedAvatar(
            url: 'https://i.pravatar.cc/150?img=12',
          ),
        ],
      ),
    );
  }
}
class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circle — top-right corner
          Positioned(
            right: -20,
            top: -20,
            child: _DecorativeCircle(size: 120, opacity: 0.07),
          ),
          // Decorative circle — bottom-right, smaller
          Positioned(
            right: 30,
            bottom: -30,
            child: _DecorativeCircle(size: 90, opacity: 0.05),
          ),

          // Text content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // "Plan your trip" pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '✈️  Plan your trip',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Discover the Magic\nof Ancient Egypt',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.3,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${kDestinations.length} unique destinations to explore',
                  style: const TextStyle(fontSize: 11, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }
}




class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),

          // AI bot icon in a tinted square
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              size: 16,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 10),

          // Placeholder text
          const Expanded(
            child: Text(
              'Ask GlobeGo Assistant...',
              style: TextStyle(
                fontSize: 13.5,
                color: AppColors.textLight,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Mic / voice input button
          GestureDetector(
            onTap: () {
              // TODO: start voice input
            },
            child: Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), AppColors.primary],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.mic_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );


  }

}

Widget _buildSectionHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Explore Destinations',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w800,
          color: AppColors.textDark,
          letterSpacing: -0.4,
        ),
      ),
      GestureDetector(
        onTap: () {
          // TODO: navigate to full destinations list
        },
        child: const Text(
          'See all',
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ),
    ],
  );

}
