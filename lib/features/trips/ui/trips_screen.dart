import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/theming/colors.dart';
import 'package:graduation/features/trips/logic/agency_logic/agency_trips_cubit.dart';

import '../../../core/widgets/loading_widget.dart';
import '../../rr.dart';
import '../logic/trips_cubit.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.moreLightGray,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: WelcomeBanner(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Popular Destinations',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Best Places to Visit',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<TripsCubit, TripsState>(
                builder: (context, state) {
                  if (state is TripsLoading) {
                    return const Center(child: PrettyLoadingWidget());
                  }
                  if (state is TripsError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is TripsLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 290,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.trips.length,
                          itemBuilder: (context, index) {
                            final trip = state.trips[index];
                            return SizedBox(
                              width:
                                  MediaQuery.of(context).size.width *
                                  0.5, // يعرض اتنين تقريبا
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: DestinationCard(
                                  imageUrl: trip.image ?? '',
                                  name: trip.name ?? '',
                                  location: trip.location ?? '',
                                  price: trip.price ?? 0,
                                  rating: 4.5,
                                  isFavorited: false,
                                  tag: 'New',
                                ),
                              ),
                            );
                            // return SizedBox(
                            //   height: 200,
                            //   width: 150,
                            //   child: Card(
                            //     color: ColorsManger.white,
                            //     elevation: 4,
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(6.0),
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Material(
                            //       elevation: 3.0,
                            //           clipBehavior: Clip.antiAlias,
                            //           borderRadius: BorderRadius.circular(10),
                            //             child: Image.network(trip.image??'',fit: BoxFit.cover,width: 140,height:110 )),
                            //       SizedBox(height: 5,),
                            //         Text(trip.name??'',maxLines: 1, overflow: TextOverflow.ellipsis,),
                            //         SizedBox(height: 5,),
                            //         Row(
                            //           children: [
                            //             Icon(Icons.location_on,size: 15,color: ColorsManger.gray,),
                            //             Text(trip.location??'',style: TextStyle(
                            //               fontSize: 11,
                            //               color: ColorsManger.gray
                            //             ),),
                            //           ],
                            //         ),
                            //         SizedBox(height: 4,),
                            //
                            //         Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             Text(" \$ ${trip.price.toString()}",style: TextStyle(
                            //               fontSize: 12,
                            //               color: ColorsManger.blue
                            //             ),),
                            //             Icon(Icons.favorite_border,size: 20,color: ColorsManger.gray,)
                            //           ],
                            //         )
                            //       ],
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      ),
                    );
                  }
                  return Text("empty");
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Travel Agency Offers',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Flash deals ',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                  ],
                ),
              ),
              BlocBuilder<AgencyTripsCubit, AgencyTripsState>(
                builder: (context, state) {
                  if (state is AgencyTripsLoading) {
                    return const Center(child: PrettyLoadingWidget());
                  }
                  if (state is AgencyTripsError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is AgencyTripsLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 344,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: state.trips.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,

                          itemBuilder: (context, index) {
                            final trip = state.trips[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MountainTripCard(
                                category: trip.category ?? '',
                                imageUrl: trip.image ?? '',
                                name: trip.tripTitle ?? '',
                                location: trip.location ?? '',
                                price: trip.price ?? 0,
                                rating: trip.rating,
                                isFavorited: false,
                                seatsTaken: trip.seatsTaken ?? 0,
                                seatsMax: trip.seatsMax ?? 0,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return Text("empty");
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  const TripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // ---------- Image ----------
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // ---------- Text Section ----------
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Mountain Trip",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Seelisburg",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),

                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.location_on, color: Colors.grey, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "Norway",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // ---- Avatars + progress ----
                Row(
                  children: [
                    // Avatars
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/men/10.jpg",
                          ),
                        ),
                        Positioned(
                          left: 18,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/women/12.jpg",
                            ),
                          ),
                        ),
                        Positioned(
                          left: 36,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/20.jpg",
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text("80%"),
                  ],
                ),

                const SizedBox(height: 6),

                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.8,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(Color(0xFF00B4D8)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MountainTripCard extends StatefulWidget {
  String imageUrl;
  String name;
  String location;
  int price;
  int seatsTaken;
  int seatsMax;
  double rating;
  String category;
  bool isFavorited;

  MountainTripCard({
    super.key,
    required this.imageUrl,
    required this.seatsTaken,
    required this.seatsMax,
    required this.category,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.isFavorited,
  });

  @override
  State<MountainTripCard> createState() => _MountainTripCardState();
}

class _MountainTripCardState extends State<MountainTripCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOutCubic,
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      _progressController.forward();
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.10),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Top image banner with overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: Image.network(
                  widget.imageUrl,
                  width: double.infinity,
                  height: 148,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      height: 148,
                      color: const Color(0xFFD0E8D0),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Dark gradient overlay at bottom of image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xAA000000)],
                    ),
                  ),
                ),
              ),
              // Category chip — top left
              Positioned(
                top: 12,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.terrain_rounded,
                        size: 13,
                        color: Color(0xFF3B82F6),
                      ),
                      SizedBox(width: 4),
                      Text(
                        widget.category,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bookmark button — top right
              Positioned(
                top: 8,
                right: 10,
                child: GestureDetector(
                  onTap:
                      () => setState(
                        () => widget.isFavorited = !widget.isFavorited,
                      ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color:
                          widget.isFavorited
                              ? const Color(0xFF3B82F6)
                              : Colors.white.withOpacity(0.88),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.isFavorited
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      size: 16,
                      color:
                          widget.isFavorited
                              ? Colors.white
                              : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
              // Title on image
              Positioned(
                bottom: 12,
                left: 14,
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.3,
                    shadows: [Shadow(blurRadius: 8, color: Colors.black38)],
                  ),
                ),
              ),
            ],
          ),

          // ── Bottom content
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location + rating
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 14,
                      color: Color(0xFF3B82F6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.location,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7ED),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 13,
                            color: Color(0xFFF59E0B),
                          ),
                          SizedBox(width: 3),
                          Text(
                            widget.rating.toString(),
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFB45309),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(height: 1, color: const Color(0xFFF3F4F6)),
                const SizedBox(height: 12),

                // Avatars + progress label
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const _StackedAvatars(),
                    const SizedBox(width: 8),
                    Text(
                      widget.seatsTaken.toString(),
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (_, __) {
                        final pct =
                            (_progressAnimation.value * widget.seatsTaken)
                                .round();
                        return Text(
                          '$pct%',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1D2939),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Animated progress bar
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (_, __) {
                    return Stack(
                      children: [
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5E7EB),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: _progressAnimation.value * 0.80,
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 14),

                // CTA button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View Trip Details',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StackedAvatars extends StatelessWidget {
  const _StackedAvatars();

  static const List<String> _urls = [
    'https://i.pravatar.cc/150?img=1',
    'https://i.pravatar.cc/150?img=5',
    'https://i.pravatar.cc/150?img=9',
  ];

  @override
  Widget build(BuildContext context) {
    const double size = 28;
    const double overlap = 18;
    final double totalWidth = size + (_urls.length - 1) * overlap;

    return SizedBox(
      width: totalWidth,
      height: size,
      child: Stack(
        children: List.generate(_urls.length, (i) {
          return Positioned(
            left: i * overlap,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: size / 2,
                backgroundImage: NetworkImage(_urls[i]),
                backgroundColor: const Color(0xFFD1D5DB),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class DestinationCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String location;
  final int price;
  final double rating;
  final bool isFavorited;
  final String tag;

  const DestinationCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.isFavorited,
    required this.tag,
  });

  @override
  State<DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard>
    with SingleTickerProviderStateMixin {
  late bool _favorited;
  late AnimationController _heartController;
  late Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _favorited = widget.isFavorited;
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heartScale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() => _favorited = !_favorited);
    _heartController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image + overlays
          Stack(
            children: [
              // Photo
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: const Color(0xFFDBEAFE),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Bottom gradient
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 64,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xCC000000)],
                    ),
                  ),
                ),
              ),
              // Tag chip — top left
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        widget.tag == 'Trending'
                            ? const Color(0xFFFF6B35)
                            : const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.tag,
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
              // Rating chip — top right
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 11,
                        color: Color(0xFFFBBF24),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        widget.rating.toString(),
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Heart button — bottom right of image
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: _toggleFavorite,
                  child: AnimatedBuilder(
                    animation: _heartScale,
                    builder:
                        (_, __) => Transform.scale(
                          scale: _heartScale.value,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color:
                                  _favorited
                                      ? const Color(0xFFEF4444)
                                      : Colors.white.withOpacity(0.88),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      _favorited
                                          ? const Color(
                                            0xFFEF4444,
                                          ).withOpacity(0.35)
                                          : Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              _favorited
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 16,
                              color:
                                  _favorited
                                      ? Colors.white
                                      : const Color(0xFF94A3B8),
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),

          // ── Info section
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 12,
                      color: Color(0xFF3B82F6),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      widget.location,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Divider
                Container(height: 1, color: const Color(0xFFF1F5F9)),
                const SizedBox(height: 10),
                // Price row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '\$${widget.price.toInt()}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                          const TextSpan(
                            text: ' /visit',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Book now mini button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Book',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
