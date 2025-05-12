import 'package:trelza_taskevo/features/auth/domain/entities/app_user.dart';

abstract class AuthState {}

//initial state
class AuthInitial extends AuthState {}

//loading state

class AuthLoading extends AuthState {}

//authenticated state
class Authenticated extends AuthState {
  final AppUser user;
  Authenticated({required this.user});
}

//unauthenticated state
class Unauthenticated extends AuthState {}

//error state
class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}
