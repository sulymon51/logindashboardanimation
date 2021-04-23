import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_dash_animation/screens/driver/awaitingScreen.dart';
import 'package:login_dash_animation/screens/driver/pages/carPicupload.dart';
import 'package:login_dash_animation/screens/driver/pages/verified.dart';
import 'package:login_dash_animation/screens/main_screen.dart';
import 'package:login_dash_animation/screens/walletScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:toast/toast.dart';


class AdduserPage extends StatefulWidget {

  @override
  _AdduserPageState createState() => _AdduserPageState();
}

class _AdduserPageState extends State<AdduserPage> {

  final carmodelController = TextEditingController();
  final carnumberController = TextEditingController();
  final carcolorController = TextEditingController();
  final cityController = TextEditingController();
  final lincenseController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose(){
    carnumberController.dispose();
    carcolorController.dispose();
    carmodelController.dispose();
    cityController.dispose();
    lincenseController.dispose();
    addressController.dispose();
    super.dispose();
  }
  String _myActivity;
  String _myActivityResult;

  


  final formKey = new GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
    getCredential();
    // _checkVe();
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }


 

File _imageFile;
  // To track the file uploading state
  bool _isUploading = false;
  String baseUrl = 'https://ridezmyway.com/apiall/documentup.php';
  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
    });
    Navigator.pop(context);
  }


  Future<Map<String, dynamic>> _uploadImage(File image) async {

    String carnumber = carnumberController.text;
    String carcolor = carcolorController.text;
    String carmodel = carmodelController.text;
    String city = cityController.text;
    String lincense = lincenseController.text;
    String address = addressController.text;

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
    imageUploadRequest.fields['carnumber'] = carnumber;
    imageUploadRequest.fields['carcolor'] = carcolor;
    imageUploadRequest.fields['carmodel'] = carmodel;
    imageUploadRequest.fields['city'] = city;
    imageUploadRequest.fields['lincense'] = lincense;
    imageUploadRequest.fields['address'] = address;
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
                  MaterialPageRoute(builder: (context) => CarPicture()));
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

  String name = "", phone = "", email = "", id="", profilepic="", dvype = "", dvstatus="";

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
       name = sharedPreferences.getString("name");
       phone= sharedPreferences.getString("phone");
       email= sharedPreferences.getString("email");
       profilepic= sharedPreferences.getString("profilepic");
       dvype = sharedPreferences.getString("dvype");
       dvstatus = sharedPreferences.getString("dvstatus");
       id= sharedPreferences.getString("id");

    });

        // print(dvstatus);
        print(dvstatus);

  }

  


  @override
  Widget build(BuildContext context) {


    getCredential();
    //  if(dvype == 'no'){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Documents Verification"),
      ),
      body: new SafeArea(
        key: formKey,
          top: false,
          bottom: false,
          child: new Form(
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
               
                children: <Widget>[
                   SizedBox(
                  height: 15.0,
                ),
                  Text('CAR INFORMATION'),
                  
                  TextField(
                    controller: carmodelController,
                    decoration: InputDecoration(
                        labelText: 'Model',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange))),
                  ),
                  SizedBox(height: 10.0),
                  TextField( 
                    
                    controller: carnumberController,
                    decoration: InputDecoration(
                        labelText: 'Car Number',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: carcolorController,
                    decoration: InputDecoration(
                        labelText: 'Car Color',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange))),
                  ),
                  SizedBox(height: 10.0),
                  // TextField(
                  //   decoration: InputDecoration(
                  //       labelText: 'Address',
                  //       focusedBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.deepOrange))),
                  // ),
                  // SizedBox(height: 10.0),
                  // TextField(
                  //   decoration: InputDecoration(
                  //       labelText: 'Sate of Origin',
                  //       focusedBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.deepOrange))),
                  // ),
                  // SizedBox(height: 10.0),
                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                        labelText: 'City',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: lincenseController,
                    decoration: InputDecoration(
                        labelText: 'Lincense ID',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                        labelText: 'Address',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange))),
                  ),
                  SizedBox(height: 10.0),
                  Column(
                    children: <Widget>[
                      Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.deepOrangeAccent,
                            color: Colors.deepOrange,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () => _openImagePickerModal(context),
                              child: Center(
                                child: Text(
                                  'Upload License Pic',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                            
                          )),
                          _buildUploadBtn(),
                    ],
                  ),   
                  SizedBox(height: 20.0),
                  Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivityResult),
              ),
                ],
              ))),
    );
  //  }else{
  //        if(dvstatus == 'no'){
  //        return Awaitingverify();
  //        }else{
  //         return Verrrifie();
  //   }
       
   
    // }
  }
}




