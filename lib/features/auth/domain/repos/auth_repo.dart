// contains auth operations of the app

import 'package:trelza_taskevo/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailAndPassword({String email, String password});
  Future<AppUser?> registerWithEmailAndPassword({
    String name,
    String email,
    String password,
  });
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
  Future<String> sendPasswordResetEmail({String email});
  Future<void> deleteAccount();
}
