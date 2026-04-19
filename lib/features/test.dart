import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DESIGN TOKENS
// Centralised colour palette — reference these everywhere instead of raw hex.
// ─────────────────────────────────────────────────────────────────────────────
class AppColors {
  AppColors._(); // prevent instantiation

  /// Brand blue — primary CTAs, active states, selected borders
  static const primary = Color(0xFF1A56DB);

  /// Darker shade used for gradients and pressed states
  static const primaryDark = Color(0xFF0E3A9E);

  /// Very light tint for backgrounds, chips, and icon containers
  static const primaryLight = Color(0xFFEFF6FF);

  /// App-wide background (pale sky blue)
  static const bg = Color(0xFFEAF2FB);

  /// Card / sheet surface
  static const surface = Colors.white;

  /// High-contrast heading text
  static const textDark = Color(0xFF0F172A);

  /// Body / secondary text
  static const textMid = Color(0xFF475569);

  /// Muted labels, icons, metadata
  static const textLight = Color(0xFF94A3B8);

  /// Thin dividers and rule lines
  static const divider = Color(0xFFF1F5F9);
}

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODEL
// Each destination card is driven by one of these maps.
// ─────────────────────────────────────────────────────────────────────────────

/// Represents a single travel destination shown in the grid.
class Destination {
  const Destination({
    required this.name,
    required this.tag,
    required this.tagColor,
    required this.imageUrl,
    required this.visitors,
  });

  final String name;
  final String tag;
  final Color tagColor;
  final String imageUrl;

  /// Human-readable visitor count, e.g. "2.1M"
  final String visitors;
}

/// All destinations displayed on the Egypt screen.
const List<Destination> kDestinations = [
  Destination(
    name: 'Cairo',
    tag: 'Capital',
    tagColor: Color(0xFF7C3AED),
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFfVkeDWkQ2wbeT9fSuZ4lOcxnAmpOenyZMw&s',
    visitors: '2.1M',
  ),
  Destination(
    name: 'Giza',
    tag: 'Wonder',
    tagColor: Color(0xFFD97706),
    imageUrl: 'https://images.unsplash.com/photo-1643667802197-ce810e01619d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGdpemF8ZW58MHx8MHx8fDA%3D',
    visitors: '1.8M',
  ),
  Destination(
    name: 'Alexandria',
    tag: 'Coastal',
    tagColor: Color(0xFF0891B2),
    imageUrl: 'https://i.pinimg.com/736x/80/e5/61/80e561bc94065b890fd21d9695544416.jpg',
    visitors: '980K',
  ),
  Destination(
    name: 'Luxor',
    tag: 'Historic',
    tagColor: Color(0xFFB45309),
    imageUrl: 'https://i.pinimg.com/1200x/22/f7/48/22f748d1f0c83f95f41131fa9c59697d.jpg',
    visitors: '750K',
  ),
  Destination(
    name: 'Aswan',
    tag: 'River',
    tagColor: Color(0xFF0284C7),
    imageUrl: 'https://i.pinimg.com/736x/fa/0b/e5/fa0be5cef1be937ea4f0b56e991e7b19.jpg',
    visitors: '610K',
  ),
  Destination(
    name: 'Sinai',
    tag: 'Desert',
    tagColor: Color(0xFFDC2626),
    imageUrl: 'https://images.unsplash.com/photo-1572376069663-5f52bdd158f2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8c2luYWl8ZW58MHx8MHx8fDA%3D',
    visitors: '530K',
  ),
  Destination(
    name: 'Red Sea',
    tag: 'Diving',
    tagColor: Color(0xFF059669),
    imageUrl: 'https://i.pinimg.com/1200x/67/ec/ba/67ecba3b5773a43e94a0efbfa18ba26f.jpg',
    visitors: '1.2M',
  ),
  Destination(
    name: 'Matrouh',
    tag: 'Beach',
    tagColor: Color(0xFF0891B2),
    imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
    visitors: '420K',
  ),
  Destination(
    name: 'Hurghada',
    tag: 'Beach',
    tagColor: Color(0xFF4F46E5),
    imageUrl: 'https://media.istockphoto.com/id/175210186/photo/baech-resort.webp?a=1&b=1&s=612x612&w=0&k=20&c=ht37V1wOHQuXPtQ-ZKSWHTOKRx11g0HMGH7ppZbRnME=',
    visitors: '380K',
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

/// Main screen that showcases Egyptian travel destinations.
///
/// Layout (top → bottom):
///   [AppBar] → [ScrollableBody] → [BottomNav]
///
/// The scrollable body contains:
///   Hero banner → AI search bar → "Explore Destinations" section → Grid
class EgyptScreen extends StatefulWidget {
  const EgyptScreen({super.key});

  @override
  State<EgyptScreen> createState() => _EgyptScreenState();
}

class _EgyptScreenState extends State<EgyptScreen> {
  /// Index of the active bottom-nav tab (0 = Home).
  int _selectedNav = 0;

  /// Index of the currently selected destination card, or null if none.
  int? _selectedDestination;

  // ── Nav items ──────────────────────────────────────────────────────────────

  static const List<_NavItem> _navItems = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.explore_rounded, label: 'Explore'),
    _NavItem(icon: Icons.calendar_month_rounded, label: 'Plan'),
    _NavItem(icon: Icons.person_rounded, label: 'Profile'),
  ];

  // ── Build ──────────────────────────────────────────────────────────────────

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

  // ── Scrollable body ────────────────────────────────────────────────────────

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

  // ── Section header ("Explore Destinations" + "See all") ───────────────────

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

  // ── Destination grid ───────────────────────────────────────────────────────

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
          }),
        );
      },
    );
  }

  // ── Bottom navigation bar ──────────────────────────────────────────────────

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
            } ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SUB-WIDGETS  (private, stateless where possible)
// ─────────────────────────────────────────────────────────────────────────────

// ── App Bar ────────────────────────────────────────────────────────────────

/// Top bar: menu icon · "🇪🇬 Egypt" title · user avatar.
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

/// Reusable squared icon button used in the app bar.
class AppBarButton extends StatelessWidget {
  const AppBarButton({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

/// Circular avatar that loads a network image with an icon fallback.
class RoundedAvatar extends StatelessWidget {
  const RoundedAvatar({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.person_rounded,
            color: AppColors.primary,
            size: 22,
          ),
        ),
      ),
    );
  }
}

// ── Hero Banner ────────────────────────────────────────────────────────────

/// Full-width gradient card at the top of the feed.
/// Includes decorative translucent circles for visual depth.
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

/// Semi-transparent white circle used as a decorative background element.
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

// ── AI Search Bar ─────────────────────────────────────────────────────────

/// Pill-style search bar with an AI-assistant icon and a mic button.
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

// ── Destination Card ───────────────────────────────────────────────────────

/// Grid card displaying a destination photo, category tag, name, and
/// visitor count. Animates a blue border + shadow when selected.
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

// ── Bottom Nav ─────────────────────────────────────────────────────────────

/// Data class for a single bottom-nav item.
class _NavItem {
  const _NavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Animated tab button for the bottom navigation bar.
/// Active state shows a tinted pill background, inactive state is ghost.
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