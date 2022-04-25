import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/Views/login.dart';

 class ChoseAccount  extends StatelessWidget {
  const ChoseAccount({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       
       elevation: 0,
       iconTheme: const IconThemeData(color: Colors.black),
       centerTitle: true,

       title: const Text(
         "Choose Account",
         
         style: TextStyle(
           color: Color(0XFFB0BEC5),
           fontSize: 25 ,
           
           
          ),
        ),
      ),
      body: Container(
       child: SizedBox(
         width: double.infinity,
         height: double.infinity,
         
         
          child: Column(
            children: [
               
               Image.asset("lib/img/user_img.png",
               width: 130,),
            
                
               Spacer(),
               TextButton(
                 style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.purple[800],
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                 onPressed:(){
                   Navigator.push(context, MaterialPageRoute(builder:(context)=> Login()));
                 }, 
                 child:
                   const Text("       Visitor         ",style: TextStyle(
                        fontSize: 25,
                      ),),
                  ),
               Spacer(flex: 1,),
               TextButton(
                 style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.purple[800],
                      elevation: 10,
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                    ),
                 onPressed:(){}, 
               
                 child:
                 const Text("  Parking Owner  ",style: TextStyle(
                        fontSize: 25,
                      ),),
               ),
               Spacer(flex: 4,)
         ],    
       ))
       
         
          
       ),
      
    );

    
  }   
}