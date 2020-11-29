import 'package:firebase_auth/firebase_auth.dart';
import 'package:Sikad/services/firestore_path.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class NameGrab {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String newName;

  void setNewName(String name) {
    newName = name;
    setProfileName(auth.currentUser.uid, newName);
  }

  Future<void> setProfileName(
    String uid,
    String name,
  ) async {
    final path = FirestorePath.names(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set({"name": name});
  }
}
