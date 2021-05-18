import 'dart:io';
import 'package:fcheck2/Screens/MyHome.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class TakePhoto extends StatefulWidget {
  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 13, 45, .7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: _image == null
                ? Container(
              height: MediaQuery.of(context).size.height*.6,
                width: MediaQuery.of(context).size.width*.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.teal[100]
                ),
                child: Center(child: Text('No image selected.',style: TextStyle(color: Colors.red),)))
                : Container(
                height: MediaQuery.of(context).size.height*.6,
                width: MediaQuery.of(context).size.width*.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal[100]
                ),
                child: Image.file(_image),
            ),
          ),
          GestureDetector(
            onTap: (){
    if(_image!=null){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHome()));
    }
    else{
    final snackBar = SnackBar(
    content: Text("Please Take a Photo",style: TextStyle(color: Colors.red,fontSize: 12),),
    action: SnackBarAction(
    label: "ERROR!",
    textColor: Colors.red,
    onPressed: (){

    },
    ),
    // action: SnackBarAction(
    //   label: 'Undo',
    //   onPressed: () {
    //     // Some code to undo the change.
    //   },
    // ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    };
    },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
              child: Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[100],
        onPressed: getImage,
        //tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo,color: Color.fromRGBO(21, 13, 45, 1),),
      ),
    );
  }
}