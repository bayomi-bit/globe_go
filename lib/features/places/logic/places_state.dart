part of 'places_cubit.dart';

@immutable
sealed class PlacesState {}

final class PlacesInitial extends PlacesState {}
final class PlacesLoading extends PlacesState {}

final class PlacesLoaded extends PlacesState {
  final List<PlaceModel> places;

  PlacesLoaded(this.places);
}
final class PlacesError extends PlacesState {
  final String message;

  PlacesError(this.message);
}

