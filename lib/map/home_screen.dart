import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:test1/modules/location/result_screen.dart';

import '../map_functions/is_permission_granted.dart';
import '../map_functions/is_service_enabled.dart';

class homeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';
  final String role;

  const homeScreen({super.key, required this.role});

  @override
  State<homeScreen> createState() => _homeScreenState(role);
}

class _homeScreenState extends State<homeScreen> {
  final String role;
  Location location = Location();
  late PermissionStatus permissionStatus;
  bool serviceEnabled = false, presented = false;
  LocationData? locationData;
  Set<Marker> markers = {};

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  double defLat = 43.4140383;
  double defLong = -118.945615;

  StreamSubscription<LocationData>? locationStream;

  _homeScreenState(this.role);

  @override
  void initState() {
    super.initState();
    getUserLocation();
    var userMarker = Marker(
      markerId: const MarkerId('User location'),
      position: LatLng(
          locationData?.latitude ?? defLat, locationData?.longitude ?? defLong),
    );
    markers.add(userMarker);
  }

  @override
  void dispose() {
    locationStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers,
            onTap: (latLng) => updateUserMarker(latLng),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height * .2,
            left: MediaQuery.of(context).size.width * .1,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // My Location button
            FloatingActionButton(
              onPressed: () {
                goToUserLocation();
                // Code to get user's current location and show it on the map
              },
              child: const Icon(Icons.my_location),
            ),
            const SizedBox(height: 16), // Add some space between the buttons
            // Show Garages button
            ElevatedButton(
              onPressed: () {
                goToUserLocation();
                if (presented != true) {
                  for (int i = 0; i < 10; i++) {
                    addNearbyMarkers();
                  }
                  presented = true;
                }
              },
              child: const Text('Show Nearby'),
            ),
          ],
        ),
      ),
    );
  }

  void goToUserLocation() async {
    if (locationData != null) {
      var userLatLng =
          LatLng(locationData!.latitude!, locationData!.longitude!);

      // Remove the previous user marker
      markers.removeWhere((marker) => marker.markerId.value == 'User location');

      // Add a new marker at the updated position
      var userMarker = Marker(
        markerId: const MarkerId('User location'),
        position: userLatLng,
      );
      markers.add(userMarker);

      // Update the camera position
      var controller = await _controller.future;
      var newCameraPosition = CameraPosition(target: userLatLng, zoom: 19);
      controller
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
      setState(() {});
    }
  }

  void trackUserLocation() {
    locationStream = location.onLocationChanged.listen((newLocationData) {
      if (newLocationData.latitude != null &&
          newLocationData.longitude != null &&
          newLocationData.latitude != locationData?.latitude &&
          newLocationData.latitude != locationData?.longitude) {
        locationData = newLocationData;
        updateUserMarker(
            LatLng(locationData!.latitude!, locationData!.longitude!));
        print(
            '${locationData?.latitude ?? 0} , ${locationData?.longitude ?? 0}');
      }
    });
  }

  // Future<void> showGarages(LatLng userLocation) async {
  //   // Get garages within 2 kilometers of user's current location
  //   final garages = await getGaragesWithinRadius(userLocation, 2);
  //
  //   // Create markers for the garages
  //   var markers = garages.map((garage) {
  //     return Marker(
  //       markerId: MarkerId(garage.id),
  //       position: LatLng(garage.latitude, garage.longitude),
  //       infoWindow: InfoWindow(
  //         title: garage.name,
  //         snippet: garage.address,
  //       ),
  //     );
  //   }).toSet();
  //
  //   // Show the markers on the map
  //   setState(() {
  //     this.markers = markers;
  //   });
  // }
  // getGaragesWithinRadius(LatLng userLocation, int i) {}
  void getUserLocation() async {
    bool permissionGranted = await isPermissionGranted();
    bool gpsEnabled = await isServiceEnabled(context);

    if (permissionGranted && gpsEnabled) {
      locationData = await location.getLocation();
      locationStream = location.onLocationChanged.listen((newLocationData) {
        if (newLocationData.latitude != null &&
            newLocationData.longitude != null &&
            newLocationData.latitude != locationData?.latitude &&
            newLocationData.latitude != locationData?.longitude) {
          locationData = newLocationData;
          updateUserMarker(
              LatLng(locationData!.latitude!, locationData!.longitude!));
          print(
              '${locationData?.latitude ?? 0} , ${locationData?.longitude ?? 0}');
        }
      });
    }
  }

  void updateUserMarker(LatLng latLng) async {
    var userMarker = Marker(
      markerId: const MarkerId('User location'),
      position: latLng,
    );
    markers.add(userMarker);
    setState(() {});
    var controller = await _controller.future;
    var newCameraPosition = CameraPosition(
      target: latLng,
      zoom: 19,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  // void addNearbyMarkers() {
  //   final double radius = 0.002;
  //   final int numMarkers = 10;
  //   final double lat = locationData!.latitude!;
  //   final double long = locationData!.longitude!;
  //
  //   // generate random positions near user's location
  //   final List<LatLng> positions = List.generate(
  //     numMarkers,
  //     (index) => LatLng(
  //       lat + (Random().nextDouble() - 0.5) * radius * 2,
  //       long + (Random().nextDouble() - 0.5) * radius * 2,
  //     ),
  //   );
  //
  //   // add markers to set
  //   final Set<Marker> newMarkers = positions
  //       .map((position) => Marker(
  //             markerId: MarkerId('Marker ${markers.length + 1}'),
  //             position: position,
  //             icon: BitmapDescriptor.defaultMarkerWithHue(
  //                 BitmapDescriptor.hueOrange),
  //           ))
  //       .toSet();
  //
  //   // add markers to map and update state
  //   markers.addAll(newMarkers);
  //   setState(() {});
  // }
  void addNearbyMarkers() {
    final double radius = 0.002;
    final int numMarkers = 10;
    final double lat = locationData!.latitude!;
    final double long = locationData!.longitude!;

    // generate random positions near user's location
    final List<LatLng> positions = List.generate(
      numMarkers,
      (index) => LatLng(
        lat + (Random().nextDouble() - 0.5) * radius * 2,
        long + (Random().nextDouble() - 0.5) * radius * 2,
      ),
    );

    // add markers to set
    final Set<Marker> newMarkers = positions
        .asMap()
        .map((index, position) => MapEntry(
            index,
            Marker(
              markerId: MarkerId('Marker ${markers.length + 1}'),
              position: position,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange),
              onTap: () {
                // Navigate to the desired screen when marker is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      role: role,
                    ),
                  ),
                );
              },
            )))
        .values
        .toSet();

    // add markers to map and update state
    markers.addAll(newMarkers);
    setState(() {});
  }
}
