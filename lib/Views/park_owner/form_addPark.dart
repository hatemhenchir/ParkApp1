import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/Views/constants.dart';
import 'package:flutter_application_2/Views/park_owner/mark.dart';
import 'package:flutter_application_2/Views/park_owner/park.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';


class FormAddPark extends StatelessWidget {
  FormAddPark({Key? key, tarif, this.longtitude, this.latitude})
      : super(key: key);
  final longtitude;
  final latitude;
  final _formKey = GlobalKey<FormState>();
  String? newTarif;
  String? newlongtitude;
  String? newlatitude;
  String? newnbrplace;
  String? name;
  final myuuid = Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    /*  appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Add Parking",
          textAlign: TextAlign.center,
        ),
      ),*/
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 25,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                
                TextButton(
                  
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SearchP()));
                    },
                    
                    child: Text("Choose parking place"),
                      style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.brown.shade400,
                      elevation: 5,
                      textStyle: GoogleFonts.nunito (
                          letterSpacing: 2,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.white ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onChanged: (newValue) => name = newValue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please Fill name input';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: GoogleFonts.nunito (
                          letterSpacing: 1,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700 ),
                      hintText: "enter name ",
                      hintStyle: GoogleFonts.nunito (
                          letterSpacing: 1,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 10,
                          borderSide:
                               BorderSide(color: Colors.grey.shade500)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade500),
                        gapPadding: 10,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (newValue) => newTarif = newValue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please Fill fees input';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Fees",
                      labelStyle: GoogleFonts.nunito (
                          letterSpacing: 1,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700 ),
                      hintText: "enter Fees",
                      hintStyle: GoogleFonts.nunito (
                          letterSpacing: 1,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 10,
                          borderSide:
                              BorderSide(color: Colors.grey.shade500)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  BorderSide(color: Colors.grey.shade500),
                        gapPadding: 10,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  //desactivate  TextField
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  /**************** */
                  initialValue: "${longtitude}",

                  onChanged: (newValue) => newlongtitude = newValue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please Fill Longitude input';
                    }
                  },

                  decoration: InputDecoration(
                      labelText: "Longitude",
                      labelStyle: GoogleFonts.nunito (
                          letterSpacing: 1,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700 ),
                      hintText: "enter Longitude ",
                      hintStyle: GoogleFonts.nunito (
                          letterSpacing: 1,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 10,
                          borderSide:
                               BorderSide(color: Colors.grey.shade500)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade500),
                        gapPadding: 10,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  //disable  TextField
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  //************* *******************************/
                  initialValue: "${latitude}",

                  onChanged: (newValue) => newlatitude = newValue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please Fill Latitude input';
                    }
                  },

                  decoration: InputDecoration(
                      labelText: "Latitude",
                      labelStyle: GoogleFonts.nunito (
                          letterSpacing: 1,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700 ),
                      hintText: "enter Latitude ",
                      hintStyle: GoogleFonts.nunito (
                          letterSpacing: 1,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 10,
                          borderSide:
                               BorderSide(color: Colors.grey.shade500)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  BorderSide(color: Colors.grey.shade500),
                        gapPadding: 10,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (newValue) => newnbrplace = newValue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please Fill nombre de  place  input';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Toral nembre of  places",
                      labelStyle: GoogleFonts.nunito (
                          letterSpacing: 1,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700 ),
                      hintText: "enter total nembre of places ",
                      hintStyle: GoogleFonts.nunito (
                          letterSpacing: 1,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 18),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 10,
                          borderSide:
                               BorderSide(color: Colors.grey.shade500)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  BorderSide(color: Colors.grey.shade500),
                        gapPadding: 10,
                      )),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var current_user =
                          await FirebaseAuth.instance.currentUser;
                      if (current_user != null)
                        FirebaseFirestore.instance
                            .collection("parking")
                            .doc(myuuid)
                            .set({
                          'name': name,
                          'tarif': newTarif,
                          'longtitude': longtitude,
                          'latitude': latitude,
                          'nbre_de_place': newnbrplace,
                          'user': '/utilisateur/' + current_user.uid
                        });
                        FirebaseFirestore.instance.collection("places").doc(myuuid).set({ 
                          "place_libre" : int.parse(newnbrplace!) , for (int i = 0 ; i< int.parse(newnbrplace!) ; i++) "$i": false 

                        
                        });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConsultPark()));
                      //print("tarif=${name}");
                    }
                  },
                  child: const Text(
                    'Add Parking',
                  ),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.brown.shade400,
                      elevation: 10,
                      textStyle: GoogleFonts.nunito (
                          letterSpacing: 2,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.white ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 20,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
