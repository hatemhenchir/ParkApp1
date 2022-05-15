import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/intro.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
 var startDate ;
class Confirm extends StatefulWidget {
  const Confirm({ Key? key }) : super(key: key);

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  DateTime dateTime = DateTime.now();
  
  String? PlateNumber;
  @override
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
       
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> Intro()));
        }, 
         label:  Text("Save",
             style: GoogleFonts.nunito(
             color: Colors.white,
             fontSize: 22 ,
             fontWeight: FontWeight.w800 ),
                   
          ),),
      appBar: AppBar(
        title: Text("Make reservation" ,
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22 ,
          fontWeight: FontWeight.w800 ),
      ),),

      
      body: SingleChildScrollView(
        child:
           Column(
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
                    Text("Start time",
                    style: GoogleFonts.nunito(
                    color: Colors.grey,
                    fontSize: 17 ,
                    fontWeight: FontWeight.w800 ),
                    ),
                    Text("${startDate}"),
                    SizedBox(height: 8,),
                    ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(90, 40),
          primary: Colors.grey
          ),
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
        onPressed:(){
          Utils.showSheet(
                       context,
                       child: buildDateTimePicker(),
                       onClicked: () {
                       final value =
                       DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
                       Utils.showSnackBar(context, 'Selected "$value"');
                       startDate = value ;
                       
                       Navigator.pop(context);
                     },
                    );
        }
      ),
                
                    
                  
                    
                  ],
                ),
              ),
              
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Finish Time",
                     style: GoogleFonts.nunito(
                     color: Colors.grey,
                     fontSize: 17 ,
                     fontWeight: FontWeight.w800 ),
                    ),
                    SizedBox(height: 8,),
                    ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(90, 40),
          primary: Colors.grey
          ),
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
        onPressed:(){
          Utils.showSheet(
                       context,
                       child: buildDateTimePicker(),
                       onClicked: () {
                       final value =
                       DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
                       Utils.showSnackBar(context, 'Selected "$value"');
                       
                       
                       Navigator.pop(context);
                     },
                    );
        }
      ),
                    
                      
                  ],
                ),
              ),
            ],)
        ],
      ),
    ),
                
                Container(
                  height: 1500,
                  color: Colors.white,
                  margin: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                       TextFormField(
            
              
              onChanged: (newValue) => PlateNumber = newValue,
              validator:(value){
              if(value!.isEmpty){
                return 'please Fill tarif number input';
              }
            },
              
             decoration: InputDecoration(
              labelText: "Name",
              hintText: "enter your name ",
              floatingLabelBehavior: FloatingLabelBehavior.always, 
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 20),

                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                gapPadding: 10,
                borderSide: const BorderSide(color: Colors.blue)
               ),
             focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: Colors.black),
                gapPadding: 10,

               )
            ),
            
    ),
                      SizedBox(height: 25,),
                       TextFormField(
            
              
              onChanged: (newValue) => PlateNumber = newValue,
              validator:(value){
              if(value!.isEmpty){
                return 'please Fill tarif number input';
              }
            },
              
             decoration: InputDecoration(
              labelText: "Phone number",
              hintText: "enter your phone number ",
              floatingLabelBehavior: FloatingLabelBehavior.always, 
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 20),

                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                gapPadding: 10,
                borderSide: const BorderSide(color: Colors.blue)
               ),
             focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: Colors.black),
                gapPadding: 10,

               )
            ),
            
    ),         SizedBox(height: 25,),
                      TextFormField(
            
              
              onChanged: (newValue) => PlateNumber = newValue,
              validator:(value){
              if(value!.isEmpty){
                return 'please Fill tarif number input';
              }
            },
              
             decoration: InputDecoration(
              labelText: "Plate Number",
              hintText: "enter your plate number ",
              floatingLabelBehavior: FloatingLabelBehavior.always, 
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 20),

                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                gapPadding: 10,
                borderSide: const BorderSide(color: Colors.blue)
               ),
             focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: Colors.black),
                gapPadding: 10,

               )
            ),
            
    ),
                    ],
                  ),
                )
              ],
            ),)
      
    );
  }
  Widget buildDateTimePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.dateAndTime,
          minimumDate: dateTime,
          maximumDate: DateTime.parse("2022-05-16"),
          use24hFormat: true,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),);
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

  static  showSnackBar(BuildContext context, String text) {
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
          minimumSize: Size(90, 40),
          primary: Colors.grey
          ),
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