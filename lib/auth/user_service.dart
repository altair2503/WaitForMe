// // Assume this is your user model
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserModel {
//   final String uid;
//   final String name;
//   final String surname;
//   final String role;

//   UserModel({required this.uid,required this.name, required this.surname, required this.role});

//   // Add a method to convert user data to a map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'name': name,
//       'surname': surname,
//       'role': role,
//     };
//   }

//   // Add a method to create a UserModel from a Firestore document
//   factory UserModel.fromDocument(DocumentSnapshot doc) {
//     return UserModel(
//       uid: doc.id,
//       name: doc['name'],
//       surname: doc['surname'],
//       role: doc['role'],
//     );
//   }
// }



// // User service that will manage fetching and updating user data
// class UserService {
  
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   late UserModel? _currentUser;

//   UserModel? get currentUser => _currentUser;

//   Future<void> updateUserModel() async {
    
//     User? firebaseUser = _auth.currentUser;
//     if (firebaseUser != null) {
//       DocumentSnapshot userDoc = await _firestore.collection('users').doc(firebaseUser.uid).get();
//       _currentUser = UserModel.fromDocument(userDoc);
//     }
//   }
// }

// In your login view, after the user logs in, call `updateUserModel`
// Then you can use a Provider to access the `UserService` instance across your app
