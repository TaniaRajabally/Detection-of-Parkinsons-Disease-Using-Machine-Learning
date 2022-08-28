
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import 'style/theme.dart' as Theme;


class Results extends StatelessWidget {
  Results(this.r1, this.r2);
  final String r1;
  final String r2;
  @override
  Widget build(BuildContext context){
    final TextStyle titleStyle = TextStyle(
      color: Colors.black87,
      fontSize: 16.0,
      fontWeight: FontWeight.w500
    );
    final TextStyle trailingStyle = TextStyle(
      color: Colors.lightBlue[300],
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    );
    final TextStyle resultStyle = TextStyle(
      color: Colors.lightGreen[300],
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    );

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text('Result'),
        elevation: 0,
      ),
      body: Container(
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Tests Taken", style: titleStyle),
                  trailing: Text("2", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Trace Test Score", style: titleStyle),
                  trailing: Text("22%", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Speech Test Score", style: titleStyle),
                  trailing: Text("34%", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Final Score", style: titleStyle),
                  trailing: Text("28%", style: trailingStyle),
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Class: ", style: titleStyle),
                  trailing: Text("Control Group", style: resultStyle, ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.lightBlue[600],
                    textColor: Colors.white,
                    child: Text("Give Test Again"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // RaisedButton(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   color: Colors.deepPurple.withOpacity(0.8),
                  //   textColor: Colors.white,
                  //   child: Text("Check Answers"),
                  //   onPressed: (){
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (_) => CheckAnswersPage(questions: questions, answers: answers,)
                  //     ));
                  //   },
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}