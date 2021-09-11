import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:sankofa_sme_exec/functions/randomchars.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signUpPage.dart';
import 'package:sankofa_sme_exec/screens/skillScreens/mediumTermSkills.dart';
import 'package:sankofa_sme_exec/screens/skillSetsPage.dart';
import 'package:sankofa_sme_exec/screens/teamleadEmailPage.dart';
import 'package:sankofa_sme_exec/utilities/globalVars.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Users');
final CollectionReference _diagCollection =
    _firestore.collection('Diagnostics');

var currId = '';
var userID;
var tempPass; //TO Be remove
var ownerDocId;
var ownerCompName;
var collectionRef;
final password = RandomPasswordGenerator();

class Database {
  // static String? userUid;

  static Future<void> addItem({
    required String uid,
    required fName,
    required email,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(); //should check if document exists in db or not

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

    userID = documentReferencer.id;
  }

  //create collection in the relevent diagnostic
  //add the user skills selected
  static Future<void> addSkills({
    // required List skills,
    required String currID,
    required String diagnName,
    required String location,
  }) async {
    // DocumentReference documentReferencerMainDiag = _diagCollection
    //     .doc(ownerDocId); //should check if document exists in db or not

    // documentReferencerMainDiag.set({
    //   "Company Name": ownerCompName,
    //   "Id": ownerDocId,
    //   "Date": FieldValue.serverTimestamp(),
    // });

    if (location == 'short term') {
      DocumentReference documentReferencerShortTerm = _diagCollection
          .doc(ownerDocId)
          .collection("Diagnostics")
          .doc(diagnName)
          .collection('Strategic Skills')
          .doc(diagnName)
          .collection('Short Term Skills')
          .doc();
      Map<String, dynamic> data = <String, dynamic>{
        "Skills": outterList,
      };

      await documentReferencerShortTerm
          .set(data)
          .whenComplete(() => print("Note item added to the database"))
          .catchError((e) => print(e));

      outterList.clear();
      selectedCountList!.clear();
    } else {
      DocumentReference documentReferencerMedTerm = _diagCollection
          .doc(ownerDocId)
          .collection("Diagnostics")
          .doc(diagnName)
          .collection('Strategic Skills')
          .doc(diagnName)
          .collection('Medium Term Skills')
          .doc();

      // var query = FirebaseFirestore.instance.collection('Diagnostics').where("Reference" == reference);
      Map<String, dynamic> data = <String, dynamic>{
        "Skills": midTermList,
      };

      await documentReferencerMedTerm
          .set(data)
          .whenComplete(() => print("Note item added to the database"))
          .catchError((e) => print(e));

      midTermList.clear();
      selectedMidTermSkillList!
          .clear(); //have to clear selected list for mid term

    }
  }

  //add the teamleaders
  static Future<void> addTeamLeaders({
    // required List mailList,
    required String currID,
  }) async {
    // DocumentReference documentReferencer = _mainCollection.doc(email).collection('Diagnostics').doc(); //should check if document exists in db or not
// var query = FirebaseFirestore.instance.collection('Diagnostics').where("Company Name" == compName);

// print(query.id);
    for (var i = 0; i < teamLeadMailList.length; i++) {
      DocumentReference documentReferencerDiag =
          _diagCollection.doc(ownerDocId).collection('Team').doc();

      // DocumentReference documentReferencer = _mainCollection.doc();
      tempPass = password.randomPassword(
          letters: true,
          numbers: true,
          passwordLength: 7,
          specialChar: true,
          uppercase: true);

      print('pass:$tempPass email:${teamLeadMailList[i]['email'].toString()}');

      await auth
          .createUserWithEmailAndPassword(
              email: teamLeadMailList[i]['email'].toString(),
              password: tempPass)
          .then((value) => {
                _mainCollection.doc().set({
                  "First Name": value.user!.displayName,
                  "email": value.user!.email,
                  "OwnerID": ownerDocId,
                  "Role": "Team Lead",
                  "id": documentReferencerDiag.id
                }), //should check if document exists in db or not
              });

      Map<String, dynamic> data = <String, dynamic>{
        "Name": teamLeadMailList[i]['name'].toString(),
        "Email": teamLeadMailList[i]['email'].toString(),
        "Self Assessment Result Medium Term": '',
        "Self Assessment Result Near Term": '',
        "Role": 'Team Lead',
        "Self Assessment Status": "TO-DO",
        "id": documentReferencerDiag.id
      };

      await documentReferencerDiag
          .set(data)
          .whenComplete(() => print("Note item added to the database"))
          .catchError((e) => print(e));
    }

    // Map<String, dynamic> data = <String, dynamic>{
    //   "Skills": outterList,

    // };

    // await documentReferencerDiag
    //     .set(data)
    //     .whenComplete(() => print("Note item added to the database"))
    //     .catchError((e) => print(e));

    teamLeadMailList.clear();
  }

//changes the state of assessment/diagnostic
  static Future<void> updateDiagnostic({
    // required String docuID,
    required String reference,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userID).collection('Diagnostics').doc(reference);

    DocumentReference documentReferencerDiag = _diagCollection.doc(reference);

    documentReferencer.update({"Stage": 'finalized'});

    documentReferencerDiag.update({"Stage": 'finalized'});
  }

  //adds a new diagnostic
  static Future<void> addNewDiagnostic({
    required String diagnName,
  }) async {
    // creates a diagnostic collection in the users
    DocumentReference documentReferencer =
        _mainCollection.doc(userID).collection('Diagnostics').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "Start Date": FieldValue.serverTimestamp(),
      "Reference": diagnName,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Added new diagnostic in DB"))
        .catchError((e) => print(e));

    currId = documentReferencer.id;
    gDocuId = documentReferencer.id;
  }

  //creates a diagnostic in user collection and diagnostic collection
  //should update
  static Future<void> addDiagnostic({
    required String diagnName,
    required String email,
    required String from,
  }) async {
    // creates a diagnostic collection in the users
    DocumentReference documentReferencer =
        _mainCollection.doc(userID).collection('Diagnostics').doc();

    // creates a diagnostic collection in the diagnostic main collection
    DocumentReference documentReferencerDiag = _diagCollection.doc(ownerDocId);

    Map<String, dynamic> data = <String, dynamic>{
      "Start Date": FieldValue.serverTimestamp(),
      "Reference": diagnName,
    };

    Map<String, dynamic> diagData = <String, dynamic>{
      "Company Name": companyNameController.text,
      // "Reference": diagnName,
      // "Start Date": FieldValue.serverTimestamp(),
      "id": ownerDocId,
      // "Stage": 'Assessment',
      "Code": stringCode,
    };
    await documentReferencerDiag
        .set(diagData)
        .whenComplete(() => print("diagnostic set"))
        .catchError((e) => print(e));

    DocumentReference documentReferencerNewDiag = _diagCollection
        .doc(ownerDocId)
        .collection("Diagnostics")
        .doc(diagnName); //.collection(diagnName).doc();

    await documentReferencerNewDiag.set({
      ...data,
      "Stage": 'Assessment',
    });

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));

    // _firestore.collection('Users')
    // FirebaseFirestore.instance.collection('Users').doc(userID).update({
    //   "Company": companyNameController.text,
    // });
    // FirebaseFirestore.instance.collection('Users').doc(userID).update({
    //   "Company": companyNameController.text,
    // });

    collectionRef = diagnName;
    currId = documentReferencerNewDiag.id;
    gDocuId = documentReferencerDiag.id;
  }

  //updates form w/ company name and sectors
  static Future<void> updateRegiForm({
    required String companyName,
    required String primarySec,
    required String secondarySec,
    required String email,
  }) async {
    DocumentReference documentReferencer = _mainCollection.doc(userID);

    //check if fields are empty or not, to avoid adding empty fields to db
    documentReferencer.update({
      "Company": companyName,
      "Primary Sector": priSectordropdownValue,
      "Secondary Sector": secSectordropdownValue,
    });

    print(priSectordropdownValue);

    // await documentReferencer
    //     .update(data)
    //     .whenComplete(() => print("Note item updated in the database"))
    //     .catchError((e) => print(e));
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
