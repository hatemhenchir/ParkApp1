
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/Views/park_owner/form_addPark.dart';

import 'package:flutter_application_2/Views/park_owner/park.dart';
import 'package:flutter_application_2/Views/park_owner/visualize_parkMap.dart';
import 'package:flutter_application_2/Views/visitor/New_login.dart';

import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';

class NewConsultPark extends StatefulWidget {
  const NewConsultPark({Key? key}) : super(key: key);

  @override
  State<NewConsultPark> createState() => _NewConsultParkState();
}

class _NewConsultParkState extends State<NewConsultPark> {
  GlobalKey<CurvedNavigationBarState> _NavKey = GlobalKey();
  var AllPages = [ConsultPark(), FormAddPark(), VisializePark()];
  var myindex = 0;

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);
    return Scaffold(
      // backgroundColor: Colors.green.shade300,
      bottomNavigationBar: CurvedNavigationBar(
          key: _NavKey,
          backgroundColor: Colors.white,
          color: Colors.blueGrey.shade700,
          animationDuration: Duration(microseconds: 0),
          animationCurve: Curves.fastLinearToSlowEaseIn,
          onTap: (index) {
            setState(() {
              myindex = index;
            });
          },
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.local_parking_rounded,
              color: Colors.white,
              size: 30,
            ),
          ]),
      body: Stack(
        children: [
          Container(
            child: AllPages[myindex],
          ),
          Positioned(
              top: 60.0,
              right: 10.0,
              child: CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.9),
                child: IconButton(
                  icon: Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> LoginScreen()));
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}
