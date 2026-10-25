import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> usersignUp({
  required String email,
  required String password,
  required String username,
}) async {
  final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email.trim(),
    password: password,
  );

  final user = cred.user!;

  await user.updateDisplayName(username.trim());

  await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'username': username.trim(),
    'email': user.email,
    'createdAt': FieldValue.serverTimestamp(),
  });
}
