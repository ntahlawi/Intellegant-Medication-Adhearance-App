import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void updateUserDataField(String fieldName, String newValue) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is signed in, so you can get the user ID
      String userId = user.uid;

      // Access the Firestore collection named "UserInfo"
      CollectionReference userInfoCollection = FirebaseFirestore.instance.collection('UserInfo');

      // Query for the document with the user's ID
      QuerySnapshot querySnapshot = await userInfoCollection.where('userId', isEqualTo: userId).get();

      // Check if a document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Update the specified field with the new value
        await userInfoCollection.doc(querySnapshot.docs[0].id).update({
          fieldName: newValue,
        });

        print('Field $fieldName updated successfully.');
      } else {
        print('No document found for user with ID: $userId');
      }
    } else {
      // User is not signed in, handle accordingly
      print('User is not signed in');
    }
  } catch (e) {
    print('Error updating user data: $e');
    // Handle the error as needed
  }
}

// Example: Update the 'height' field to a new value
//updateUserDataField('height', 'new_height_value');
