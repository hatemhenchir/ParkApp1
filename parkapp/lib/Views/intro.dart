


import 'package:flutter/material.dart';

import 'package:flutter_application_2/Views/login.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}):super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
  
    body: Container(
       
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children:<Widget> [
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  
                  Text(
                    "ANPR PARK",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.purple[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 25,),
                  const Text(
                    "Welcome to ANPR Park , Let's Park!" , 
                    style: TextStyle (
                    fontSize: 25 , 
                    color: Colors.black87
                    ),
                  ),

                  const Spacer(),

                  
                  Image.asset("lib/img/park3.png",
            
                  ),

                  const Spacer(),

                 

              
                  
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.purple[800],
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    
                    
                    onPressed: (
                      
                    ) {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=> Login()));
                    }, 
                    child: const Text(
                      "  Let's Go!  " ,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      ) ,

                    
                    ),
                  Spacer(),
                  
                ]
              ),
            )

          ]
        ),
      ),
         

        
    ),
      
      
  );
  }
}








class View extends StatefulWidget {
  const View({ Key? key }) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

