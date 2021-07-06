// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:lo_rent/constants.dart';
// import 'package:lo_rent/models/location_model.dart';
//
// class GoogleMapScreen extends StatefulWidget {
//   const GoogleMapScreen({Key key}) : super(key: key);
//
//   @override
//   _GoogleMapScreenState createState() => _GoogleMapScreenState();
// }
//
// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
//   int _markerIdCounter = 0;
//   Completer<GoogleMapController> _mapController = Completer();
//   LatLng currentLocation = LatLng(37.42796133580664, -122.085749655962);
//   MapType currentMapType = MapType.normal;
//   bool myLocationEnabled = false;
//   bool showSearchExitButton = false;
//   GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
//   String searchedPlace = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Icon(Icons.search_outlined, color: Colors.black),
//             Expanded(
//               child: TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Search here',
//                 ),
//               ),
//             ),
//             if (showSearchExitButton)
//               IconButton(
//                 icon: Icon(Icons.clear, color: Colors.black),
//                 onPressed: () {
//                   setState(() {
//                     searchedPlace = '';
//                     showSearchExitButton = false;
//                   });
//                 },
//               )
//           ],
//         ),
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_rounded,
//             color: kSecondaryColor,
//           ),
//           splashRadius: 25,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Stack(
//           alignment: Alignment.topRight,
//           children: [
//             GoogleMap(
//               zoomControlsEnabled: false,
//               mapType: currentMapType,
//               markers: Set<Marker>.of(_markers.values),
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(37.42796133580664, -122.085749655962),
//                 zoom: 12.0,
//               ),
//               onCameraMove: (CameraPosition position) =>
//                   _moveCamera(position.target),
//             ),
//             Container(
//               padding: EdgeInsets.all(15),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   FloatingActionButton(
//                     heroTag: null,
//                     mini: true,
//                     child: Icon(
//                       Icons.layers_outlined,
//                       size: 25,
//                       color: Theme.of(context).accentColor,
//                     ),
//                     onPressed: _onMapTypeChanged,
//                   ),
//                   FloatingActionButton(
//                     heroTag: null,
//                     mini: true,
//                     child: Icon(
//                       Icons.my_location,
//                       size: 25,
//                       color: myLocationEnabled
//                           ? Theme.of(context).accentColor
//                           : Colors.black,
//                     ),
//                     onPressed: () async {
//                       await _onMyLocationEnabledChanged();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: MediaQuery.of(context).size.width / 15,
//               left: MediaQuery.of(context).size.width / 15,
//               right: MediaQuery.of(context).size.width / 15,
//               top: MediaQuery.of(context).size.height / 1.5,
//               child: Container(
//                 padding: EdgeInsets.all(15),
//                 height: 60.0,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Hello world',
//                         maxLines: 5,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     SizedBox(width: 15.0),
//                     FloatingActionButton(
//                       heroTag: null,
//                       child: Icon(
//                         Icons.navigate_next,
//                         size: 40,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       backgroundColor: Theme.of(context).accentColor,
//                       onPressed: _onAddressSelected,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         // GoogleMap(
//         //   initialCameraPosition: CameraPosition(
//         //     target: LatLng(37.42796133580664, -122.085749655962),
//         //     zoom: 14.4746,
//         //   ),
//         // ),
//       ),
//     );
//   }
//
//   void _onMapCreated(GoogleMapController controller) async {
//     _mapController.complete(controller);
//     if ([currentLocation] != null) {
//       MarkerId markerId = MarkerId(_markerIdVal());
//       LatLng position = currentLocation;
//       Marker marker = Marker(
//         markerId: markerId,
//         position: position,
//         draggable: false,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
//       );
//       setState(() {
//         _markers[markerId] = marker;
//       });
//
//       Future.delayed(Duration(seconds: 1), () async {
//         GoogleMapController controller = await _mapController.future;
//         controller.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: position,
//               zoom: 15.0,
//             ),
//           ),
//         );
//       });
//     }
//   }
//
//   String _markerIdVal({bool increment = false}) {
//     String val = 'marker_id_$_markerIdCounter';
//     if (increment) _markerIdCounter++;
//     return val;
//   }
//
//   void _moveCamera(LatLng position) {
//     if (_markers.length > 0) {
//       MarkerId markerId = MarkerId(_markerIdVal());
//       Marker marker = _markers[markerId];
//       Marker updatedMarker = marker.copyWith(
//         positionParam: position,
//       );
//       setState(() {
//         _markers[markerId] = updatedMarker;
//         currentLocation = position;
//         print(currentLocation);
//       });
//     }
//   }
//
//   void _onMapTypeChanged() {
//     setState(() {
//       currentMapType =
//           currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
//     });
//   }
//
//   Future<void> _onMyLocationEnabledChanged() async {
//     myLocationEnabled = !myLocationEnabled;
//     if (myLocationEnabled) {
//       LocationModel locationModel = LocationModel();
//       await locationModel.getCurrentLocation();
//       _moveCamera(LatLng(locationModel.latitude, locationModel.longitude));
//     } else
//       setState(() {});
//   }
//
//   void _onAddressSelected() {
//     print('Address Saved');
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:lo_rent/constants.dart';

class GoogleMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PlacePicker(
          apiKey: kGoogleApiKey,
          initialPosition: LatLng(37.42796133580664, -122.085749655962),
          useCurrentLocation: true,
          selectInitialPosition: true,
          usePlaceDetailSearch: true,
          hintText: 'Search here',
          onPlacePicked: (result) {
            Navigator.pop(context, result.adrAddress);
          },
        ),
      ),
    );
  }
}
