import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> submitUserData(Map<String, String> userData) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is signed in, so you can get the user ID
      String userId = user.uid;

      // Access the Firestore collection named "UserInfo"
      CollectionReference userInfoCollection =
          FirebaseFirestore.instance.collection('UserInfo');

      // Query for documents with the same user ID
      QuerySnapshot querySnapshot =
          await userInfoCollection.where('userId', isEqualTo: userId).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Document already exists, update the fields
        await userInfoCollection.doc(querySnapshot.docs[0].id).update(userData);

        print('Document updated for user with ID: $userId');
      } else {
        // Document doesn't exist, create a new one
        await userInfoCollection.add({
          'userId': userId,
          ...userData, // Spread the contents of the userData map
        });

        print('Document added for user with ID: $userId');
      }
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
