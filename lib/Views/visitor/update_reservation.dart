import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/Views/visitor/New_navBar.dart';
class UpdateReservation extends StatelessWidget {
   UpdateReservation({ Key? key,required this.name,required this.id,required this.plateNumber,required this.phoneNumber}) : super(key: key);
  String name;
  String id;
  String plateNumber;
  String phoneNumber;
  //final String tarif;
  //final String id;
  //final String name;
  //final String nbr_de_place;
  final _formKey = GlobalKey<FormState>();
  

  String? newPhoneNumber;
  String? newname;
  String? newPlatNumber;
  @override
  Widget build(BuildContext context) {
    String? validatePhone(String? formPhone) {
      if (formPhone == null || formPhone.isEmpty) return 'phone   is required.';
      String pattern = r'^.{8,8}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formPhone)) return '''phone must  8 number''';

      return null;
    }
    return Scaffold(
      
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 30),
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
                  initialValue: phoneNumber,
                  onChanged: (newValue) => newPhoneNumber = newValue,
                  validator: validatePhone,

                  decoration: InputDecoration(
                      labelText: "phone  number",
                      hintText: "enter phone number ",
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
                 
                  
                  initialValue: plateNumber,
                  onChanged: (newValue) => newPlatNumber = newValue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please Fill plate number input";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Plate number ",
                      hintText: "enter numbre plate  ",
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
                          .collection("reservation")
                          .doc(id)
                          .update({
                        'phone_number': newPhoneNumber ?? phoneNumber,
                        'name':newname ?? name,
                        'plate_number':newPlatNumber ?? plateNumber
                      });
                      
                      

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageVisitor()));
                    }
                  },
                  child: const Text(
                    '  Save  ',
                  ),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.green.shade300,
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