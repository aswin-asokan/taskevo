// backend code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:trelza_taskevo/features/auth/domain/entities/app_user.dart';
import 'package:trelza_taskevo/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  //access to firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> loginWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword({
    String? name,
    String? email,
    String? password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!);
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);
      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!);
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        throw Exception('No user is currently signed in.');
      }
      await user.delete();

      await logout();
    } catch (e) {
      throw Exception('Account deletion failed: $e');
    }
  }

  @override
  Future<String> sendPasswordResetEmail({String? email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email!);
      return 'Password reset email sent to $email';
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }
}
