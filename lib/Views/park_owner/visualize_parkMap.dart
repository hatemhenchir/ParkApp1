import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class VisializePark extends StatefulWidget {
  const VisializePark({Key? key}) : super(key: key);

  @override
  _VisializeParkState createState() => _VisializeParkState();
}

class _VisializeParkState extends State<VisializePark> {
  Set<Marker> _markers = {};
 

  void _onMapCreated(GoogleMapController controller) async {
     var current_user= FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("parking").where("user",isEqualTo: "/utilisateur/"+current_user!.uid)
        .snapshots()
        .listen((event) {
      //_markers={};
      setState(() {
        for (var doc in event.docs) {
          _markers.add(
            Marker(
                markerId: MarkerId(doc.id),
                position:
                    LatLng(doc.data()["latitude"], doc.data()["longtitude"]),
                onTap: () {
                 
                              
                },
                infoWindow: InfoWindow(
                  title: doc.data()["name"],
                  snippet: 'Latitude: ${doc.data()["latitude"]}\n Longitude: ${doc.data()["longtitude"]}',
                  //snippet: doc.data()["latitude"]
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure)),
          );
        }
        //print("ahlaaaaaaaaaa ${_markers}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);

    return Scaffold(
        body: (currentPosition != null)
            ? Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.13,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        markers: _markers,
                        mapType: MapType.normal,
                         myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                           currentPosition.latitude,
                            currentPosition.longitude),
                          zoom: 9.0,
                        ),
                        zoomGesturesEnabled: true,
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}