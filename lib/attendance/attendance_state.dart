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

  void addFilter(AttendanceFilter filter) {
    state = state.copyWith(filters: {...state.filters, filter});
  }

  void addFilters(Set<AttendanceFilter> filters) {
    state = state.copyWith(filters: {...state.filters, ...filters});
  }

  void removeFilter(AttendanceFilter filter) {
    var filters = Set.from(state.filters);
    filters.remove(filter);
    state = state.copyWith(filters: {...filters});
  }

  void removeFilters(Set<AttendanceFilter> filters) {
    Set<AttendanceFilter> updatedFilters = Set.from(state.filters);
    for (var filter in filters) {
      updatedFilters.remove(filter);
    }
    state = state.copyWith(filters: updatedFilters);
  }
}

final attendanceStateNotifierProvider =
    StateNotifierProvider<AttendanceStateNotifier, AttendanceState>((ref) {
  return AttendanceStateNotifier();
});
