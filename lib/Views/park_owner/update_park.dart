import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'New_Park.dart';

class UpdatePark extends StatelessWidget {
  UpdatePark(
      {Key? key,
      required this.tarif,
      required this.name,
      required this.nbr_de_place,
      required this.id})
      : super(key: key);
  final String tarif;
  final String id;
  final String name;
  final String nbr_de_place;
  final _formKey = GlobalKey<FormState>();

  String? newtarif;
  String? newname;
  String? newNbreDePlace;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,

        title: const Text(
          "Update Parking",
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
                TextFormField(
                  initialValue: name,
                  onChanged: (newValue) => newname = newValue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please fill name input';
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
                  initialValue: tarif,
                  onChanged: (newValue) => newtarif = newValue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please fill tarif input';
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  initialValue: nbr_de_place,
                  onChanged: (newValue) => newNbreDePlace = newValue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please fill place number input';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "place  number",
                      hintText: "enter place number ",
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection("parking")
                          .doc(id)
                          .update({
                        'tarif': newtarif ?? tarif,
                        'name': newname ?? name,
                        'nbre_de_place': newNbreDePlace ?? nbr_de_place
                      });
                      FirebaseFirestore.instance
                          .collection("places")
                          .doc(id)
                          .set({
                        'place_libre': newNbreDePlace ?? nbr_de_place,
                        for (int i = 0;
                            i < int.parse(newNbreDePlace ?? nbr_de_place);
                            i++)
                          "$i": false
                      });

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewConsultPark()));
                      //Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    '  Save  ',
                  ),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blueGrey.shade700,
                      elevation: 10,
                      textStyle: const TextStyle(fontSize: 25),
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
