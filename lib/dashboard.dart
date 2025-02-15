import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony_hub/auth/auth_provider.dart';
import 'package:harmony_hub/profile_card.dart';
import 'package:harmony_hub/session/session_card.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final credentials = ref.watch(authStateNotifierProvider).credentials;
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ProfileCard(
              credentials: credentials,
              onPrimaryAction: credentials == null
                  ? () => authStateNotifier.login()
                  : () => authStateNotifier.logout(),
              primaryActionText: credentials == null ? 'Log in' : 'Log out',
            ),
            SessionCard(),
          ],
        ),
      ),
    );
  }
}
