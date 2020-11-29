import 'package:Sikad/colours.dart';
import 'package:flutter/material.dart';
import 'package:Sikad/itemsIndex.dart';
import 'package:provider/provider.dart';

import 'package:Sikad/services/authentication.dart';
import 'package:Sikad/services/firestore_service.dart';
import 'package:Sikad/models/Userinfo.dart';
import 'package:Sikad/pages/nav_bar_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart';

class CausePage extends StatelessWidget {
  // This widget is the root of your application.
  CausePage(this.causeID);
  String causeID;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Cause(causeid: causeID),
    );
  }
}

Future<void> exist({@required String uid, @required context}) async {
  final db = Provider.of<FirestoreService>(context, listen: false);
  final snapShot =
      await FirebaseFirestore.instance.collection('userInfo').doc(uid).get();
  if (snapShot == null || !snapShot.exists) {
    db.setPerson(
        uid: uid, ref: ProfReference(uid, 0, 0, 0), ref2: Bookmrk("default"));
  }
}

Future<void> addBookmrk(
    {@required String uid, @required context, @required causeID}) async {
  final db = Provider.of<FirestoreService>(context, listen: false);
  final snapShot = await FirebaseFirestore.instance
      .collection('userInfo')
      .doc(uid)
      .collection('bkmrk')
      .doc(causeID)
      .get();
  if (snapShot == null || !snapShot.exists) {
    db.bookMark(uid: uid, ref2: Bookmrk("default"));
  }
}

class Cause extends StatelessWidget {
  Cause({Key key, this.title, this.causeid}) : super(key: key);
  final String causeid;
  final String title;

/*
  var _title = documen['title'];
  var category = documen['category'];
  var urlPost = documen['downloadURL'];
  var currentMoney = documen['total'];
  var goal = documen['target'];*/
  @override
  Widget build(BuildContext context) {
    final _selectedItemIndex = Provider.of<ItemsIndex>(context, listen: true);
    final user = Provider.of<AppUser>(context, listen: false);
    final db = Provider.of<FirestoreService>(context, listen: false);
    bool yeah = false;
    _bookens() async {
      bool booker = await db.Bookmarker(
          uid: user.uid, context: context, causeID: causeid);
      yeah = booker;
    }

    _bookens();
    //var booker = db.Bookmarker(uid: user.uid, context: context, causeID: causeid).yeet;

    //print('$booker');
    return SafeArea(
        child: MaterialApp(
            home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                alignment: Alignment.center,
                height: 174,
                width: 243,
                child: Image.asset(
                  'images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                  top: 16,
                  left: 16,
                  child: (IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Color(OGGray)),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => NavBar()));
                        _selectedItemIndex.zero();
                        _selectedItemIndex.equate(0);
                      }))),
              Positioned(
                  bottom: 8,
                  child: Card(
                      color: Color(OGBlue2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Cause Title",
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
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "lorem ipsum",
                                style: TextStyle(
                                  fontSize: 18,
                                  //fontWeight: FontWeight.bold,
                                  color: Color(OGBlue),
                                  fontFamily: 'PublicSans',
                                  package: 'Sikad',
                                ),
                              ),
                            ),
                          ),
                          Container(
                              child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: IconButton(
                                    icon: Icon(Icons.star_rate_outlined,
                                        color: Color(OGPeach)),
                                    onPressed: () => null),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: IconButton(
                                    icon: Icon(Icons.star_rate_outlined,
                                        color: Color(OGPeach)),
                                    onPressed: () => null),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: IconButton(
                                    icon: Icon(Icons.star_rate_outlined,
                                        color: Color(OGPeach)),
                                    onPressed: () => null),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: IconButton(
                                    icon: Icon(Icons.star_rate_outlined,
                                        color: Color(OGPeach)),
                                    onPressed: () => null),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: IconButton(
                                    icon: Icon(Icons.star_rate_outlined,
                                        color: Color(OGPeach)),
                                    onPressed: () => null),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
                                child: IconButton(
                                    icon: Icon(Icons.bookmark_outline_rounded,
                                        color: Color(OGRed)),
                                    onPressed: () => null),
                              ),
                            ],
                          )),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Updates",
                                style: TextStyle(
                                  fontSize: 22,
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
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.all(20),
                              children: [
                                Container(
                                  child: Image.asset(
                                    'images/logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: 30, left: 15, right: 15),
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  height:
                                      MediaQuery.of(context).size.width / 1.7,
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
                                Container(
                                  child: Image.asset(
                                    'images/logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: 30, left: 15, right: 15),
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  height:
                                      MediaQuery.of(context).size.width / 1.7,
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
                                Container(
                                  child: Image.asset(
                                    'images/logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: 30, left: 15, right: 15),
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  height:
                                      MediaQuery.of(context).size.width / 1.7,
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
                      ))),
              Positioned(
                  bottom: -240,
                  right: 24,
                  child: SizedBox(
                      width: 150,
                      child: RaisedButton(
                        child: Text("donate"),
                        onPressed: () {
                          //open donation pop up
                        },
                      ))),
            ],
          ),
        ],
      ),
      floatingActionButton: yeah
          ? new FloatingActionButton(
              backgroundColor: Color(OGBlue),
              tooltip: "Upload an Image",
              child: new Icon(Icons.bookmark_border),
              onPressed: () =>
                  addBookmrk(uid: user.uid, context: context, causeID: causeid))
          : new FloatingActionButton(
              backgroundColor: Color(OGBlue),
              tooltip: "Upload an Image",
              child: new Icon(Icons.bookmark),
              onPressed: () {
                final db =
                    Provider.of<FirestoreService>(context, listen: false);
                db.RemoveBookmrk(
                    uid: user.uid, context: context, causeID: causeid);
              }),
    )));
  }
}
