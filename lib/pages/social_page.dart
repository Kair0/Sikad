import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:Sikad/pages/profile_page.dart';
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

class SocialMedia extends StatefulWidget {
  @override
  _SocialMediaState createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
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
    return SafeArea(
        child: MaterialApp(
            home: Scaffold(
      backgroundColor: Color(OGBlue2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 74,
              width: 123,
              child: Image.asset(
                'images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Community",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(OGBlue),
                    fontFamily: 'PublicSans',
                    package: 'Sikad',
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              //height: MediaQuery.of(context).size.width / 1.5,
              child: ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(8),
                children: [
                  //temporary content
                  Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Help Cancer Patients",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(OGBlue),
                                  fontFamily: 'PublicSans',
                                  package: 'Sikad',
                                ),
                              ),
                            ),
                          ),
                          Image.asset(
                            'images/logo.png',
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
                    width: MediaQuery.of(context).size.width / 1.7,
                    height: MediaQuery.of(context).size.width / 1.1,
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
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: NetworkImage(urlPost),
                      // )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), /*
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0),
                    spreadRadius: 1,
                  )
                ],
                color: Colors.grey.withOpacity(0),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                navigationBar(context, Icons.search, 1, 0),
                navigationBar(context, Icons.people_outline, 2, 0),
                navigationBar(context, Icons.add, 3, 1),
                navigationBar(context, Icons.bike_scooter_sharp, 4, 0),
                navigationBar(context, Icons.person_outline, 5, 0),
              ],
            ),
          )),*/
    )));
  }

  Widget navigationBar(context, IconData icon, int index, int type) {
    final selectedItemIndex = Provider.of<ItemsIndex>(context, listen: true);
    return GestureDetector(
      onTap: () {
        selectedItemIndex.equate(index);
        if (selectedItemIndex.ind == 5) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfPage()));
        } else {
          null;
        }

        print(selectedItemIndex.ind);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 90,
        child: icon != null
            ? Stack(children: [
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20,
                      top: 20,
                      left: MediaQuery.of(context).size.width / 10 - 25),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: type == 0 ? Color(0xFFFFFFFF) : Color(OGRed),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20,
                      top: 20,
                      left: MediaQuery.of(context).size.width / 10 - 25),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: index == selectedItemIndex.ind
                        ? RadialGradient(
                            colors: [Color(0xFF000000), Color(0x66000000)])
                        : RadialGradient(
                            colors: [Color(0x00000000), Color(0x00000000)]),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    size: 25,
                    color: index == selectedItemIndex.ind
                        ? Colors.white
                        : Color(OGBlue),
                  ),
                ),
              ])
            : Container(),
      ),
    );
  }
}
