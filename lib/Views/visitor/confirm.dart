import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/intro.dart';
import 'package:flutter_application_2/Views/visitor/parking_details.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../services/payment_service.dart';

var startDate;
var finishDate;

class Confirm extends StatefulWidget {
  Confirm({Key? key, required this.idPark, required this.tarif , required this.placelibre})
      : super(key: key);
  String idPark;
  String tarif;
  List placelibre;

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  String? PlateNumber;
  String? name;
  String? phoneNumber;

 

  List <dynamic> items = placelibre;
  String? selectedItem ;
  @override

  Widget build(BuildContext context) {
    final PaymentService controller = PaymentService();
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green[300],
          onPressed: () async {
            //Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> Intro()));
            if (_formKey.currentState!.validate()) {

              var pay = controller.getPay();
              var current_user = FirebaseAuth.instance.currentUser;
              if ((current_user != null)) {
                await FirebaseFirestore.instance.collection("reservation").where("park" ,isEqualTo: "/parking/"+widget.idPark  ).where("idPlace",isEqualTo: selectedItem).snapshots().listen((event) async {
                  
                    
                  if(event.docs.isEmpty){
                    if (pay == true) {
                    await FirebaseFirestore.instance
                      .collection("reservation")
                      .doc()
                      .set({
                    'name': name,
                    'phone_number': phoneNumber,
                    'plate_number': PlateNumber,
                    'start_time': startDate,
                    'finish_time': finishDate,
                    'user': "/utilisateur/" + current_user.uid,
                    'park': "/parking/" + widget.idPark,
                    'valide':"",
                    'idPlace':selectedItem
                  });
                  
                    controller.setPay(false);
                  Navigator.pop(context);
                  
                  
                } else {
                  Fluttertoast.showToast(
                      msg: "Please make payment first",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                }
                    
                  }else{
                    Fluttertoast.showToast(
                      msg: "this  place  is  reserved",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 13.0);
                  }
                    
                  setState(() {
                    
                  });
                });
                
              }
            }
          },
          label: Text(
            "Save",
            style: GoogleFonts.nunito(
                color: Colors.white, 
                fontSize: 22, 
                fontWeight: FontWeight.w800),
          ),
        ),

        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text(
            "Make reservation",
            style: GoogleFonts.nunito(
                color: Colors.black, 
                fontSize: 22, 
                fontWeight: FontWeight.w800),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  color: Colors.grey[200],
                  padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start time",
                                  style: GoogleFonts.nunito(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800),
                                ),
                               
                                SizedBox(
                                  height: 8,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(80, 30),
                                        primary: Colors.grey),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                      //  const SizedBox(width: 8),
                                        Text(
                                          'Select time',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Utils.showSheet(
                                        context,
                                        child: buildDateTimePicker(),
                                        onClicked: () {
                                          final value = DateFormat(' HH:mm')
                                              .format(dateTime);
                                          Utils.showSnackBar(
                                              context, 'Selected "$value"');
                                          startDate = value;
                                          setState(() {});

                                          Navigator.pop(context);
                                        },
                                      );
                                    }),
                                    SizedBox(height: 10,),
                                    
                                  
                                     Text("${startDate}"),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Finish Time",
                                  style: GoogleFonts.nunito(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800),
                                ),
                               
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(40, 20),
                                        primary: Colors.grey),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          'Select time',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Utils.showSheet(
                                        context,
                                        child: buildDateTimePicker(),
                                        onClicked: () {
                                          final value = DateFormat(' HH:mm')
                                              .format(dateTime);
                                          Utils.showSnackBar(
                                              context, 'Selected "$value"');
                                          finishDate = value;
                                          setState(() {});

                                          Navigator.pop(context);
                                        },
                                      );
                                    }),
                                     SizedBox(
                                  height: 10,
                                ),
                                Text("${finishDate}"),
                              ],
                            ),
                          ),
                          Container(
                            child: DropdownButton<String>(
                              value:selectedItem,
                              items: items.map((item) => 
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                                )
                                ).toList(),
                                onChanged: (item)=> setState(() {
                                  selectedItem = item;
                                  print("$selectedItem");
                                }),  ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1500,
                  color: Colors.white,
                  margin: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
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
                            labelStyle: GoogleFonts.nunito(
                                fontSize: 20, color: Colors.black87),
                            hintText: "enter your name ",
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 18, color: Colors.black54),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              gapPadding: 10,
                              borderSide:
                                  BorderSide(color: Colors.green.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: const BorderSide(color: Colors.black),
                              gapPadding: 10,
                            )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        onChanged: (newValue) => phoneNumber = newValue,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please Fill  phone number input';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Phone number",
                            labelStyle: GoogleFonts.nunito(
                                fontSize: 20, color: Colors.black87),
                            hintText: "enter your phone number ",
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 18, color: Colors.black54),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                gapPadding: 10,
                                borderSide:
                                    BorderSide(color: Colors.green.shade300)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: const BorderSide(color: Colors.black),
                              gapPadding: 10,
                            )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        onChanged: (newValue) => PlateNumber = newValue,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please Fill  plate  number input';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Plate Number",
                            labelStyle: GoogleFonts.nunito(
                                fontSize: 20, color: Colors.black87),
                            hintText: "enter your plate number ",
                            hintStyle: GoogleFonts.nunito(
                                fontSize: 18, color: Colors.black54),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                gapPadding: 10,
                                borderSide:
                                    BorderSide(color: Colors.green.shade300)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: const BorderSide(color: Colors.black),
                              gapPadding: 10,
                            )),
                      ),
                       SizedBox(height: 30,),
                      TextButton(
                        onPressed: () {
                              var multipleTarif;
                          //Navigator.push(context,MaterialPageRoute(builder:(context)=>AppHome()));
                          var differenceDate=DateTime.parse("2021-12-23${finishDate}:00").difference(DateTime.parse("2021-12-23${startDate}:00"));

                          if(((differenceDate.inMinutes)/60).ceil()>((differenceDate.inMinutes)/60)){
                            print("akber");
                             multipleTarif=((differenceDate.inMinutes)/60).ceil();
                             print(multipleTarif);
                          }else{
                            print("as8er");
                            multipleTarif=((differenceDate.inMinutes)/60).ceil();
                            print(multipleTarif);
                          }
                          print("hhhhhh ${differenceDate.inMinutes}");
                          //print("finish  date  - start date = ${finishDate.runtimeType}");
                          controller.makePayment(
                              amount: (int.parse(widget.tarif)*multipleTarif).toString(), currency: 'eur');
                              //controller.setPay(false);
                        },
                        child: Text(
                          "Make payment",
                        ),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.green.shade300,
                            elevation: 5,
                            textStyle: GoogleFonts.nunito(
                                fontSize: 20, color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ));
  }

  Widget buildDateTimePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.time,
          //minimumDate: dateTime,
          //maximumDate: dateTime,
          //maximumDate: DateTime.parse("2022-06-15"),
          use24hFormat: true,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );
}

class Utils {
  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  static void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Done'),
            onPressed: onClicked,
          ),
        ),
      );

  static showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(fontSize: 24)),
    );
    // return snackBar ;

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(90, 40), primary: Colors.grey),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            Text(
              'Select time',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        onPressed: onClicked,
      );
}