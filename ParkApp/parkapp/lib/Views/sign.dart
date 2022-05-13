import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/constants.dart';
import 'package:flutter_application_2/Views/login.dart';

 

class Sign extends StatelessWidget {
    Sign({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     appBar: AppBar(
       backgroundColor: Colors.white,
       elevation: 0,
       iconTheme: const IconThemeData(color: Colors.black),
       centerTitle: true,

       title: const Text(
         "Sign Up",
         
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
            padding: const EdgeInsets.symmetric(horizontal: 10 ),
          child:SingleChildScrollView(
            child:Column(
            
            children:  [
              SizedBox(height: 5,),
              const Text(
                "Register Account" , 
                 style: TextStyle(
                 color: Colors.black,
                 fontSize: 30,
                 fontWeight: FontWeight.bold,
                 
                 ),
               ),
              SizedBox(height: 5,),
               const Text(
               "Complete your details ",
               textAlign: TextAlign.center,
               
               ),
              SizedBox(height: 5,),
               Padding(padding: EdgeInsets.symmetric(vertical: 15)),
               SignForm(),

               Padding(padding: EdgeInsets.symmetric(vertical: 15)),
               SizedBox(height: 10,),
               
               

           ]),
        

        ),
      
    ),
    ),),);
  }
}

class SignForm extends StatefulWidget {
   SignForm({ Key? key }) : super(key: key);
    
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name =TextEditingController();
  final TextEditingController _email =TextEditingController();
  final TextEditingController _password =TextEditingController();
  final TextEditingController _confirmPassword =TextEditingController();
  final TextEditingController _phone =TextEditingController();
  
  String? _person ;

   @override
  void dispose(){
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _phone.dispose();
  }
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? phone;
  final List<String> errors = [];
  @override
  
    
  Widget build(BuildContext context) {

     
     
     

    return Form(
      key: _formKey,
      child:Column(
        children: [
         buildNameFormField(),
         const SizedBox(height: 18,),
         buildEmailFormField(),
         const SizedBox(height: 18,),
         buildPassFormField(),
         const SizedBox(height: 18,),
         buildConfirmPassFormField(),
         const SizedBox(height: 18),
         buildPhonetFormField(),
         const SizedBox(height: 18,),
         FormError(errors: errors),
         const SizedBox(height: 1,),
       
        RadioListTile(
          activeColor: Colors.deepPurple,
          title: const Text('visitor',style: TextStyle(fontSize: 20),),
          value: "visiteur",
          groupValue: _person,
          onChanged: (String? value) {
            setState(() {
              
              _person = value;
              
            });
          },
        ),
        
        RadioListTile(
          activeColor: Colors.deepPurple,
          title: const Text('Parking Owner' , style: TextStyle(fontSize: 20),),
          value: "proprietaire",
          groupValue: _person,
          onChanged: (String? value) {
            setState(() {
              
              _person = value;
              
            });
          },
        ),
        

      TextButton(
        onPressed: () async {
          if(_formKey.currentState!.validate()){
            var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password: _password.text) ;
            if (result!=null){
               await FirebaseFirestore.instance.collection("utilisateur").doc(result.user!.uid).set({
                'name':_name.text,
                'email':_email.text,
                'phone':_phone.text,
                'role':_person,
              });
              Navigator.push(context,MaterialPageRoute(builder:(context)=>Login()));
            }
          }
        } ,
        child: const Text('Save',) ,
        
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.teal,
          elevation: 10,
          textStyle: const TextStyle(fontSize: 25),
          
          
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
        ),
      ),
        
    ]) ,
      
    );}

  TextFormField buildNameFormField(){
    return TextFormField(
      controller: _name,
            
            onChanged: (newValue)=> name=newValue,
            

            
            validator:(value){
              if(value!.isEmpty){
                return 'please Fill name input';
              }
            },
            
              
            decoration: InputDecoration(
              labelText: "Name",
              hintText: "Enter your name",
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
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFF757575)),
                gapPadding: 10,
              ),
            ),
          );}

  TextFormField buildEmailFormField(){
    return TextFormField(
      controller: _email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (newValue)=> email=newValue,
            
            
            validator:(value){
              if(value!.isEmpty){
                return 'please Fill email input';
              }
            },
            
              
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
            return TextFormField(
              controller: _password,
            
              obscureText: true,
              onChanged: (newValue) => password = newValue,
              
               validator:(value){
              if(value!.isEmpty){
                return 'please Fill password input';
              }
            },
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
    );}

    TextFormField buildConfirmPassFormField(){
            return TextFormField(
              controller: _confirmPassword,
            
              obscureText: true,
              onChanged: (newValue) => confirmPassword = newValue,
              
               validator:(value){
              if(value!.isEmpty){
                return 'please Fill confirm password input';
              }
            },
             decoration: InputDecoration(
              labelText: "Confirm Password",
              hintText: "Re-enter your password",
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

    TextFormField buildPhonetFormField(){
            return TextFormField(
              controller: _phone,
            
              
              onChanged: (newValue) => phone = newValue,
              
               validator:(value){
              if(value!.isEmpty){
                return 'please Fill phone input';
              }
            },
               
             decoration: InputDecoration(
              labelText: "Phone Number",
              hintText: "Enter your phone number",
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
        }
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