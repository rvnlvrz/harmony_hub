import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony_hub/auth/auth.dart';
import 'package:harmony_hub/auth/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
Auth0 auth0(Ref ref) {
  return Auth0('dev-gsbc-org.us.auth0.com', 'H0oLVM5XrHC08ljf2sBkvvtPF9djvs80');
}

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier(ref);
});
