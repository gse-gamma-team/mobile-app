import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PhotoReport extends StatefulWidget {
  const PhotoReport({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<PhotoReport> createState() => _PhotoReportState();
}

class _PhotoReportState extends State<PhotoReport> {

  File? image;

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Photo Report"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Problem description',
                    ),
                  ),
                ),
                MaterialButton(
                    color: Colors.blue,
                    child: const Text(
                        "Uplaod Image from Camera",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold
                        )
                    ),
                    onPressed: () {
                      pickImageC();
                    }
                ),
                SizedBox(height: 10.0,),
                Container(
                  height: 350.0,
                  child: image != null ? Image.file(image!): Text("No image selected"),
                ),
                SizedBox(height: 10.0,),
                MaterialButton(
                    color: Colors.green[600],
                    child: const Text(
                        "Send",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold
                        )
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                ),
              ],
            ),
          ),
        )
    );
  }
}