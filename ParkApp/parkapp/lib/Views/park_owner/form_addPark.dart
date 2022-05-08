import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/constants.dart';
import 'package:flutter_application_2/Views/park_owner/park.dart';

import 'package:provider/provider.dart';


class FormAddPark extends StatelessWidget {
  const FormAddPark({Key? key, tarif}):super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Add Parking" , 
          textAlign: TextAlign.center,),
      ),
    
      
    
      body: Container(
        
        
        child: SizedBox(
          width: double.infinity,
          
    
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10 ),
          child:SingleChildScrollView(
            child:Column(
            
            children: const [
              SizedBox(height: 20,),
              //Text(
               // "Add Parking" , 
                // style: TextStyle(
                // color: Colors.black,
                // fontSize: 30,
                // fontWeight: FontWeight.bold,
                // ),
              // ),
              SizedBox(height: 5,),
               Text(
               "Complete your parking details ",
               textAlign: TextAlign.center,
               style: TextStyle(fontSize: 25),
               
               ),
              SizedBox(height: 5,),
               Padding(padding: EdgeInsets.symmetric(vertical: 15)),
               SignForm(),
    
               Padding(padding: EdgeInsets.symmetric(vertical: 15)),
               SizedBox(height: 20,),
               
               
    
           ]),
        
    
        ),
      
    ),
    ),),);
  }
}

class SignForm extends StatefulWidget {
  const SignForm({ Key? key }) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  
  
  String? tarif;
  
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:Column(
        children: [
         
         
         Image.asset("lib/img/add.jpg", width: 500,height: 250,),
         buildTarifFormField(),
         const SizedBox(height: 30,),
         
         
         FormError(errors: errors),
      



      TextButton(
        onPressed: () async {
          if(_formKey.currentState!.validate()){
            //_formKey.currentState!.save();
            var current_user=await FirebaseAuth.instance.currentUser;
            FirebaseFirestore.instance.collection("parking").doc().set({
              'tarif':tarif,
              'user':'/utilisateur/'+ current_user!.uid
            });
            Navigator.push(context,MaterialPageRoute(builder:(context)=> ConsultPark()));
          }
        } ,
        child: const Text('  Add  ',) ,
        
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
        
    ]) ,
      
    );}

  
            
              
           

    TextFormField buildTarifFormField(){
            return TextFormField(
            
              
              onChanged: (newValue) => tarif = newValue,
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
            
    );}
   

     
    
}
  

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: 
        List.generate(errors.length, (index) => formErrorText(error: errors[index])),
      
    );
    
  }
  Row formErrorText({required String error}){
  return Row(
    children: [
      SizedBox(width: 20,),
      Text(error)
    ],
  );
  }
}
