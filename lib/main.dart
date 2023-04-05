

import 'package:flutter/material.dart';
import 'package:location_practice/location_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: LocationPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold();
     
  }
}


//----------------------------
//tryy..
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// void main(){
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget{
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   GoogleMapController? mapController; //contrller for Google map
//   PolylinePoints polylinePoints = PolylinePoints();

//   String googleAPiKey = "AIzaSyBXmQ1qiGg9jzCyty0P-G_z0okgfIFgZd4";
  
//   Set<Marker> markers = Set(); //markers for google map
//   Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

//   LatLng startLocation = LatLng(33.6676967,73.0752067);  
//   LatLng endLocation = LatLng(33.7,73.1); 
                            

//   @override
//   void initState() {

//      markers.add(Marker( //add start location marker
//         markerId: MarkerId(startLocation.toString()),
//         position: startLocation, //position of marker
//         infoWindow: InfoWindow( //popup info 
//           title: 'Starting Point ',
//           snippet: 'Start Marker',
//         ),
//         icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//       ));

//       markers.add(Marker( //add distination location marker
//         markerId: MarkerId(endLocation.toString()),
//         position: endLocation, //position of marker
//         infoWindow: InfoWindow( //popup info 
//           title: 'Destination Point ',
//           snippet: 'Destination Marker',
//         ),
//         icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//       ));
      
//       getDirections(); //fetch direction polylines from Google API
      
//     super.initState();
//   }

//   getDirections() async {
//       List<LatLng> polylineCoordinates = [];
     
//       PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//           googleAPiKey,
//           PointLatLng(startLocation.latitude, startLocation.longitude),
//           PointLatLng(endLocation.latitude, endLocation.longitude),
//           travelMode: TravelMode.driving,
//       );

//       if (result.points.isNotEmpty) {
//             result.points.forEach((PointLatLng point) {
//                 polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//             });
//       } else {
//          print(result.errorMessage);
//       }
//       addPolyLine(polylineCoordinates);
//   }

//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.deepPurpleAccent,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//           appBar: AppBar( 
//              title: Text("Route Driection in Google Map"),
//              backgroundColor: Colors.deepPurpleAccent,
//           ),
//           body: GoogleMap( //Map widget from google_maps_flutter package
//                     zoomGesturesEnabled: true, //enable Zoom in, out on map
//                     initialCameraPosition: CameraPosition( //innital position in map
//                       target: startLocation, //initial position
//                       zoom: 16.0, //initial zoom level
//                     ),
//                     markers: markers, //markers to show on map
//                     polylines: Set<Polyline>.of(polylines.values), //polylines
//                     mapType: MapType.normal, //map type
//                     onMapCreated: (controller) { //method called when map is created
//                       setState(() {
//                         mapController = controller; 
//                       });
//                     },
//               ),
//        );
//   }
// }

//package example..
