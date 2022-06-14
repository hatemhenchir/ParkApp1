import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/Views/park_owner/showReservation.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../services/payment_service.dart';
List placelibre = [] ;
var startDate ;
var finishDate ;

class AddReserv extends StatefulWidget {
  AddReserv( {Key? key, 
   required this.idPark, 
   required this.nombre_place
  }) : super(key: key);
  String idPark;
   String nombre_place;
 /* String tarif;
  List placelibre;*/

  @override
  State<AddReserv> createState() => _AddReservState();
}

class _AddReservState extends State<AddReserv> {

  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  String? PlateNumber;
  String? name;
  String? phoneNumber;
  int? place ;

  

  String? selectedItem;
  var listPlaceReservation=[];
@override
   void initState(){
     super.initState();
     placelibre.clear();
     getReservationPlace();
   }
  void getReservationPlace()async {
     await FirebaseFirestore.instance.collection("reservation").where("park",isEqualTo: "/parking/"+widget.idPark).snapshots().listen((event) {
       for(var i in event.docs){
         //print("docs=${i.data()["idPlace"]}");
         if(listPlaceReservation.contains(i.data()["idPlace"])==false){
           listPlaceReservation.add(i.data()["idPlace"]);
         }
       }
       print("listplace=$listPlaceReservation");
     }) ;
   }

  @override
  
  Widget build(BuildContext context) {
    getReservationPlace();
    final PaymentService controller = PaymentService();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          heroTag: 2,
          backgroundColor: Colors.indigo[800],
          onPressed: () async {
            //Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> Intro()));
            if (_formKey.currentState!.validate()) {
              
              var current_user = FirebaseAuth.instance.currentUser;
              if ((current_user != null)) {
                await FirebaseFirestore.instance
                    .collection("reservation")
                    .where("park", isEqualTo: "/parking/" )
                    .where("idPlace", isEqualTo: selectedItem)
                    .snapshots()
                    .listen((event) async {
                  if (event.docs.isEmpty) {
                   
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
                        'valide': "",
                        'date_entrer':"",
                        'idPlace': selectedItem
                      });

                      
                      //Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowReservation(idPark: widget.idPark, nbre_de_place: widget.nombre_place)));
                      
                    
                  } else {
                    Fluttertoast.showToast(
                        msg: "this  place  is  reserved",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 13.0);
                  }

                  setState(() {});
                });
              }
            }
          },
          label: Text(
            "Save",
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ),
      /*  appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text(
            "Make reservation",
            style: GoogleFonts.nunito(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ),*/
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  color: Colors.grey[200],
                  padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
                 
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
                                const SizedBox(
                                  height: 8,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(80, 30),
                                        primary: Colors.grey),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        
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
                                          final value =
                                              DateFormat('yyyy/MM/dd HH:mm')
                                                  .format(dateTime);
                                          Utils.showSnackBar(
                                              context, 'Selected "$value"');
                                          startDate = value;
                                          setState(() {});

                                          Navigator.pop(context);
                                        },
                                      );
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
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
                                          final value =
                                              DateFormat('yyyy/MM/dd HH:mm')
                                                  .format(dateTime);
                                          Utils.showSnackBar(
                                              context, 'Selected "$value"');
                                          finishDate = value;
                                          setState(() {});
                                          print("hiiiiiiiiiii $dateTime");
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
                            width: 50,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                          "Select \n Place",
                                          style: GoogleFonts.nunito(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                    StreamBuilder<DocumentSnapshot<Map<String , dynamic>>>(
                                               stream: FirebaseFirestore.instance.collection("places").doc(widget.idPark).snapshots(),
                                               builder: (context , snapshot ){
                                                 
                                                 final document = snapshot.data;
                                                
                                                 final text = document?.data()?["place_libre"];
                                                 for(int i=0 ; i<int.parse(widget.nombre_place) ; i++) {
                                                   if (document?.data()!["$i"] == false ) {
                                                     if(placelibre.contains("$i")==false && listPlaceReservation.contains("$i")==false ){
                                                      placelibre.add("$i");
                                                      print("$placelibre");
                                                     }
                                                   }
                                                 }
                                                 

                                                   place = text ;
                                                  
                                                 return DropdownButton<String>(
                                      value: selectedItem,
                                      items: placelibre
                                          .map((item) => DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item),
                                              ))
                                          .toList(),
                                      onChanged: (item) => setState(() {
                                        selectedItem = item;
                                        print("$selectedItem");
                                      }),
                                    
                                                 //Text("There are ${text } places free \nPlaces not reserved: \n ${placelibre}",
                                                
                                                 );
                                               },
                                             ),
                                  ],
                                ),
                              ],
                            )
                                       
                          ),
                         
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1500,
                  color: Colors.grey.shade200,
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
                                  BorderSide(color: Colors.indigo.shade800),
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
                                    BorderSide(color: Colors.indigo.shade800)),
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
                                    BorderSide(color: Colors.indigo.shade800)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: const BorderSide(color: Colors.black),
                              gapPadding: 10,
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                   /*   TextButton(
                        onPressed: () {
                          var multipleTarif;

                          //Navigator.push(context,MaterialPageRoute(builder:(context)=>AppHome()));
                          var differenceDate = DateFormat("yyyy/MM/dd HH:mm")
                              .parse(finishDate!)
                              .difference(DateFormat("yyyy/MM/dd HH:mm")
                                  .parse(startDate));
                          
                          multipleTarif =
                              ((differenceDate.inMinutes) / 60).ceil();

                          print("hhhhhh ${differenceDate.runtimeType}");
                          //print("finish  date  - start date = ${finishDate.runtimeType}");
                          if(DateFormat("yyyy/MM/dd HH:mm").parse(startDate!).isAfter(DateFormat("yyyy/MM/dd HH:mm").parse(finishDate))){
                          Fluttertoast.showToast(
                        msg: "star time is after finish time",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 13.0);
                  
                          }
                          else if(DateFormat("yyyy/MM/dd HH:mm").parse(startDate).isAtSameMomentAs(DateFormat("yyyy/MM/dd HH:mm").parse(finishDate))){
                            Fluttertoast.showToast(
                        msg: "star time is equal finish time",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 13.0);
                          } 
                          else {
                                 controller.makePayment(
                              amount: (  multipleTarif)
                                  .toString(),
                              currency: 'eur');
                          }
                         
                          //controller.setPay(false);
                        },
                        child: Text(
                          "Make payment",
                        ),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.indigo.shade800,
                            elevation: 5,
                            textStyle: GoogleFonts.nunito(
                                fontSize: 20, color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),*/
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
          mode: CupertinoDatePickerMode.dateAndTime,
          minimumDate: dateTime,
          //maximumDate: dateTime,
          //maximumDate: DateTime.parse("2027-06-15"),
          use24hFormat: true,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime 
              ),
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
     return snackBar ;

  /*  ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);*/
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