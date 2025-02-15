import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony_hub/auth/auth_state.dart';

import 'auth_provider.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this.ref)
      : super(
            AuthState(credentials: null, isAuthenticated: false, error: null));

  final Ref ref;
  final scheme = 'harmonyhub';

  Future<void> login() async {
    try {
      final auth0 = ref.read(auth0Provider);
      final hasValidCreds =
          await auth0.credentialsManager.hasValidCredentials();

      final credentials = hasValidCreds
          ? await auth0.credentialsManager.credentials()
          : await auth0.webAuthentication(scheme: scheme).login(useHTTPS: true);

      state = state.copyWith(credentials: credentials, isAuthenticated: true);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      await logout();
    }
  }

  Future<void> logout() async {
    try {
      await ref
          .read(auth0Provider)
          .webAuthentication(scheme: scheme)
          .logout(useHTTPS: true);
      state = AuthState.init();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
