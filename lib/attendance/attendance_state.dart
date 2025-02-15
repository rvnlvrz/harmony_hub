import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_state.freezed.dart';

enum AttendanceFilter {
  ready,
  present,
  absent,
  absentExcused,
  late,
  lateExcused
}

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState({required Set<AttendanceFilter> filters}) =
      _AttendanceState;
}

class AttendanceStateNotifier extends StateNotifier<AttendanceState> {
  AttendanceStateNotifier() : super(AttendanceState(filters: {}));
}
