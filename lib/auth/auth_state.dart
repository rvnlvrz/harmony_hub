import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState(
      {required Credentials? credentials,
      required bool isAuthenticated,
      required String? error}) = _AuthState;

  static AuthState init() {
    return AuthState(credentials: null, isAuthenticated: false, error: null);
  }
}
