class ProfilePicReference {
  ProfilePicReference(this.downloadUrl);
  final String downloadUrl;

  factory ProfilePicReference.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String downloadUrl = data['downloadUrl'];
    if (downloadUrl == null) {
      return null;
    }
    return ProfilePicReference(downloadUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'downloadUrl': downloadUrl,
    };
  }
}
