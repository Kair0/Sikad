import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  // Returns a [File] object pointing to the image that was picked.
  Future<File> getImage({@required ImageSource source}) async {
    var _file = await ImagePicker().getImage(source: source);
    return File(_file.path);
  }
}

class ImagePickerService2 with ChangeNotifier {
  // Returns a [File] object pointing to the image that was picked.
  Future<File> getImage({@required ImageSource source}) async {
    var _file = await ImagePicker().getImage(source: source);
    notifyListeners();
    return File(_file.path);
  }
}
