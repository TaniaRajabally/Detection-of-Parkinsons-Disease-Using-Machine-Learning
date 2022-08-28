import 'package:drawx/recognizer_screen.dart';
import 'package:flutter/material.dart';
import './upload_image.dart';
import './style/theme.dart' as Theme;

class Select extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: 
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.Colors.loginGradientStart,
              Theme.Colors.loginGradientEnd
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
      
      
      child:
      Center(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            
            SizedBox(height: 30,),
          SizedBox(height: 10,),
          SizedBox(height: 10,),
          SizedBox(height: 10,),
          Text("Test 1: Trace Test", style: TextStyle(fontFamily: "Roboto", fontSize: 32), textAlign: TextAlign.center,),

          ],),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            SizedBox(height: 10,),
          SizedBox(height: 10,),
          SizedBox(height: 10,),
          SizedBox(height: 280,),
          RaisedButton(
            color: Colors.lightBlue[300] ,
            
            child: Text("Click/ Upload an image"),
            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return PhotoPreviewScreen();
                            }));

            } ,
            ),
            RaisedButton(
               color: Colors.lightBlue[300]  ,
              child: Text("Trace the shape"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return RecognizerScreen(title: 'Parkinson\'s Trace Test',);
                            //return Select();
                            }));
              },
              )


          ],)
          

        ]
      ),

      ))
         
      
    );
  }
}