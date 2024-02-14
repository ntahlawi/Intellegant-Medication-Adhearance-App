import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('rewards'),
      ),
      body: const RewardsPage(),
    );
  }
}

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  late FirebaseAuth _auth; // Firebase authentication instance
  late int _currentPoints; // Current points displayed in the UI

  @override
  void initState() {
    super.initState();
    FirebaseService.initializeFirebase(); // Initializes Firebase
    _auth = FirebaseAuth.instance; // Gets the active authentication instance
    _loadCurrentPoints(); // Loads initial points for the user
  }

  // Loads the current points for the logged-in user
  Future<void> _loadCurrentPoints() async {
    try {
      final user = await _getCurrentUser();
      if (user != null) {
        final userId = user.uid; // User is logged in:
        final points = await FirebaseService.getCurrentPoints(
            userId); // Retrieve points from Firebase
        _updatePointsInPrefs(
            userId, points); // Update local cache for faster subsequent access

        setState(() {
          _currentPoints = points; //Update points displayed in the UI
        });
      }
    } catch (error) {
      // Add error handling here (e.g., display a message to the user)
    }
  }

  //Returns the currently logged-in Firebase user, or null if not signed in

  Future<User?> _getCurrentUser() async {
    return _auth.currentUser;
  }
  //Retrieves cached points from SharedPreferences (if available)
  int _getCachedPoints(String userId) {
    SharedPreferences prefs =
        SharedPreferences.getInstance() as SharedPreferences;
    return prefs.getInt(userId) ?? 0;
  }
  //Increments the user's points and updates the UI
  void _incrementPoints() async {
    User? user = await _getCurrentUser();
    if (user != null) {
      final userId = user.uid;
      final newPoints = _currentPoints + 1;
      await FirebaseService.updatePoints(userId, newPoints);
      _updatePointsInPrefs(userId, newPoints);
    }
  }
  // deducts the user's points and updates the UI
  void _deductPoints(int deductionAmount) async {
    User? user = await _getCurrentUser();
    if (user != null) {
      final userId = user.uid;
      final currentPoints = await FirebaseService.getCurrentPoints(userId);
      final newPoints =
          (currentPoints - deductionAmount).clamp(0, currentPoints);
      await FirebaseService.deductPoints(userId, newPoints);
      _updatePointsInPrefs(userId, newPoints);
    }
  }
  // updates the cached points in SharedPreferences
  void _updatePointsInPrefs(String userId, int newPoints) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(userId, newPoints);
    setState(() {
      _currentPoints = newPoints;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current Points: $_currentPoints'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementPoints,
              child: const Text('Gain 1 Point'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _deductPoints(1),
              child: const Text('Deduct 1 Point'),
            ),
          ],
        ),
      ),
    );
  }
}

class FirebaseService {
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  static Future<int> getCurrentPoints(String userId) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('Info').doc(userId).get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null) {
        return data['points'] ?? 0;
      }
    }
    return 0;
  }

  static Future<void> updatePoints(String userId, int newPoints) async {
    await FirebaseFirestore.instance
        .collection('Info')
        .doc(userId)
        .set({'points': newPoints}, SetOptions(merge: true));
  }

  static Future<void> deductPoints(String userId, int newPoints) async {
    await FirebaseFirestore.instance
        .collection('Info')
        .doc(userId)
        .set({'points': newPoints});
  }
}
