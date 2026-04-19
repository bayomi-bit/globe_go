import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/theming/colors.dart';

import '../../core/routing/routes.dart';
import '../../core/widgets/loading_widget.dart';
import '../rr.dart';
import 'logic/hotels_cubit.dart';
import 'logic/places_cubit.dart';

class PlacesScreen extends StatelessWidget {
  final String city;

  const PlacesScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, Mahmoud",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Let's explore $city!",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    padding: const EdgeInsets.all(4),

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 5,
                        ),
                      ],
                      shape: BoxShape.circle,

                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.search_sharp,
                      size: 25,
                      color: ColorsManger.lightGray,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text(
                    'Popular Place',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: Text("See more")),
                ],
              ),
            ),

            BlocBuilder<PlacesCubit, PlacesState>(
              builder: (context, state) {
                if (state is PlacesLoading) {
                  return const Center(child: PrettyLoadingWidget());
                }

                if (state is PlacesError) {
                  return Center(child: Text(state.message));
                }

                if (state is PlacesLoaded ) {
                  if (state.places.isEmpty) {
                    return const Center(child: Text("No places found"));
                  }

                  return SizedBox(
                    height: 200, // ارتفاع مناسب للكارت الأفقي
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.places.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        final place = state.places[index];

                        return SizedBox(
                          width: 310, // عرض الكارت
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.only(right: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: place.image ?? "",
                                      height: 176,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder:
                                          (context, url) => const SizedBox(
                                            height: 140,
                                            child: Center(
                                              child: PrettyLoadingWidget(),
                                            ),
                                          ),
                                      errorWidget:
                                          (context, url, error) => Container(
                                            height: 140,
                                            color: Colors.grey.shade300,
                                            child: const Icon(
                                              Icons.image_not_supported,
                                              size: 40,
                                            ),
                                          ),
                                    ),
                                    Positioned(
                                      // center
                                      top: 0,
                                      bottom: 0,
                                      left: 0,
                                      right: 0,

                                      child: Center(
                                        child: Text(
                                          place.name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Lemon',
                                            fontWeight: FontWeight.bold,
                                            color: ColorsManger.lightBlue
                                                .withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                  );
                }

                return const SizedBox();
              },
            ),
            BlocBuilder<HotelsCubit, HotelsState>(
              builder: (context, state) {
                if (state is HotelsLoading) {
                  return const Center(child: PrettyLoadingWidget());
                }

                if (state is HotelsError) {
                  return Center(child: Text(state.message));
                }
                if (state is HotelsLoaded) {
                  return  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              'Popular Hotels',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            TextButton(onPressed: () {}, child: Text("See more")),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 354, // ارتفاع مناسب للكارت الأفقي
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.hotels.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            final hotel = state.hotels[index];

                            return GestureDetector(
                              onTap: (){
                                context.push(Routes.hotelDetails,extra:hotel);
                              },
                              child: SizedBox(
                                width: 185, // عرض الكارت
                                child: Card(
                                  elevation: 4,
                                  margin: const EdgeInsets.only(right: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: hotel.image ?? "",
                                            height: 330,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            placeholder:
                                                (context, url) => const SizedBox(
                                              height: 140,
                                              child: Center(
                                                child: PrettyLoadingWidget(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) => Container(
                                              height: 140,
                                              color: Colors.grey.shade300,
                                              child: const Icon(
                                                Icons.image_not_supported,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // center
                                            top: 200,
                                            bottom: 0,
                                            left: 0,
                                            right: 0,

                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    hotel.hotelName,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Lemon',
                                                      fontWeight: FontWeight.bold,
                                                      color: ColorsManger.white.withOpacity(0.8)

                                                      ,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,

                                                    children: [
                                                      Icon(FontAwesomeIcons.locationDot, color: ColorsManger.white.withOpacity(0.8), size: 12,),
                                                      Text('cairo',style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'Lemon',
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorsManger.white.withOpacity(0.8)



                                                      ),)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                      )
                    ],
                  );

                }
                return const SizedBox();



              },
            ),
            MapBanner()


          ],
        ),
      ),
    );
  }
}

class NotchedBottomNav extends StatefulWidget {
  @override
  _NotchedBottomNavState createState() => _NotchedBottomNavState();
}

class _NotchedBottomNavState extends State<NotchedBottomNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// LEFT SIDE
              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(() => _currentIndex = 0),
                    icon: Icon(
                      Icons.home,
                      color: _currentIndex == 0 ? Colors.blue : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () => setState(() => _currentIndex = 1),
                    icon: Icon(
                      Icons.search,
                      color: _currentIndex == 1 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),

              /// RIGHT SIDE
              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(() => _currentIndex = 2),
                    icon: Icon(
                      Icons.favorite,
                      color: _currentIndex == 2 ? Colors.blue : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () => setState(() => _currentIndex = 3),
                    icon: Icon(
                      Icons.person,
                      color: _currentIndex == 3 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: Text(
          "Page $_currentIndex",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}