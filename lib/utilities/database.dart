import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/screens/teamleadEmailPage.dart';

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



  //create collection in the relevent diagnostic
  //add the user skills selected
  static Future<void> addSkills({
    // required List skills,
    required String reference, 
  }) async {
    // DocumentReference documentReferencer = _mainCollection.doc(email).collection('Diagnostics').doc(); //should check if document exists in db or not

    DocumentReference documentReferencerDiag = _diagCollection.doc(reference).collection('Strategic Skills').doc().collection('Medium Term Skills').doc();

    // var query = FirebaseFirestore.instance.collection('Diagnostics').where("Reference" == reference);
    Map<String, dynamic> data = <String, dynamic>{
      "Skills": outterList,
      
    };

    await documentReferencerDiag
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  //add the teamleaders
  static Future<void> addTeamLeaders({
    // required List mailList,
    required String reference, //company name
  }) async {
    // DocumentReference documentReferencer = _mainCollection.doc(email).collection('Diagnostics').doc(); //should check if document exists in db or not

    
    
    for (var i = 0; i < teamLeadMailList.length; i++) {
      DocumentReference documentReferencerDiag = _diagCollection.doc(reference).collection('Team').doc(teamLeadMailList[i]['name'].toString());

      Map<String, dynamic> data = <String, dynamic>{
      "Name": teamLeadMailList[i]['name'].toString(),
      "Email": teamLeadMailList[i]['email'].toString(),
      "Self Assessment Result Medium Term": '',
      "Role": 'Team Lead',
      
    };

    await documentReferencerDiag
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
    }

    // var query = FirebaseFirestore.instance.collection('Diagnostics').where("Reference" == reference);
    // Map<String, dynamic> data = <String, dynamic>{
    //   "Skills": outterList,
      
    // };

    // await documentReferencerDiag
    //     .set(data)
    //     .whenComplete(() => print("Note item added to the database"))
    //     .catchError((e) => print(e));
  }

  //creates a diagnostic in user collection and diagnostic collection
  static Future<void> addDiagnostic({
    required String diagnName,
    required String email,
    required String reference,  
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(email).collection('Diagnostics').doc(diagnName); 

    DocumentReference documentReferencerDiag = _diagCollection.doc(reference);

    Map<String, dynamic> data = <String, dynamic>{
      "Start Date":FieldValue.serverTimestamp(),
    };

    Map<String, dynamic> diagData = <String, dynamic>{
      "Company Name": companyNameController.text,
      "Reference": diagnName,
      "Start Date": FieldValue.serverTimestamp(),
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
    
    await documentReferencerDiag
        .set(diagData)
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
