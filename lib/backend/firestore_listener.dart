import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fetchingapp/backend/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirestoreChanges extends ChangeNotifier {
  Future future = Future(() => null);

  void listenOnFirestoreChanges() {
    FirebaseFirestore.instance
        .collection('flutter-caching')
        .snapshots()
        .listen((event) {
      print(event.docs.length);
      print('EVENT!!!');
      future = getFromFirestore();
      notifyListeners();
    });
  }

  Future getFromFirestore() async {
    var data = await FirebaseFirestore.instance
        .collection('flutter-caching')
        .orderBy('name')
        .get();
    var array = data.docs.map((e) {
      return {'name': e['name']};
    }).toList();
    print('shit is called');

    // await insertSQLite(list: array);
    return array;
  }
}

// Future getFromFirestore() async {
//   var data = await FirebaseFirestore.instance
//       .collection('flutter-caching')
//       .orderBy('name')
//       .get();
//   var array = data.docs.map((e) {
//     return {'name': e['name']};
//   }).toList();

//   // await insertSQLite(list: array);
//   return array;
// }
