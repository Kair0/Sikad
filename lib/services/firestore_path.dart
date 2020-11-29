class FirestorePath {
  static String profiles(String uid) => 'profiles/$uid';
  static String names(String uid) => 'names/$uid';
  static String userInfo(String uid) => 'userInfo/$uid';
  static String bkmrk(String uid) => 'userInfo/$uid/bkmrk/default';
  static String cause(String causeID) => 'causes/$causeID';
  static String post(String postID) => 'posts/$postID';
}
