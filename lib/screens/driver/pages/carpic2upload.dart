import 'package:flutter/material.dart';
import 'package:login_dash_animation/screens/driver/pages/carpic3upload.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_dash_animation/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'dart:io';




class CarPicturea extends StatefulWidget {
  CarPicturea({Key key}) : super(key: key);

  @override
  _CarPictureaState createState() => _CarPictureaState();
}

class _CarPictureaState extends State<CarPicturea> {


  final formKey = new GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    getCredential();
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
      });
    }
  }

File _imageFile;
  // To track the file uploading state
  bool _isUploading = false;
  String baseUrl = 'https://ridezmyway.com/apiall/doc2tup.php';
  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
    });
    Navigator.pop(context);
  }


  Future<Map<String, dynamic>> _uploadImage(File image) async {

    setState(() {
      _isUploading = true;
    });
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(baseUrl));
    final file = await http.MultipartFile.fromPath('image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
        );
    imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.fields['id'] = id;
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      _resetState();
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }
  void _startUploading() async {
    final Map<String, dynamic> response = await _uploadImage(_imageFile);
    print(response);
    // Check if any error occured
    if (response == null || response.containsKey("error")) {
      Toast.show("Failed to  Upload !!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Documents Uploaded Successfully!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CarPictureb()));
    }
  }
  void _resetState() {
    setState(() {
      _isUploading = false;
      _imageFile = null;
    });
  }
  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }
  Widget _buildUploadBtn() {
    Widget btnWidget = Container();
    if (_isUploading) {
      // File is being uploaded then show a progress indicator
      btnWidget = Container(
          margin: EdgeInsets.only(top: 10.0),
          child: CircularProgressIndicator());
    } else if (!_isUploading && _imageFile != null) {
      // If image is picked by the user then show a upload btn
      btnWidget = Container(
        margin: EdgeInsets.only(top: 10.0),
        child: RaisedButton(color: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
          child: Text('Upload'),
          onPressed: () {
            _startUploading();
          },
          // color: Colors.pinkAccent,
          textColor: Colors.white,
        ),
      );
    }
    return btnWidget;
  }

    SharedPreferences sharedPreferences;

  String name = "", phone = "", email = "", id="", profilepic="";

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString("name");
       phone= sharedPreferences.getString("phone");
      email= sharedPreferences.getString("email");
       id= sharedPreferences.getString("id");
       profilepic= sharedPreferences.getString("profilepic");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back Driver License'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
            child: OutlineButton(
              onPressed: () => _openImagePickerModal(context),
              borderSide:
                  BorderSide(color: Theme.of(context).accentColor, width: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.camera_alt),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('Back Of your Diriver License'),
                ],
              ),
            ),
          ),
          _imageFile == null
              ? Text('Please pick an image')
              : Image.file(
                  _imageFile,
                  fit: BoxFit.cover,
                  height: 300.0,
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                ),
          _buildUploadBtn(),
        ],
      ),
    );

  }
}