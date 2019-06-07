import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:japan_meta_weather/repositories/repositories.dart';
import 'package:meta/meta.dart';

abstract class LocationEvent extends Equatable {
  LocationEvent([List props = const []]) : super(props);
}

class FetchLocations extends LocationEvent {}

abstract class LocationState extends Equatable {
  LocationState([List props = const []]) : super(props);
}

class LocationEmpty extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<String> locations;

  LocationLoaded({@required this.locations})
      : assert(locations != null),
        super(locations);
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;

  LocationBloc({@required this.locationRepository})
      : assert(locationRepository != null);

  @override
  LocationState get initialState => LocationEmpty();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is FetchLocations) {
      yield LocationLoading();
      final locations = await locationRepository.getLocations();
      yield LocationLoaded(locations: locations);
    }
  }
}
