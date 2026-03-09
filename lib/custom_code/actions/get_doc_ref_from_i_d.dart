// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<DocumentReference> getDocRefFromID(String docID) async {
  // transform string value  into document reference

  // Get the Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get the document reference using the document ID
  DocumentReference docRef = firestore.collection('users').doc(docID);

  return docRef;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
