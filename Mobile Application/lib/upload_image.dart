import 'package:drawx/soundx/sound.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import './style/theme.dart' as Theme;
class PhotoPreviewScreen extends StatefulWidget {
  @override
  _PhotoPreviewScreenState createState() => _PhotoPreviewScreenState();
}
 


class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  var img = ImagePicker();
  PickedFile imageFile = null;
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _setImageView(),
            (imageFile == null) ? Container(
              
              child: Text("Upload image"))
            :
            SizedBox(child: RaisedButton( 
              
              color: Colors.lightBlue[300],
              child: Text("Upload"),
              onPressed: () async {
                      //print("Capture Done");
                      
                      //http://25ab84feb44c.ngrok.io/preds
                      print(imageFile);
                      var stream = new http.ByteStream(DelegatingStream.typed(File(imageFile.path).openRead()));
                      var length = await File(imageFile.path).length();
                      print(length);
                      var uri = Uri.parse("http://e17b47a42f0f.ngrok.io/preds");

                      print("connection established.");
                      // var request = http.MultipartRequest('POST', uri);
                      //     request.files.add(
                      //       await http.MultipartFile.fromPath(
                      //         'picture',
                      //         "/Internal storage/Pictures/Screenshots/1598347408.png"
                      //       )
                      //     );
                      var request = new http.MultipartRequest("POST", uri);
                      var multipartFile = new http.MultipartFile( 'image', stream, length,
                      filename: "image", 
                      );
                      //contentType: MediaType(‘image’, ‘png’));
                      request.files.add(multipartFile);

                      // var response = await request.send();
                      // print(response.statusCode);
                      // final x = await response.stream.bytesToString();
                      //       print("Response :  $x");
                      
                        
                        
                        //Next test
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Sound({'Control': '0.5666'}.toString())));
                      }),
            width: double.infinity,)
            
                      
                    

                  
              
        
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.lightBlue[400] ,
        onPressed: () {
          _showSelectionDialog(context);
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }

Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    
    var picture = await img.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await img.getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(File(imageFile.path), width: 500, height: 500);
    } else {
      return Text("Please select an image");
    }
  }

}