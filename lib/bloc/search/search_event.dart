part of 'search_bloc.dart';

//event (peristiwa yang terjadi)
@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.started() = _Started;
  //nama eventnya _Search, taruh parameternya di dalam
  //kurung ()
  const factory SearchEvent.search(String name) = _Search;
}
