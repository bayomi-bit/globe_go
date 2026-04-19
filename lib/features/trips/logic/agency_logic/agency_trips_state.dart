part of 'agency_trips_cubit.dart';

@immutable
sealed class AgencyTripsState {}

final class AgencyTripsInitial extends AgencyTripsState {}
final class AgencyTripsLoading extends AgencyTripsState{}
final class AgencyTripsLoaded extends AgencyTripsState{
  final List<AgencyTrips> trips;

  AgencyTripsLoaded(this.trips);

}
final class AgencyTripsError extends AgencyTripsState{
  final String message;

  AgencyTripsError(this.message);
}

