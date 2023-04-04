import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapSample({required this.latitude, required this.longitude});
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  // CameraPosition? _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

List<Marker> _marker=[];


  GoogleMapController? controller;

  late CameraPosition _kGooglePlex;

    final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

// for marker
 static const LatLng _kMapCenter = LatLng(52.4478, -3.5402);
  // LatLng _kMapCenter = LatLng(widget.latitude!, widget.longitude);
  BitmapDescriptor? _markerIcon;

  

   


  animate() async {
    print('i  m in init');
     _kGooglePlex = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 14.4746,
    );

    print(widget.latitude);
    print(widget.longitude);

    controller = await _controller.future;
    controller!.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  void onMapCreated(GoogleMapController _controller) {
    controller = _controller;
    methodA(LatLng(widget.latitude, widget.longitude));
  }

  void methodA(LatLng position) {
    controller!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15.0)));
  }

  Marker _createMarker(LatLng p) {
    if (_markerIcon != null) {
      print("markericon is not null");
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: p,
        icon: _markerIcon!,
      );
    } else {
      print("marker icon is null");
      return Marker(
        markerId: MarkerId('marker_1'),
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {
          print("here");
        },
        position: p,
      );
    }
  }

void find_distance(){
double distanceInMeters = Geolocator.distanceBetween(33.667696666666664, 73.07520666666667,33.7,73.1);
print("distance is  ${distanceInMeters}m");
print("distance is  ${distanceInMeters/1000}km");
}

PolylinePoints polylinePoints = PolylinePoints();

String googleAPiKey = "AIzaSyBXmQ1qiGg9jzCyty0P-G_z0okgfIFgZd4";

Set<Marker> markers = Set(); //markers for google map
Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

LatLng startLocation = LatLng(33.6676967,73.0752067);  
LatLng endLocation = LatLng(33.7,73.1); 

double distance = 0.0;
  @override
  void initState() {
     animate();
     _marker= [
  Marker(markerId: MarkerId('1'),
//position: LatLng(33.6676967,73.0752067),
position: LatLng(widget.latitude, widget.longitude),

),
 Marker(markerId: MarkerId('2'),
position: LatLng(33.7,73.1),

)



];
    // _kGooglePlex = CameraPosition(
    //   target: LatLng(37.42796133580664, -122.085749655962),
    //   zoom: 14.4746,
    // );
   // _marker.addAll(_list);

 getDirections();
    super.initState();
  }
//---------------------------------------------

  getDirections() async {
    print("direction is here");
      List<LatLng> polylineCoordinates = [];
     
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          PointLatLng(startLocation.latitude, startLocation.longitude),
          PointLatLng(endLocation.latitude, endLocation.longitude),
          travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
            result.points.forEach((PointLatLng point) {
                polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            });
      } else {
         print(result.errorMessage);
      }

      //polulineCoordinates is the List of longitute and latidtude.
      double totalDistance = 0;
      for(var i = 0; i < polylineCoordinates.length-1; i++){
           totalDistance += calculateDistance(
                polylineCoordinates[i].latitude, 
                polylineCoordinates[i].longitude, 
                polylineCoordinates[i+1].latitude, 
                polylineCoordinates[i+1].longitude);
      }
      print(totalDistance);

      setState(() {
         distance = totalDistance;
      });

      //add to the list of poly line coordinates
      addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }




//--------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    //print(latitude);
    return  Scaffold(
    //   body: Container(
    //     width:250,
    //     height: 400,
    //     child: GoogleMap(initialCameraPosition: _kGooglePlex)),
    // );
   body: GoogleMap(
           mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
        //  _controller.complete(controller);

          setState(() {

             _controller.complete(controller);
          //  GoogleMapController: controller,
          });
        },
        // markers: <Marker>{
        //     _createMarker(LatLng(52.4478, -3.5402)),
        //     _createMarker(LatLng(52.446, -3.5402))
        //   },
        markers:Set<Marker>.of(_marker),
        zoomGesturesEnabled: true,
        polylines: Set<Polyline>.of(polylines.values), //polylines
  
    ),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: find_distance,
        label: Text('Distance'),
        icon: Icon(Icons.disabled_visible_outlined),
      ),
    
    );
  }
}
