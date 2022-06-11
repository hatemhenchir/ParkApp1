import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/park_owner/form_addPark.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SearchP extends StatefulWidget {
  SearchP({Key? key}) : super(key: key);

  @override
  _SearchPState createState() => _SearchPState();
}

class _SearchPState extends State<SearchP> {
  List<Marker> markers = [];
  //int id = 1;

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);

    return Scaffold(
        body: (currentPosition != null)
            ? Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.12,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      onTap: (LatLng latLing) {
                        Marker newMarker = Marker(
                            markerId: MarkerId('Mark Position'),
                            position:
                                LatLng(latLing.latitude, latLing.longitude),
                            infoWindow: InfoWindow(title: 'new'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueRed));
                        markers.add(newMarker);
                        //id = id+1;
                        setState(() {
                          //print("our location $latLing");
                          //print(markers);
                        });
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentPosition.latitude, currentPosition.longitude),
                        zoom: 9.0,
                      ),
                      zoomGesturesEnabled: true,
                      markers: markers.map((e) => e).toSet(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      print("Longtitude = ${markers[0].position.longitude}");
                      print("LAtitiude = ${markers[0].position.latitude}");

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormAddPark(
                                  longtitude: markers[0].position.longitude,
                                  latitude: markers[0].position.latitude)));
                    },
                    child: const Text(
                      'Confirm location',
                    ),
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.black,
                        elevation: 10,
                        textStyle: const TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
