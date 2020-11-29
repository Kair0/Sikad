import 'package:Sikad/colours.dart';
import 'package:Sikad/models/profilepic_ref.dart';
import 'package:Sikad/services/authentication.dart';
import 'package:Sikad/services/firestore_path.dart';
import 'package:Sikad/services/firestore_service.dart';
import 'package:Sikad/services/image_picker.dart';
import 'package:Sikad/services/storage_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Sikad/itemsIndex.dart';
import 'package:Sikad/pages/nav_bar_page.dart';
import 'package:Sikad/widgets/my_donation_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<ItemsIndex>(
        create: (context) => ItemsIndex(),
        child: ProfilePage(),
      ),
    );
  }
}

Future<void> _signOut(BuildContext context) async {
  try {
    final auth = Provider.of<FireBaseAuthService>(context, listen: false);
    await auth.signOut();
  } catch (e) {
    print(e);
  }
}

Future<void> _createProfilePicture({BuildContext context}) async {
  try {
    print('creating a new profile');
    final imgPicker = Provider.of<ImagePickerService>(context, listen: false);
    final imgFile = await imgPicker.getImage(source: ImageSource.gallery);
    if (imgFile != null) {
      print('image selected');
      final user = Provider.of<AppUser>(context, listen: false);
      print('user identified');
      final storage =
          Provider.of<FirebaseStorageService>(context, listen: false);
      print('connecting to storage');
      final imageUrl =
          await storage.uploadProfilePicture(uid: user.uid, file: imgFile);
      print(user.uid);
      final db = Provider.of<FirestoreService>(context, listen: false);
      print('connected to database');
      await db.setProfilePicture(
          uid: user.uid, profileReference: ProfilePicReference(imageUrl));
      await imgFile.delete();
    }
  } catch (e) {
    print(e);
  }
}

Widget _profilePicture({BuildContext context}) {
  final database = Provider.of<FirestoreService>(context, listen: false);
  final user = Provider.of<AppUser>(context, listen: false);

  return StreamBuilder(
    stream: database.profileReferenceStream(uid: user.uid),
    builder: (context, snapshot) {
      final profileReference = snapshot.data;
      String imgUrl;
      try {
        imgUrl = profileReference?.downloadUrl;
      } catch (e) {
        imgUrl = null;
        print(e.message);
      }
      print(imgUrl);
      return GestureDetector(
        onTap: () => _createProfilePicture(context: context),
        child: CircleAvatar(
          radius: 44,
          backgroundColor: Colors.black54,
          child: CachedNetworkImage(
            imageUrl: '$imgUrl',
            imageBuilder: (context, imageProvider) => Container(
              width: 88.0,
              height: 88.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
          ),
        ),

        // backgroundImage: NetworkImage(imgUrl),
      );
    },
  );
}

Widget _userInfo({BuildContext context}) {
  final _auth = Provider.of<FireBaseAuthService>(context, listen: false);
  final _nameEmail = Provider.of<FirestoreService>(context, listen: false);
  final _user = _auth.auth.currentUser;
  final _email = _user.email;
  String userName;
  String name = _nameEmail.userName;

  if (_auth.auth.currentUser.displayName != null) {
    userName = _auth.auth.currentUser.displayName;
  } else {
    userName = name;
  }

  print('Name: $userName');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(0, 0, 57, 0),
        child: Text(
          '$userName',
          style: TextStyle(
            color: Color(0xffF2F2F2),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          softWrap: true,
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 57, 0),
        child: Text(
          _email,
          style: TextStyle(
            color: Color(0xffF2F2F2),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          softWrap: true,
        ),
      ),
    ],
  );
}

// appBar: AppBar(
//   backgroundColor: Color(OGBlue),
//   actions: <Widget>[
//     IconButton(
//         alignment: Alignment.centerRight,
//         icon: Icon(Icons.arrow_back_ios),
//         onPressed: () {
//           Navigator.of(context).pushReplacement(
//               MaterialPageRoute(builder: (context) => NavBar()));
//           _selectedItemIndex.zero();
//           _selectedItemIndex.equate(0);
//         }),
//     IconButton(
//         icon: Icon(Icons.exit_to_app_rounded),
//         onPressed: () => _signOut(context))
//   ],
// ),
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedItemIndex = Provider.of<ItemsIndex>(context, listen: true);
    return SafeArea(
        child: MaterialApp(
            home: Scaffold(
      backgroundColor: Color(OGBlue),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //user info
          Row(children: [
            IconButton(
                //alignment: Alignment.centerRight,
                icon: Icon(Icons.arrow_back_ios, color: Color(OGGray)),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => NavBar()));
                  _selectedItemIndex.zero();
                  _selectedItemIndex.equate(0);
                }),
            IconButton(
                icon: Icon(Icons.exit_to_app_rounded, color: Color(OGGray)),
                onPressed: () => _signOut(context))
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: _profilePicture(context: context),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: _userInfo(context: context),
              ),
              //user details
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 24, top: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Rank:',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(OGGray),
                            fontFamily: 'PublicSans',
                            package: 'Sikad',
                          )))),
              Container(
                  padding: EdgeInsets.only(left: 24, top: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Total amount donated:',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(OGGray),
                            fontFamily: 'PublicSans',
                            package: 'Sikad',
                          )))),
              Container(
                  padding: EdgeInsets.only(left: 24, top: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Number of causes donated to:',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(OGGray),
                            fontFamily: 'PublicSans',
                            package: 'Sikad',
                          )))),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 24, bottom: 8, top: 15),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "My Donation Drives",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(OGGray),
                  fontFamily: 'PublicSans',
                  package: 'Sikad',
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            //height: MediaQuery.of(context).size.width / 1.5,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('causes').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return const Text('Loading');
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final user = Provider.of<AppUser>(context, listen: false);
                      var uid = user.uid;
                      if (snapshot.data.docs[index].data()['uid'] == uid)
                        return eachCard(context, snapshot.data.docs[index]);
                      return Container();
                    },
                  );
                }),
          ),
          Container(
            padding: EdgeInsets.only(left: 24, bottom: 8, top: 15),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Causes I follow",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(OGGray),
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
              padding: EdgeInsets.all(16),
              children: [
                Container(
                  child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.contain,
                  ),
                  margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
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
                  margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
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
                  margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
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
    )));
  }
}
