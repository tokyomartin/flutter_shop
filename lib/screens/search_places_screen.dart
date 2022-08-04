import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:uuid/uuid.dart';


//stful
const kGoogleApiKey = 'AIzaSyChkkF4LyVqpDUldBUQqHyN7L8ic7tQuEg';
final homeScaffoldKey = GlobalKey<ScaffoldState>();


class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();

}




class _SearchPlacesScreenState extends State<SearchPlacesScreen> {

  // const latitude = 37.42796;
  // const longitude = -122;
  // static const CameraPosition initialCameraPosition = CameraPosition(
  //     target: LatLng(37.42796, -122), zoom: 14.0);
  // Set<Marker> markersList = {};
  //late
  // GoogleMapController googleMapController;

  Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildDropdownMenu(),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _handlePressButton,
              child: const Text('Search places'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/search');
              },
              child: const Text('Custom'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownMenu() {
    return DropdownButton<Mode>(
      value: _mode,
      items: const <DropdownMenuItem<Mode>>[
        DropdownMenuItem<Mode>(
          value: Mode.overlay,
          child: Text('Overlay'),
        ),
        DropdownMenuItem<Mode>(
          value: Mode.fullscreen,
          child: Text('Fullscreen'),
        ),
      ],
      onChanged: (m) {
        if (m != null) {
          setState(() => _mode = m);
        }
      },
    );
  }

  Future<void> _handlePressButton() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    // show input autocomplete with selected mode
    // then get the Prediction selected
    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: 'jp',
      components: [Component(Component.country, 'jp')],
    );

    await displayPrediction(p, ScaffoldMessenger.of(context));
  }
}

Future<void> displayPrediction(Prediction? p, ScaffoldMessengerState messengerState) async {
  if (p == null) {
    return;
  }

  // get detail (lat/lng)
  final _places = GoogleMapsPlaces(
    apiKey: kGoogleApiKey,
    apiHeaders: await const GoogleApiHeaders().getHeaders(),
  );

  final detail = await _places.getDetailsByPlaceId(p.placeId!);
  final geometry = detail.result.geometry!;
  final lat = geometry.location.lat;
  final lng = geometry.location.lng;

  messengerState.showSnackBar(
    SnackBar(
      content: Text('${p.description} - $lat/$lng'),
    ),
  );
 // googleMapControler.animateCamera(CameraUpdate.newLatLngZoom(latlng(lat, lng), 14.0));


}


