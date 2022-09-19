import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageget/multi_images.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiImages(),
    );
  }
}


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? image;


  Future pickImage(ImageSource source) async{

    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() {
        this.image = imageTemporary;
      });
    }on PlatformException catch(e) {
      print('failed to pick image $e');
    }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade300,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Spacer(),
              image != null ? ClipOval(
                child: Image.file(
                  image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ): FlutterLogo(size: 160),
              SizedBox(height: 48,),
              FlatButton(
                color: Colors.white60,

                  onPressed:(){
                    pickImage(ImageSource.gallery);

                  },
                  child: Text('Pick Image',),),





            ],
          ),
        ),


      ),
    );
  }
}

