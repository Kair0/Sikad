import 'dart:async';

import 'package:Sikad/models/profilepic_ref.dart';
import 'package:Sikad/models/cause_ref.dart';
import 'package:Sikad/models/Userinfo.dart';
import 'package:Sikad/services/firestore_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  String userName;
  // Sets the profile download url
  Future<void> setProfilePicture({
    @required String uid,
    @required ProfilePicReference profileReference,
  }) async {
    final path = FirestorePath.profiles(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(profileReference.toMap());
  }

  Future<void> setCause(
      {@required String causeID,
      CauseReference
          ref /*
    @required String uid,
    @required String title,
    @required String category,
    @required var timestamp,
    @required String causeID,
    @required String description,
    @required var target,
    @required dynamic bookmarks,
    @required dynamic donations,
    @required dynamic clicks,
    @required dynamic rating,
    @required dynamic popularity,
    @required CauseReference causeReference,*/
      }) async {
    final path = FirestorePath.cause(causeID);
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(ref.toMap());
  }

  Future<void> setPerson(
      {@required String uid, ProfReference ref, Bookmrk ref2}) async {
    final path = FirestorePath.userInfo(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(ref.toMap());
    final path2 = FirestorePath.bkmrk(uid);
    final reference2 = FirebaseFirestore.instance.doc(path2);
    await reference2.set(ref2.toMap());
  }

  // Reads the current avatar download url
  Stream<ProfilePicReference> profileReferenceStream({
    @required String uid,
  }) {
    final path = FirestorePath.profiles(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => ProfilePicReference.fromMap(snapshot.data()));
  }

  //Returns the name for non gmail accounts
  Future<void> getName({
    @required String uid,
  }) async {
    final path = FirestorePath.names(uid);
    print('This is the uid path $path');
    DocumentSnapshot db =
        await FirebaseFirestore.instance.collection('names').doc(uid).get();
    userName = db.data()['name'];
    print('FS NAME: $userName');
  }

  Future<void> bookMark({@required String uid, @required Bookmrk ref2}) async {
    final path2 = FirestorePath.bkmrk(uid);
    final reference2 = FirebaseFirestore.instance.doc(path2);
    await reference2.set(ref2.toMap());
  }

  Future<bool> Bookmarker(
      {@required String uid, @required context, @required causeID}) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(uid)
        .collection('bkmrk')
        .doc(causeID)
        .get();
    if (snapShot == null || !snapShot.exists) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> RemoveBookmrk(
      {@required String uid, @required context, @required causeID}) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(uid)
        .collection('bkmrk')
        .doc(causeID)
        .get();
    if (snapShot != null || snapShot.exists) {
      await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(uid)
          .collection('bkmrk')
          .doc(causeID)
          .delete();
    }
  }
}
