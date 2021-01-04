import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
  static final FirebaseHelper _helper = FirebaseHelper._internal();

  factory FirebaseHelper() {
    return _helper;
  }

  FirebaseHelper._internal();

  Future<String> uploadLastScore(String lastCalculation) async {
    var json = {"last_calculation": lastCalculation};
    var jsonString = jsonEncode(json);

    var bytes = utf8.encode(jsonString);
    var base64Str = base64.encode(bytes);

    var fileToUpload = base64.decode(base64Str);
    final StorageReference reference =
        FirebaseStorage.instance.ref().child("scores/last_calculation");
    StorageUploadTask uploadTask = reference.putData(fileToUpload);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    return (await snapshot.ref.getDownloadURL()).toString();
  }
}
