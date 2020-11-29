import 'package:cloud_firestore/cloud_firestore.dart';

class CauseReference {
  CauseReference(
      this.uid,
      this.title,
      this.category,
      this.timestamp,
      this.causeID,
      this.description,
      this.target,
      this.bookmarks,
      this.donations,
      this.total,
      this.rating,
      this.popularity,
      this.downloadUrl);

  final String uid;
  final String title;
  final String category;
  final Timestamp timestamp;
  final String causeID;
  final String description;
  final double target;
  final double bookmarks;
  final double donations;
  final double total;
  final double rating;
  final double popularity;
  final String downloadUrl;

  factory CauseReference.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String uid = data['uid'];
    final String title = data['title'];
    final String category = data['category'];
    final Timestamp timestamp = data['timestamp'];
    final String causeID = data['causeID'];
    final String description = data['description'];
    final double target = data['target'];
    final double bookmarks = data['bookmarks'];
    final double donations = data['donations'];
    final double total = data['total'];
    final double rating = data['rating'];
    final double popularity = data['popularity'];
    final String downloadUrl = data['downloadUrl'];
    if (downloadUrl == null) {
      return null;
    }
    if (uid == null) {
      return null;
    }
    if (title == null) {
      return null;
    }
    if (category == null) {
      return null;
    }
    if (timestamp == null) {
      return null;
    }
    if (causeID == null) {
      return null;
    }
    if (description == null) {
      return null;
    }
    if (target == null) {
      return null;
    }
    if (bookmarks == null) {
      return null;
    }
    if (donations == null) {
      return null;
    }
    if (total == null) {
      return null;
    }
    if (rating == null) {
      return null;
    }
    if (popularity == null) {
      return null;
    }
    return CauseReference(uid, title, category, timestamp, causeID, description,
        target, bookmarks, donations, total, rating, popularity, downloadUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'category': category,
      'timestamp': timestamp,
      'causeID': causeID,
      'description': description,
      'target': target,
      'bookmarks': bookmarks,
      'donations': donations,
      'total': total,
      'popularity': popularity,
      'rating': rating,
      'downloadURL': downloadUrl,
    };
  }
}
