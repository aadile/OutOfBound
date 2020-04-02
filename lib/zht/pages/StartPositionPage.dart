import 'package:flutter/material.dart';
import 'package:OutOfBounds/zht/location-holder.dart';

class StartPositionPage extends StatelessWidget{

  getLatandLng(){
    if (startingLocationData != null)   
      return  Text("LATITUDE: ${startingLocationData.latitude}, LONGITUDE: ${startingLocationData.longitude}");
     else
      return Text("You don't have a start position");
  }

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.blue,
        body:Center(
          child: getLatandLng(),
        )       
      ),
    );
  }
}