import 'dart:io';
import 'package:Sikad/services/firestore_path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageService {
  FirebaseStorageService({
    @required this.uid,
  });
  //: assert(uid != null)
  final String uid;

  //upload profile picture
  Future<String> uploadProfilePicture({
    @required String uid,
    @required File file,
  }) async =>
      await upload(
        uid: uid,
        file: file,
        path: FirestorePath.profiles(uid) + '/profile.png',
        contentType: 'image/png',
      );

  Future<String> uploadCause({
    @required String causeID,
    @required String postID,
    @required File file,
  }) async =>
      await upload(
        uid: uid,
        file: file,
        path: FirestorePath.cause(causeID) + '/$postID.png',
        contentType: 'image/png',
      );

  //upload file codesss
  Future<String> upload({
    @required String uid,
    @required File file,
    @required String path,
    @required String contentType,
  }) async {
    final storageRef = FirebaseStorage.instance.ref().child(path);
    try {
      final snapshot = await storageRef.putFile(
          file, SettableMetadata(contentType: contentType));
      final downloadUrl = await snapshot.ref.getDownloadURL();
      print('downloadUrl: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('upload error code: $e');
      return null;
    }
  }
}
