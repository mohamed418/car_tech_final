// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// import '../../../map_functions/is_permission_granted.dart';
// import '../../../map_functions/is_service_enabled.dart';
//
// class homeScreen extends StatefulWidget {
//   static const String routeName = 'home-screen';
//
//   @override
//   State<homeScreen> createState() => _homeScreenState();
// }
//
// class _homeScreenState extends State<homeScreen> {
//   Location location = Location();
//   late PermissionStatus permissionStatus;
//   bool serviceEnabled = false;
//   LocationData? locationData;
//
//   Set<Marker> markers = {};
//
//   Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//   double defLat = 43.4140383;
//   double defLong = -118.945615;
//
//   StreamSubscription<LocationData>? locationStream;
//
//   @override
//   void initState() {
//     super.initState();
//     getUserLocation();
//     var userMarker = Marker(
//       markerId: MarkerId('User location'),
//       position: LatLng(
//           locationData?.latitude ?? defLat, locationData?.longitude ?? defLong),
//     );
//     markers.add(userMarker);
//   }
//
//   // @override
//   // void dispose() {
//   //   locationStream?.cancel();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location'),
//         centerTitle: true,
//       ),
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//         markers: markers,
//         onTap: (latLng) => updateUserMarker(latLng),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(right: 40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             // My Location button
//             FloatingActionButton(
//               onPressed: () {
//                 goToUserLocation();
//                 // Code to get user's current location and show it on the map
//               },
//               child: Icon(Icons.my_location),
//             ),
//             SizedBox(height: 16), // Add some space between the buttons
//             // Show Garages button
//             ElevatedButton(
//               onPressed: () {
//                 goToUserLocation();
//                 },
//               child: Text('Show Garages'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   void goToUserLocation() async {
//     if (locationData != null) {
//       var userLatLng =
//           LatLng(locationData!.latitude!, locationData!.longitude!);
//
//       // Remove the previous user marker
//       markers.removeWhere((marker) => marker.markerId.value == 'User location');
//
//       // Add a new marker at the updated position
//       var userMarker = Marker(
//         markerId: MarkerId('User location'),
//         position: userLatLng,
//       );
//       markers.add(userMarker);
//
//       // Update the camera position
//       var controller = await _controller.future;
//       var newCameraPosition = CameraPosition(target: userLatLng, zoom: 19);
//       controller
//           .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
//       setState(() {});
//     }
//   }
//
//   void trackUserLocation() {
//     locationStream = location.onLocationChanged.listen((newLocationData) {
//       if (newLocationData.latitude != null &&
//           newLocationData.longitude != null &&
//           newLocationData.latitude != locationData?.latitude &&
//           newLocationData.latitude != locationData?.longitude) {
//         locationData = newLocationData;
//         updateUserMarker(
//             LatLng(locationData!.latitude!, locationData!.longitude!));
//         print(
//             '${locationData?.latitude ?? 0} , ${locationData?.longitude ?? 0}');
//       }
//     });
//   }
//
//   Future<void> showGarages(LatLng userLocation) async {
//     // Get garages within 2 kilometers of user's current location
//     final garages = await getGaragesWithinRadius(userLocation, 2);
//
//     // Create markers for the garages
//     var markers = garages.map((garage) {
//       return Marker(
//         markerId: MarkerId(garage.id),
//         position: LatLng(garage.latitude, garage.longitude),
//         infoWindow: InfoWindow(
//           title: garage.name,
//           snippet: garage.address,
//         ),
//       );
//     }).toSet();
//
//     // Show the markers on the map
//     setState(() {
//       this.markers = markers;
//     });
//   }
//   getGaragesWithinRadius(LatLng userLocation, int i) {}
//   void getUserLocation() async {
//     bool permissionGranted = await isPermissionGranted();
//     bool gpsEnabled = await isServiceEnabled();
//
//     if (permissionGranted && gpsEnabled) {
//       locationData = await location.getLocation();
//       locationStream = location.onLocationChanged.listen((newLocationData) {
//         if (newLocationData.latitude != null &&
//             newLocationData.longitude != null &&
//             newLocationData.latitude != locationData?.latitude &&
//             newLocationData.latitude != locationData?.longitude) {
//           locationData = newLocationData;
//           updateUserMarker(
//               LatLng(locationData!.latitude!, locationData!.longitude!));
//           print(
//               '${locationData?.latitude ?? 0} , ${locationData?.longitude ?? 0}');
//         }
//       });
//     }
//   }
//
//   void updateUserMarker(LatLng latLng) async {
//     var userMarker = Marker(
//       markerId: MarkerId('User location'),
//       position: latLng,
//     );
//     markers.add(userMarker);
//     setState(() {});
//     var controller = await _controller.future;
//     var newCameraPosition = CameraPosition(
//       target: latLng,
//       zoom: 19,
//     );
//     controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
//   }
// }
