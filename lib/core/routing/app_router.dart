import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/routing/routes.dart';
import 'package:graduation/features/home/chat.dart';
import 'package:graduation/features/home/home_screen.dart';
import 'package:graduation/features/hotel_details/hotel_details.dart';
import 'package:graduation/features/onboarding/onboarding_screen.dart';
import 'package:graduation/features/places/logic/places_cubit.dart';
import 'package:graduation/features/register/logic/register_cubit.dart';
import 'package:graduation/features/trips/ui/trips_screen.dart';

import '../../features/login/logic/login_cubit.dart';
import '../../features/login/login_screen.dart';
import '../../features/places/data/models/hotel_model.dart';
import '../../features/places/logic/hotels_cubit.dart';
import '../../features/places/places_screen.dart';
import '../../features/register/register_screen.dart';
import '../../features/test.dart';
import '../../features/trips/logic/agency_logic/agency_trips_cubit.dart';
import '../../features/trips/logic/trips_cubit.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.onBoarding,

    routes: [
      GoRoute(
        path: Routes.onBoarding,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(path: Routes.chat, builder: (context, state) => const Chat()),
      GoRoute(
        path: Routes.register,
        builder:
            (context, state) => BlocProvider<RegisterCubit>.value(
              value: RegisterCubit(),
              child: RegisterScreen(),
            ),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder:
            (context, state) => BlocProvider(
              create: (context) => LoginCubit(),
              child: LoginScreen(),
            ),
      ),
      GoRoute(
        path: Routes.places,
        builder: (context, state) {
          final city = state.extra as String;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PlacesCubit(getIt())..getPlaces(city),
              ),
              BlocProvider(
                create: (context) => HotelsCubit(getIt())..getHotels(city),
              ),
            ],
            child: PlacesScreen(city: city),
          );
        },
      ),
      GoRoute(
        path: Routes.hotelDetails,
        builder: (context, state) {
          final HotelModel hotel = state.extra as HotelModel;
          return HotelDetails(hotel: hotel);
        },
      ),
      GoRoute(
        path: Routes.trips,
        builder:
            (context, state) => MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => TripsCubit(tripsRepository:  getIt())..getTrips(),
              ),
              BlocProvider(
                create: (context) => AgencyTripsCubit(getIt())..getAgencyTrips(),
              ),

            ], child: const TripsScreen(),


            ),
      ),
      GoRoute(path: Routes.egyptScreen, builder: (context, state) => const EgyptScreen())
    ],
  );
}
