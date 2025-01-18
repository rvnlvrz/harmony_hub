import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:harmony_hub/profile_card.dart';
import 'package:harmony_hub/session_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required Credentials? credentials,
  }) : _credentials = credentials;

  final Credentials? _credentials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ProfileCard(
              credentials: _credentials,
              onPrimaryAction: () async {},
              primaryActionText: _credentials == null ? 'Log in' : 'Log out',
            ),
            SessionCard(),
          ],
        ),
      ),
    );
  }
}
