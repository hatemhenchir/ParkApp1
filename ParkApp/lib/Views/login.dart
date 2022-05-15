import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_application_2/Views/chose_account.dart';
//import 'package:flutter_application_2/Views/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter_application_2/Views/intro.dart';
import 'package:flutter_application_2/Views/park_owner/choice_activity.dart';

import 'package:flutter_application_2/Views/visitor/app_bar.dart';
import 'package:flutter_application_2/Views/sign.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Login extends StatelessWidget {
  const Login({Key? key}):super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

     appBar: AppBar(
       backgroundColor: Colors.white,
       elevation: 0,
       iconTheme: const IconThemeData(color: Colors.black),
       centerTitle: true,

       title: const Text(
         "Sign In",
         
         style: TextStyle(
           color: Color(0XFFB0BEC5),
           fontSize: 22 ,
           
           
          ),
        ),
      ),

      body: Container(
        
        
        child: SizedBox(
          width: double.infinity,
          

          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25 ),
          child:SingleChildScrollView(
            child:Column(
            
            children: [
              const SizedBox(height: 2,),
              const Text(
                "Welcome Back" , 
                 style: TextStyle(
                 color: Colors.black,
                 fontSize: 30,
                 fontWeight: FontWeight.bold
                 ),
               ),
              const SizedBox(height: 15,),
               const Text(
               "Sign in with your email and password ",
               textAlign: TextAlign.center,
               style: TextStyle(
                 fontSize: 20,
               ),
               ),
              const SizedBox(height: 25,),
               const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
               const SignForm(),

               const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
               const SizedBox(height: 30,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:  [
                   const Text("Don't have an account? ",
                   style: TextStyle(
                     fontSize: 16
                   ) ,),
                   GestureDetector(
                     onTap:() =>  Navigator.push(context, MaterialPageRoute(builder:(context)=> Sign())),
                     child:const Text(
                       "Sign Up ",
                       style: TextStyle(
                       fontSize: 18,
                        color: Colors.teal
                   ) ,)
                   ),
                   
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
  TextEditingController _emailcontroller=TextEditingController();
  TextEditingController _passwordcontroller=TextEditingController();
  String errorMessage = '';
  @override
  void dispose(){
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }
  String? email;
  String? password;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:Column(
        children: [
         buildEmailFormField(),
         const SizedBox(height: 40,),
          
         buildPassFormField(),
         const SizedBox(height: 40,),
         
         FormError(errors: errors),
      



      TextButton(
        onPressed: () async{
          if(_formKey.currentState!.validate()){
            try{
            var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailcontroller.text,password: _passwordcontroller.text);
            if(result!=null){
              final User? user = FirebaseAuth.instance.currentUser;
              final  userId=user!.uid;
              
              await FirebaseFirestore.instance.collection("utilisateur").doc(userId).get().then((DocumentSnapshot snapshot){setState(() {
                if(snapshot.get("role")=='proprietaire'){
                    Navigator.push(context,MaterialPageRoute(builder:(context)=> Choice()));
                }
                else if(snapshot.get("role")=="visiteur"){
                  Navigator.push(context,MaterialPageRoute(builder:(context)=>AppHome()));
                }
              });} );
              //Navigator.push(context,MaterialPageRoute(builder:(context)=>AppHome()));
            }errorMessage = '';} on FirebaseAuthException catch(error){
              errorMessage=error.message!;
              Fluttertoast.showToast(msg: errorMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 10.0);
              
              
              
            }
            setState(() {
              
            });
            //_formKey.currentState!.save();
          }
        } ,
        child: const Text('Continue',) ,
        
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

  TextFormField buildEmailFormField(){
    String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';
     String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}
    return TextFormField(
      controller: _emailcontroller,
            keyboardType: TextInputType.emailAddress,
            onChanged: (newValue)=> email=newValue,
           
            
            validator:validateEmail,
            
              
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always, 
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 42, vertical: 20
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                gapPadding: 10,
                borderSide: const BorderSide(color: Color(0xFF757575))
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: Color(0xFF757575)),
                gapPadding: 10,
              ),
            ),
          );}

          TextFormField buildPassFormField(){
            String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) return 'Password is required.';
  String pattern =
      r'^.{6,}$';
      RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''Password must be at least 6 characters''';

  return null;
}
            return TextFormField(
              controller: _passwordcontroller,
            
              obscureText: true,
              onChanged: (newValue) => password = newValue,
              
               validator:validatePassword,
             decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
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
    );
        }}
  

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