import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:japan_meta_weather/blocs/blocs.dart';
import 'package:japan_meta_weather/repositories/repositories.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Japan Weathers',
        home: Scaffold(
          appBar: AppBar(title: Text('Japan Weathers')),
          body: LocationList(locationRepository: LocationRepository()),
        ),
      );
}

class LocationList extends StatefulWidget {
  final LocationRepository locationRepository;

  const LocationList({Key key, @required this.locationRepository})
      : assert(locationRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LocationState();
}

class _LocationState extends State<LocationList> {
  LocationBloc _locationBloc;

  @override
  void initState() {
    _locationBloc = LocationBloc(locationRepository: widget.locationRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        bloc: _locationBloc,
        builder: (_, LocationState state) {
          if (state is LocationEmpty) {
            _locationBloc.dispatch(FetchLocations());
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LocationLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LocationLoaded) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) => Card(
                    child: ListTile(
                      title: Text(state.locations[index]),
                    ),
                  ),
              itemCount: state.locations.length,
            );
          }
        },
      );

  @override
  void dispose() {
    _locationBloc.dispose();
    super.dispose();
  }
}
