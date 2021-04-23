import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;

import 'dart:math' as Math;

class KycScreendocument extends StatefulWidget {
  @override
  _KycScreendocumentState createState() => _KycScreendocumentState();
}

class _KycScreendocumentState extends State<KycScreendocument> {
  File _image;
  TextEditingController cTitle = new TextEditingController();

  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, height: 300);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = compressImg;
    });
  }

  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 300);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 100));

    setState(() {
      _image = compressImg;
    });
  }

  Future upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://10.0.2.2/my_store/upload.php");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));
    request.fields['title'] = cTitle.text;
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Documents"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 17.0, right: 15.0),
                  child: Center(
                    child: _image == null
                        ? new Text("No Card Selected or Captured!")
                        : new Image.file(_image),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 17.0, right: 15.0),
                  child: TextField(
                    controller: cTitle,
                    decoration: new InputDecoration(
                      hintText: " Enter The Valid Card ID",
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 10.0),
                          child: Container(
                            child: new RaisedButton.icon(
                              onPressed: getImageGallery,
                              icon: Icon(
                                FontAwesomeIcons.camera,
                                color: Colors.white,
                              ),
                              color: Colors.deepOrange[900],
                              label: Text(""),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 15.0),
                          child: Container(
                            child: new RaisedButton.icon(
                              onPressed: getImageCamera,
                              icon: Icon(
                                FontAwesomeIcons.photoVideo,
                                color: Colors.white,
                              ),
                              color: Colors.deepOrange[900],
                              label: Text(""),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                 Container(
                  alignment: Alignment.center,
                  child: RaisedButton.icon(
                    icon: Icon(Icons.save, color: Colors.white,),
                   color: Colors.deepOrange,
                    label: Text('Upload'  ),
                    onPressed: (){
                          upload(_image);
                        },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
