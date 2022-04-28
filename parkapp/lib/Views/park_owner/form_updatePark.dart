import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/constants.dart';

import 'package:provider/provider.dart';


class FormUpdatePark extends StatelessWidget {
  const FormUpdatePark({Key? key}):super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Update Parking" , 
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
              
              SizedBox(height: 5,),
               //Text(
               //"Complete your parking details ",
               //textAlign: TextAlign.center,
              // style: TextStyle(fontSize: 25),
               
              // ),
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
        onPressed: (){
          if(_formKey.currentState!.validate()){
            _formKey.currentState!.save();
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
        
    ]) ,
      
    );}

  
            
              
           

    TextFormField buildTarifFormField(){
            return TextFormField(
            
              
              onSaved: (newValue) => tarif = newValue,
              onChanged: (value){
                 
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
