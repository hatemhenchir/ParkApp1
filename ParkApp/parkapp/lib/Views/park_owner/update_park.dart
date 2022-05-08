import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/constants.dart';
import 'package:flutter_application_2/Views/park_owner/park.dart';

import 'package:provider/provider.dart';


class UpdatePark extends StatelessWidget {
   UpdatePark({Key? key, required this.tarif, required this.id}):super(key: key);
   final String tarif;
   final String id;
  final _formKey = GlobalKey<FormState>();
  
  
  String? newtarif;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Update Parking" , 
          textAlign: TextAlign.center,),
      ),
    
      
    
      body: Form(
        key: _formKey,
        
        
        child: SizedBox(
          width: double.infinity,
          
    
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10 ),
          child:SingleChildScrollView(
            child:Column(
            
            children:  [
              const SizedBox(height: 25,),
              
              
              
              

               const Padding(padding: EdgeInsets.symmetric(vertical: 15)),

               Image.asset("lib/img/add.jpg", width: 500,height: 250,),
              
               TextFormField(
               
               initialValue: tarif,
              
                onChanged: (newValue)=> newtarif=newValue,
                 validator:(value){
              if(value!.isEmpty){
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
                borderSide: const BorderSide(color: Color(0xFF757575))
               ),
             focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: Color(0xFF757575)),
                gapPadding: 10,

               )
            ),
            
    ),
               
    
               const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
                TextButton(
                 onPressed: (){
                 if(_formKey.currentState!.validate()){
                 FirebaseFirestore.instance.collection("parking").doc(id).update({'tarif':newtarif,});
                 Navigator.push(context,MaterialPageRoute(builder:(context)=> ConsultPark()));
                 }
                 } ,
        child: const Text('  Save  ',) ,
        
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.teal,
          elevation: 10,
          textStyle: const TextStyle(fontSize: 28),
          
          
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
        ),
      ),
               const SizedBox(height: 20,),
               
               
    
           ]),
        
    
        ),
      
    ),
    ),),);
  }
}
