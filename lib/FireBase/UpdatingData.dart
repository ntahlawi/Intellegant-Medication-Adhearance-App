import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void updateUserDataField(String fieldName, String newValue) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is signed in, so you can get the user ID
      String userId = user.uid;

      // Directly access the document with the user ID
      DocumentReference userInfoDoc =
          FirebaseFirestore.instance.collection('UserInfo').doc(userId);

      // Update the specified field with the new value
      await userInfoDoc.update({
        fieldName: newValue,
      });

      print('Field $fieldName updated successfully for user with ID: $userId');
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
// updateUserDataField('height', 'new_height_value');
