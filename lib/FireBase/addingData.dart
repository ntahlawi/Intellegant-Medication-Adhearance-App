// ignore_for_file: avoid_print, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> submitUserData(Map<String, String> userData) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      DocumentReference userInfoDoc = FirebaseFirestore.instance.collection('UserInfo').doc(userId);

      // Use set(merge: true) for creation + update
      await userInfoDoc.set(userData, SetOptions(merge: true)); 

      print('User data set (or updated) for user with ID: $userId');
    } else {
      print('User is not signed in');
    }
  } catch (e) {
    print('Error setting user data: $e');
  }
}

//EXAMPLE
// submitUserData({
//   'name': Nametextcntrlr.text,
//   'height': Height.text,
//   'weight': weight.text,
//   'bloodslvl': bloodslvl.text,
//   'targetweight': targetweight.text,
//   // Add other fields as needed
// });
