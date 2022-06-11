import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/visitor/New_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({ Key? key }) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
       body: Column(
         children: [
           Container(
            padding: EdgeInsets.only(top: 70),

            child: Text("Welcome to", style: GoogleFonts.nunito(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),),
           ),
           Container(
            child: Text(" Go Park", style: GoogleFonts.nunito(
                                        letterSpacing: 2,
                                        color: Colors.green.shade300,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w800),),
           ),

           Container(
             height: 420,
            
             child: Center(
               child:Lottie.asset(
                // 'https://assets1.lottiefiles.com/private_files/lf30_fz6lkjf0.json'
                //'https://assets4.lottiefiles.com/private_files/lf30_b0tjgrdc.json'
                // 'https://assets3.lottiefiles.com/packages/lf20_5nlrPq.json'  , 
                // 'https://assets5.lottiefiles.com/private_files/lf30_hsabbeks.json'
                'lib/img/ocr.json'
                 )
             ),
           ),
           SizedBox(height: 5,),
           Container(
             child: TextButton(
                child: const Text(
                    'Continue',
                  ),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.green.shade300,
                      elevation: 10,
                      textStyle: GoogleFonts.nunito (
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
               
               onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> LoginScreen()));
               },),
           )
         ],
       ),
      
    );
  }
}