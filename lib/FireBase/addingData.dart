import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> submitUserData(Map<String, String> userData) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is signed in, so you can get the user ID
      String userId = user.uid;

      // Directly create or update the document with the user ID as its name
      DocumentReference userInfoDoc =
          FirebaseFirestore.instance.collection('UserInfo').doc(userId);

      await userInfoDoc.set({
        ...userData, // Spread the contents of the userData map
      });

      print('User data submitted for user with ID: $userId');
    } else {
      // User is not signed in, handle accordingly
      print('User is not signed in');
    }
  } catch (e) {
    print('Error submitting user data: $e');
    // Handle the error as needed
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