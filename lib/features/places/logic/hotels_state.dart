part of 'hotels_cubit.dart';

@immutable
sealed class HotelsState {}

final class HotelsInitial extends HotelsState {}
final class HotelsLoading extends HotelsState {

}
final class HotelsError extends HotelsState {
  final String message;

  HotelsError(this.message);
}
final class HotelsLoaded extends HotelsState {
  final List<HotelModel> hotels;

  HotelsLoaded(this.hotels);
}