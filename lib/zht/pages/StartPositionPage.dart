import 'package:OutOfBounds/zht/LocationProvider.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class StartPosition extends StatefulWidget {
  @override
  StartPositionState createState() => StartPositionState();
}
class MyClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
  var path = Path();
  path.lineTo(0, size.height-50);
  path.quadraticBezierTo(
    size.width / 2, 
    size.height,
    size.width,
    size.height - 50
  );
  path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(MyClipper oldClipper) => false;
}

class StartPositionState extends State<StartPosition> {
  Geolocator geolocator = new Geolocator();
  double distanceInMeters;


  Future<double> distanceBetween2(
      LocationData current, LocationData start) async {
    if (current.latitude != null &&
        start.latitude != null &&
        start.longitude != null &&
        current.longitude != null) {
      return distanceInMeters = await geolocator.distanceBetween(
          current.latitude, current.longitude, start.latitude, start.longitude);
    }
    return distanceInMeters;
  }

  void updateDistance(LocationProvider provider) async {
    var distance = await distanceBetween2(provider.current, provider.starting);
    setState(() {
      distanceInMeters = distance;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, _provider, _) {
      if (_provider.starting != null) {
        updateDistance(_provider);
        return Scaffold(
            backgroundColor: Colors.blue,
            body: Column(
               children: <Widget>[
                  Text(
                      "LATITUDE: ${_provider.starting.latitude}, LONGITUDE: ${_provider.starting.longitude}"),
                  Text("Actually at $distanceInMeters meters from this point.")
               ]));
      } else {
        return Scaffold(
            backgroundColor: Colors.blue,
            body: Column( 
               children: <Widget>[
                 Stack( 
              children: <Widget>[
                Container(             
                  decoration: BoxDecoration(color: Colors.red),
                  child: ClipPath(
                    clipper: MyClipper(), 
                    child:Image.asset('assets/images/googlemap.png'),     
                  ),
                ),
                Positioned(
                  left:100.0,
                  top:100.0,
                  child:ClipOval(
                    child:Container(
                      height: 180,
                      decoration: BoxDecoration(color:Colors.black),
                      child: Image.asset('assets/images/gear.png', height:6.0),
                    )
                  ), 
                ),                 
                Text("You don't have a start position ! \n Please choose a Start Position"),
              ]
                 )
               ]
            )
          );
        }
      }
    );
  }
}
