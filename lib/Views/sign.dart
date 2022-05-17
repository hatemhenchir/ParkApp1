import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/constants.dart';
import 'package:flutter_application_2/Views/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

 

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
  String errorMessage = '';
  
  String? _person="visiteur" ;

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
            try{
            var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password: _password.text) ;
            if (result!=null){
               await FirebaseFirestore.instance.collection("utilisateur").doc(result.user!.uid).set({
                'name':_name.text,
                'email':_email.text,
                'phone':_phone.text,
                'role':_person,
              });
              Navigator.push(context,MaterialPageRoute(builder:(context)=>Login()));
            }errorMessage = '';}on FirebaseAuthException catch (error) {
                              errorMessage = error.message!;
                              Fluttertoast.showToast(msg: errorMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 10.0);
                            }setState(() {});
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
                return 'name is  required';
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
    String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';
     String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}
    
    return TextFormField(
      controller: _email,
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
              controller: _password,
            
              obscureText: true,
              onChanged: (newValue) => password = newValue,
              
               validator:validatePassword
            ,
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
              
               validator: (val){
                              if(val!.isEmpty)
                                   return 'Confirm Password is required';
                              if(val != _password.text)
                                   return 'Those passwords didn’t match';
                              return null;
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
      String? validatePhone(String? formPhone) {
  if (formPhone == null || formPhone.isEmpty) return 'phone   is required.';
  String pattern =
      r'^.{8,8}$';
      RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPhone))
    return '''phone must  8 number''';

  return null;
}
            return TextFormField(
              keyboardType: TextInputType.phone,
              controller: _phone,
            
              
              onChanged: (newValue) => phone = newValue,
              
               validator:validatePhone,
               
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
