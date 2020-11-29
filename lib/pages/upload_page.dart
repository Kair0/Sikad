import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:Sikad/colours.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:Sikad/services/image_picker.dart';
import 'package:Sikad/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Sikad/colours.dart';
import 'package:Sikad/pages/nav_bar_page.dart';
import 'package:Sikad/itemsIndex.dart';
import 'package:Sikad/models/cause_ref.dart';
import 'package:Sikad/services/authentication.dart';
import 'package:Sikad/services/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

/*class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
  ChangeNotifierProvider<ItemsIndex>(
        create: (context) => ItemsIndex(),
        child: ProfilePage(),
      ),
}*/
/*
class Goback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Profile Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider<ItemsIndex>(
          create: (context) => ItemsIndex(),
          child: back(),
        ));
  }
}

class back extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
*/

Future<void> _createCause(context, @required imgFile, @required titlex,
    @required categoryx, @required descriptionx, @required targex) async {
  try {
    print("yay");
    print("");
    if (imgFile != null) {
      print('image selected');
      final user = Provider.of<AppUser>(context, listen: false);
      print('user identified');
      final storage =
          Provider.of<FirebaseStorageService>(context, listen: false);
      print('connecting to storage');
      var uuid = Uuid();
      final causeid = uuid.v4();
      final imageID = uuid.v4();
      final imageUrl = await storage.uploadCause(
          causeID: user.uid, postID: imageID, file: imgFile);
      print(user.uid);
      final db = Provider.of<FirestoreService>(context, listen: false);
      print('connected to database');

      var dbTimeKey = new Timestamp.now();
      //String tk = DateFormat('yyyy-MM-dd\nHH:mm').format(dbTimeKey);
      var uidd = user.uid;
      print('doneID');
      /* Map<String, dynamic> inpu = {
        'uid': uidd,
        'title': titlex,
        'category': categoryx,
        'timestamp': dbTimeKey,
        'causeID': causeid,
        'description': descriptionx,
        'target': targex,
        'bookmarks': 0,
        'donations': 0,
        'total': 0,
        'popularity': 50,
        'rating': 0,
        'downloadURL': imgFile
      };*/
      print('DoneMap');
      await db.setCause(
          causeID: causeid,
          ref: CauseReference(uidd, titlex, categoryx, dbTimeKey, causeid,
              descriptionx, double.parse(targex), 0, 0, 0, 50, 0, imageUrl));
      await imgFile.delete();
    }
  } catch (e) {
    print(e);
  }
}

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File sampleImage;
  String _title;
  String _categ;
  String _desc;
  String _goal;
  String url;
  final TextEditingController _titl = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _targetx = TextEditingController();
  final TextStyle _fieldTexts = TextStyle(
      color: Color(OGBlue),
      fontSize: 11,
      fontWeight: FontWeight.w400,
      fontFamily: 'PublicSans',
      package: 'Sikad');
  final formKey = new GlobalKey<FormState>();
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  bool SavedValidation() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> recordForm(context) async {
    try {
      print("lol1");
      await _createCause(
          context,
          sampleImage,
          _titl.text.toString().toLowerCase().trim(),
          _category.text.toString().toLowerCase().trim(),
          _description.text.toString().toLowerCase().trim(),
          _targetx.text.toString().toLowerCase().trim());
    } catch (e) {
      setState(() {
        var _errorMsg =
            Provider.of<FireBaseAuthService>(context, listen: false).errorMsg();
        print(_errorMsg);
      });

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final _selectedItemIndex = Provider.of<ItemsIndex>(context, listen: true);
    return new Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => NavBar()));
                /*_selectedItemIndex.zero();
                _selectedItemIndex.equate(0);*/
              }),
          title: Align(
            alignment: Alignment.center,
            child: Text('Start a cause!',
                style: TextStyle(
                  color: Color(OGBlue),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                )),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.check_circle_outline, color: Colors.white),
                onPressed: () => null)
          ]),
      body: new Center(
        child: sampleImage == null
            ? RaisedButton(
                onPressed: () => getImage(),
                child: Container(
                  width: 200,
                  child: Row(children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.add_photo_alternate_outlined),
                        color: Color(OGBlue),
                        onPressed: () => null),
                    Text('Upload an Image',
                        style: TextStyle(
                          color: Color(OGBlue),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ))
                  ]),
                ))
            : Align(
                alignment: Alignment.center,
                child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    //fit: FlexFit.tight,
                    child: new Form(
                        key: formKey,
                        child: ListView(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, bottom: 30),
                            width: MediaQuery.of(context).size.width / 1.7,
                            height: MediaQuery.of(context).size.width / 1.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                sampleImage,
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              ),
                            ),
                          ),
                          /*Image.file(
                    sampleImage,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 1.5,
                    width: MediaQuery.of(context).size.width - 40,
                  ),*/
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                              controller: _titl,
                              style: _fieldTexts,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(OGGray),
                                hintText: 'Have a catchy title for your cause',
                                labelText: 'Title *',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (value) {
                                return value.isEmpty
                                    ? 'Please give your cause a name'
                                    : null;
                              },
                              onSaved: (value) {
                                return _title = value;
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                              controller: _category,
                              style: _fieldTexts,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(OGGray),
                                hintText:
                                    'What category does your cause belong to',
                                labelText: 'Category *',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (value) {
                                return value.isEmpty
                                    ? 'Please put a category.'
                                    : null;
                              },
                              onSaved: (value) {
                                return _categ = value;
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                              controller: _description,
                              style: _fieldTexts,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(OGGray),
                                hintText: 'Describe your cause.',
                                labelText: 'Description *',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (value) {
                                return value.isEmpty
                                    ? 'Please put a description.'
                                    : null;
                              },
                              onSaved: (value) {
                                return _desc = value;
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                              controller: _targetx,
                              style: _fieldTexts,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(OGGray),
                                hintText: 'What is your target?',
                                labelText: 'Target *',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (value) {
                                return value.isEmpty
                                    ? 'Please input your target.'
                                    : null;
                              },
                              onSaved: (value) {
                                return _goal = value;
                              }),
                          RaisedButton(
                            elevation: 10.0,
                            child: Text("Post your Cause!"),
                            textColor: Colors.white,
                            color: Color(OGRed),
                            onPressed: () => recordForm(context),
                          )
                        ])))),
      ),
      floatingActionButton: sampleImage != null
          ? new FloatingActionButton(
              backgroundColor: Color(OGBlue),
              tooltip: "Upload an Image",
              child: new Icon(Icons.refresh),
              onPressed: () => null)
          : Container(),
    );
  }

  /*

  void uploadPostImage() async {
    if (SavedValidation()) {
    final StorageReference imageReference = FirebaseStorage.instance.ref().child("Images")
    var timeKey = new DateTime.now();
    final StorageUploadTask uploadTask = imageReference.child(timeKey.toString()+".jpg").putFile(sampleImage);
    
    var imgurl = await(await uploadTask.onComplete).ref.getDownloadURL();
    url = imgurl.toString();
    print("IMGURL: " + url);
    savePost(url);
    
    }
  }


  void savePost (url){
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');
    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {"image":url,
    "description": _myValue,
    "date": date,
    "time": time,
    };

    ref.child("Posts").push().set(data);
  }*/ /*
  Widget enableUpload(context) {
    final TextEditingController _titl = TextEditingController();
    final TextEditingController _category = TextEditingController();
    final TextEditingController _description = TextEditingController();
    final TextEditingController _targetx = TextEditingController();
    final TextStyle _fieldTexts = TextStyle(
      color: Color(OGBlue),
      fontSize: 11,
      fontWeight: FontWeight.w400,
      //fontFamily: 'PublicSans',
      //package: 'Sikad'
    );
    return Align(
        alignment: Alignment.center,
        child: Container(
            width: MediaQuery.of(context).size.width - 60,
            //fit: FlexFit.tight,
            child: new Form(
                key: formKey,
                child: ListView(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
                    width: MediaQuery.of(context).size.width / 1.7,
                    height: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        sampleImage,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  /*Image.file(
                    sampleImage,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 1.5,
                    width: MediaQuery.of(context).size.width - 40,
                  ),*/
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                      controller: _titl,
                      style: _fieldTexts,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(OGGray),
                        hintText: 'Have a catchy Title for your cause',
                        labelText: 'Title *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty
                            ? 'Please give your cause a Title'
                            : null;
                      },
                      onSaved: (value) {
                        return _title = value;
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                      controller: _category,
                      style: _fieldTexts,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(OGGray),
                        hintText: 'What Category does your cause belong to',
                        labelText: 'Category *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty ? 'Please put a Category.' : null;
                      },
                      onSaved: (value) {
                        return _categ = value;
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                      controller: _description,
                      style: _fieldTexts,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(OGGray),
                        hintText: 'Place your Description here.',
                        labelText: 'Description *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty ? 'Please put Description.' : null;
                      },
                      onSaved: (value) {
                        return _desc = value;
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                      controller: _targetx,
                      style: _fieldTexts,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(OGGray),
                        hintText: 'Place your target here.',
                        labelText: 'Target *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty
                            ? 'Please input your target.'
                            : null;
                      },
                      onSaved: (value) {
                        return _goal = value;
                      }),
                  RaisedButton(
                    elevation: 10.0,
                    child: Text("Add a New Post"),
                    textColor: Colors.white,
                    color: Color(OGRed),
                    onPressed: () => _createCause(
                        context, sampleImage, _title, _categ, _desc, _goal),
                  )
                ]))));
  }*/
}
