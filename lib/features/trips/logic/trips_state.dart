part of 'trips_cubit.dart';

@immutable
sealed class TripsState {}

final class TripsInitial extends TripsState {}
final class TripsLoading extends TripsState{}
final class TripsLoaded extends TripsState{
  final List<TripsModel> trips;

  TripsLoaded(this.trips);
}
final class TripsError extends TripsState{
  final String message;

  TripsError(this.message);
}
