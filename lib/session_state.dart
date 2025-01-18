import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_state.freezed.dart';

enum SessionStatus { ready, commenced, paused, ended }

@freezed
class SessionState with _$SessionState {
  const factory SessionState(
      {required DateTime startTime,
      required Duration elapsedTime,
      required SessionStatus status,
      DateTime? pauseTime,
      DateTime? resumeTime,
      DateTime? endTime}) = _SessionState;
}

class SessionStateNotifier extends StateNotifier<SessionState> {
  SessionStateNotifier()
      : super(SessionState(
            startTime: DateTime.now(),
            elapsedTime: Duration.zero,
            status: SessionStatus.ready));

  void startSession() {
    state = state.copyWith(
        startTime: DateTime.now(),
        elapsedTime: Duration.zero,
        status: SessionStatus.commenced,
        pauseTime: null,
        resumeTime: null,
        endTime: null);
  }

  void pauseSession() {
    state =
        state.copyWith(status: SessionStatus.paused, pauseTime: DateTime.now());

    updateElapsedTime();
  }

  void endSession() {
    // Implement end logic
    if (state.status != SessionStatus.paused) {
      pauseSession();
    }

    state =
        state.copyWith(status: SessionStatus.ended, endTime: DateTime.now());
  }

  void updateElapsedTime() {
    if (state.pauseTime != null && state.resumeTime != null) {
      state = state.copyWith(
          elapsedTime: state.elapsedTime +
              state.pauseTime!.difference(state.resumeTime!));
    } else if (state.pauseTime != null && state.resumeTime == null) {
      state = state.copyWith(
          elapsedTime:
              state.elapsedTime + state.pauseTime!.difference(state.startTime));
    } else {
      state = state.copyWith(
          elapsedTime: DateTime.now().difference(state.startTime));
    }
  }

  void resumeSession() {
    state = state.copyWith(
        resumeTime: DateTime.now(), status: SessionStatus.commenced);
  }
}

final sessionStartTimeProvider = Provider<DateTime>((ref) {
  return DateTime.now();
});

final sessionStateNotifierProvider =
    StateNotifierProvider<SessionStateNotifier, SessionState>((ref) {
  return SessionStateNotifier();
});
