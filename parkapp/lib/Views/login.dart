import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/constants.dart';


class Body extends StatelessWidget {
  const Body({Key? key}):super(key: key);
  
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
          child:Column(
            
            children: [
              const SizedBox(height: 25,),
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
               ),
              const SizedBox(height: 25,),
               const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
               const SignForm(),

               const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
               const SizedBox(height: 30,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: const [
                   Text("Don't have an account? ",
                   style: TextStyle(
                     fontSize: 16
                   ) ,),
                   Text("Sign Up ",
                   style: TextStyle(
                     fontSize: 16,
                     color: Color(0XFF6A1B9A)
                   ) ,)
                 ],
               )
               

           ]),
        

        ),
      
    ),
    ),);
  }
}

class SignForm extends StatefulWidget {
  const SignForm({ Key? key }) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
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
        onPressed: (){} ,
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

  TextFormField buildEmailFormField(){
    return TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue)=> email=newValue,
            onChanged: (value){
              if (value.isNotEmpty && errors.contains(kEmailNullError)){
                setState(() {
                  errors.remove(kEmailNullError);
                });
                
              } else if (emailValidatorRegExp.hasMatch(value) && errors.contains(kInvalidEmailError)){
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },

            
            validator: (value){
              if (value!.isEmpty && !errors.contains(kEmailNullError)){
                setState(() {
                  errors.add(kEmailNullError);
                });
                
              } else if (!emailValidatorRegExp.hasMatch(value) && !errors.contains(kInvalidEmailError)){
                setState(() {
                  errors.add(kInvalidEmailError);
                });
                return "";
              }
              return "";
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
            
              obscureText: true,
              onSaved: (newValue) => password = newValue,
              onChanged: (value){
               if (value.isNotEmpty && errors.contains(kPassNullError)){
                setState(() {
                  errors.remove(kPassNullError);
                });
                
               } else if (value.length >= 8 && errors.contains(kShortPassError)){
                  setState(() {
                  errors.remove(kShortPassError);
                });
               }
                return null;
               },
               validator: (value){
               if (value!.isEmpty && !errors.contains(kPassNullError)){
                setState(() {
                  errors.add(kPassNullError);
                });
                return "";
                
               } else if (value.length < 8 && !errors.contains(kShortPassError)){
                setState(() {
                  errors.add(kShortPassError);
                });
               }
               return "";
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
