class ProfReference {
  ProfReference(
    this.uid,
    this.causesDonated,
    this.causesBookmarked,
    this.totalDonated,
  );

  final String uid;
  final double causesDonated;
  final double causesBookmarked;
  final double totalDonated;

  factory ProfReference.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String uid = data['uid'];
    final double causesDonated = data['causesDonated'];
    final double causesBookmarked = data['causesBookmarked'];
    final double totalDonated = data['totalDonated'];

    if (uid == null) {
      return null;
    }
    if (causesDonated == null) {
      return null;
    }
    if (causesBookmarked == null) {
      return null;
    }
    if (totalDonated == null) {
      return null;
    }

    return ProfReference(uid, causesDonated, causesBookmarked, totalDonated);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'causesDonated': causesDonated,
      'causesBookmarked': causesBookmarked,
      'totalDonated': totalDonated,
    };
  }
}

class Bookmrk {
  Bookmrk(this.causeID);
  final String causeID;

  factory Bookmrk.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String causeID = data['causeID'];
    if (causeID == null) {
      return null;
    }
    return Bookmrk(causeID);
  }

  Map<String, dynamic> toMap() {
    return {
      'causeID': causeID,
    };
  }
}
/*
class  Donate{
  Donate(this.causeID);
  final String causeID;

  factory  Donate.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String causeID = data['causeID'];
    if (causeID  == null) {
      return null;
    }
    return Donate(causeID);
  }

  Map<String, dynamic> toMap() {
    return {
      'causeID': causeID,
    };
  }
}*/
