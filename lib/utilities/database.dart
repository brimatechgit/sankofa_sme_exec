import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Users');
final CollectionReference _diagCollection = _firestore.collection('Diagnostics');

class Database {
  // static String? userUid;

  static Future<void> addItem({
    required String fName,
    required String email, 
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(email); //should check if document exists in db or not

    Map<String, dynamic> data = <String, dynamic>{
      "First Name": fName,
      "email": email,
      "Company": '',
      "Primary Sector": '',
      "Secondary Sector": '',
      "type": 'Owner',
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> addSkills({
    required String fName,
    required String email, 
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(email).collection('Diagnostics').doc(); //should check if document exists in db or not

    Map<String, dynamic> data = <String, dynamic>{
      "Start Date":FieldValue.serverTimestamp(),
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }
  static Future<void> addDiagnostic({
    required String diagnName,
    required String email, 
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(email).collection('Diagnostics').doc(diagnName); 

    Map<String, dynamic> data = <String, dynamic>{
      "Start Date":FieldValue.serverTimestamp(),
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateRegiForm({
    required String companyName,
    required String primarySec,
    required String secondarySec,
    required String email,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(email);

    //check if fields are empty or not, to avoid adding empty fields to db
    Map<String, dynamic> data = <String, dynamic>{
     "Company": companyName,
      "Primary Sector": primarySec,
      "Secondary Sector": secondarySec,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  // static Stream<QuerySnapshot> readItems() {
  //   CollectionReference notesItemCollection =
  //       _mainCollection.doc(userUid).collection('items');

  //   return notesItemCollection.snapshots();
  // }

  // static Future<void> deleteItem({
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //       _mainCollection.doc(userUid).collection('items').doc(docId);

  //   await documentReferencer
  //       .delete()
  //       .whenComplete(() => print('Note item deleted from the database'))
  //       .catchError((e) => print(e));
  // }
}
