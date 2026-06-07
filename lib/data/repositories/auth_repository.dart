import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile.dart';
import '../../core/constants/firestore_paths.dart';

class AuthRepository {
  AuthRepository(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signInWithEmail(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> registerWithEmail(
      String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return cred;
  }

  Future<void> signOut() => _auth.signOut();

  Stream<UserProfile?> watchUserProfile(String uid) => _firestore
      .doc(FirestorePaths.user(uid))
      .snapshots()
      .map((s) => s.exists ? UserProfile.fromJson(s.data()!) : null);

  Future<void> createUserProfile(UserProfile profile) => _firestore
      .doc(FirestorePaths.user(profile.uid))
      .set(profile.toJson());

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) =>
      _firestore.doc(FirestorePaths.user(uid)).update(data);
}
