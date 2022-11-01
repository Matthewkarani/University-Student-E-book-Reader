/*


import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseApi {
  static Future<List<FirebaseFile>> listAll(String path) async{
    final ref = FirebaseStorage.instance.ref(path);//relative path in firebase system
    final result = await ref.listAll();

    final urls = await _getDownloadlinks(result.items);


  }
}

class FirebaseFile {
}*/
