import 'dart:async';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony_hub/session_state.dart';
import 'package:harmony_hub/styles/styles.dart';
import 'package:intl/intl.dart';

class SessionView extends ConsumerStatefulWidget {
  const SessionView({
    super.key,
  });

  @override
  ConsumerState<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends ConsumerState<SessionView> {
  late Timer _timer;
  Duration _elapsedTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = ref.read(sessionStateNotifierProvider).elapsedTime;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(sessionStateNotifierProvider);
    if (sessionState.status == SessionStatus.commenced) {
      _elapsedTime = _elapsedTime +
          DateTime.now()
              .difference(sessionState.resumeTime ?? sessionState.startTime);
    }
    final formattedElapsedTime = _formatDuration(_elapsedTime);
    final formattedStartTime = DateFormat.jm().format(sessionState.startTime);

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
                          'Session Information',
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
                        Text('Time Started: $formattedStartTime',
                            style: kListItemSubtitleStyle.copyWith(
                              color: context.colors.scheme.onSurfaceVariant,
                              fontSize: context.textStyles.bodyMedium.fontSize,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Elapsed Time: $formattedElapsedTime',
                            style: kListItemSubtitleStyle.copyWith(
                              color: context.colors.scheme.onSurfaceVariant,
                              fontSize: context.textStyles.bodyMedium.fontSize,
                            )),
                      ],
                    ),
                  ],
                ))));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
