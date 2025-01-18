import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony_hub/session_state.dart';
import 'package:harmony_hub/styles/styles.dart';

class SessionCard extends ConsumerWidget {
  const SessionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionStateNotifier =
        ref.read(sessionStateNotifierProvider.notifier);
    final sessionState = ref.watch(sessionStateNotifierProvider);

    return SizedBox(
        width: double.infinity,
        child: Card(
            color: context.colors.scheme.surface,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Practice Session',
                          style: kListItemSubtitleStyle.copyWith(
                            color: context.colors.scheme.onSurface,
                            fontSize: context.textStyles.titleMedium.fontSize,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Start a session to track time and attendance',
                            style: kListItemSubtitleStyle.copyWith(
                              color: context.colors.scheme.onSurfaceVariant,
                              fontSize: context.textStyles.bodyMedium.fontSize,
                            )),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 8.0,
                      children: [
                        FilledButton.tonal(
                            onPressed: () {},
                            child: Text(
                              'Past Sessions',
                              style: kListItemButtonLabelStyle.copyWith(
                                color: context.colors.scheme.primary,
                                fontSize:
                                    context.textStyles.labelLarge.fontSize,
                              ),
                            )),
                        FilledButton(
                            onPressed: () {
                              switch (sessionState.status) {
                                case SessionStatus.ready:
                                  sessionStateNotifier.startSession();
                                case SessionStatus.commenced:
                                  sessionStateNotifier.pauseSession();
                                case SessionStatus.paused:
                                  sessionStateNotifier.resumeSession();
                                case SessionStatus.ended:
                                  sessionStateNotifier.startSession();
                              }
                            },
                            child: Text(
                              getActionText(sessionState),
                              style: kListItemButtonLabelStyle.copyWith(
                                color: context.colors.scheme.onInverseSurface,
                                fontSize:
                                    context.textStyles.labelLarge.fontSize,
                              ),
                            ))
                      ],
                    )
                  ],
                ))));
  }

  String getActionText(SessionState sessionState) {
    switch (sessionState.status) {
      case SessionStatus.ready:
        return 'Start Session';
      case SessionStatus.commenced:
        return 'Stop Session';
      case SessionStatus.paused:
        return 'Resume Session';
      case SessionStatus.ended:
        return 'Start Session';
    }
  }
}
