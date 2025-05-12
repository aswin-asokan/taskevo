//state management
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trelza_taskevo/features/auth/domain/entities/app_user.dart';
import 'package:trelza_taskevo/features/auth/domain/repos/auth_repo.dart';
import 'package:trelza_taskevo/features/auth/presentation/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  //get current user
  AppUser get currentUser => _currentUser!;

  //check if user is authenticated
  void authCheck() async {
    //loading state
    emit(AuthLoading());

    //get current user
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user: user));
    } else {
      emit(Unauthenticated());
    }
  }

  //login with email and password
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  //register with email and password
  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.registerWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  //logout
  Future<void> logout() async {
    try {
      emit(AuthLoading());
      await authRepo.logout();
      _currentUser = null;
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  //forgot password
  Future<void> forgotPassword(String email) async {
    try {
      emit(AuthLoading());
      await authRepo.sendPasswordResetEmail(email: email);
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  //delete account
  Future<void> deleteAccount() async {
    try {
      emit(AuthLoading());
      await authRepo.deleteAccount();
      _currentUser = null;
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }
}
