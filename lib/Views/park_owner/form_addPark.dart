import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/Views/constants.dart';
import 'package:flutter_application_2/Views/park_owner/mark.dart';
import 'package:flutter_application_2/Views/park_owner/park.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Add Parking",
          textAlign: TextAlign.center,
        ),
      ),
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
                    child: Text("Se localise"),
                      style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.grey,
                      //elevation: 10,
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
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
                      labelText: "name",
                      hintText: "enter name ",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          gapPadding: 10,
                          borderSide:
                              const BorderSide(color: Color(0xFF757575))),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(color: Color(0xFF757575)),
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
                      return 'please Fill tarif input';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Tarif",
                      hintText: "enter tarif ",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          gapPadding: 10,
                          borderSide:
                              const BorderSide(color: Color(0xFF757575))),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(color: Color(0xFF757575)),
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
                      return 'please Fill Longtitude input';
                    }
                  },

                  decoration: InputDecoration(
                      labelText: "Longtitude",
                      hintText: "enter Longtitude ",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          gapPadding: 10,
                          borderSide:
                              const BorderSide(color: Color(0xFF757575))),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(color: Color(0xFF757575)),
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
                      hintText: "enter Latitude ",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          gapPadding: 10,
                          borderSide:
                              const BorderSide(color: Color(0xFF757575))),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(color: Color(0xFF757575)),
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
                      labelText: "nombre de  place",
                      hintText: "enter nombre de  place ",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          gapPadding: 10,
                          borderSide:
                              const BorderSide(color: Color(0xFF757575))),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: const BorderSide(color: Color(0xFF757575)),
                        gapPadding: 10,
                      )),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var current_user =
                          await FirebaseAuth.instance.currentUser;
                      if (current_user != null)
                        FirebaseFirestore.instance
                            .collection("parking")
                            .doc()
                            .set({
                          'name': name,
                          'tarif': newTarif,
                          'longtitude': longtitude,
                          'latitude': latitude,
                          'nbre_de_place': newnbrplace,
                          'user': '/utilisateur/' + current_user.uid
                        });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConsultPark()));
                      //print("tarif=${name}");
                    }
                  },
                  child: const Text(
                    '  Save  ',
                  ),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      elevation: 10,
                      textStyle: const TextStyle(fontSize: 28),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
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
