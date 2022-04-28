import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/constants.dart';

import 'package:provider/provider.dart';


class FormAddPark extends StatelessWidget {
  const FormAddPark({Key? key}):super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    
      
    
      body: Container(
        
        
        child: SizedBox(
          width: double.infinity,
          
    
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10 ),
          child:SingleChildScrollView(
            child:Column(
            
            children: [
              const SizedBox(height: 50,),
              const Text(
                "Add Parking" , 
                 style: TextStyle(
                 color: Colors.black,
                 fontSize: 30,
                 fontWeight: FontWeight.bold,
                 ),
               ),
              const SizedBox(height: 5,),
               const Text(
               "Complete your parking details ",
               textAlign: TextAlign.center,
               
               ),
              const SizedBox(height: 20,),
               const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
               const SignForm(),
    
               const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
               const SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: const [
                   Text("By continuing you confirm that you agree \n with our Term and Condition  ",
                   style: TextStyle(
                     fontSize: 16
                   ) ,),
                   
                 ],
               )
               
    
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
         
         
         Image.asset("lib/img/park3.png"),
         buildTarifFormField(),
         const SizedBox(height: 30,),
         
         
         FormError(errors: errors),
      



      TextButton(
        onPressed: (){
          if(_formKey.currentState!.validate()){
            _formKey.currentState!.save();
          }
        } ,
        child: const Text('Continue',) ,
        
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.purple[800],
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
