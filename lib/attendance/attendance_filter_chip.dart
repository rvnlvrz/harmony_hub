import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony_hub/attendance/attendance_state.dart';

class AttendanceFilterChip extends ConsumerWidget {
  const AttendanceFilterChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceStateNotifier =
        ref.read(attendanceStateNotifierProvider.notifier);

    final attendanceState = ref.watch(attendanceStateNotifierProvider);

    return Wrap(
      spacing: 5.0,
      children: [
        FilterChip(
          label: Text('Ready'),
          selected: attendanceState.filters.contains(AttendanceFilter.ready),
          onSelected: (bool selected) {
            if (selected) {
              attendanceStateNotifier.addFilter(AttendanceFilter.ready);
            } else {
              attendanceStateNotifier.removeFilter(AttendanceFilter.ready);
            }
          },
        ),
        FilterChip(
          label: Text('Present'),
          selected: attendanceState.filters.contains(AttendanceFilter.present),
          onSelected: (bool selected) {
            if (selected) {
              attendanceStateNotifier.addFilter(AttendanceFilter.present);
            } else {
              attendanceStateNotifier.removeFilter(AttendanceFilter.present);
            }
          },
        ),
        FilterChip(
          label: Text('Absent'),
          selected: attendanceState.filters.contains(AttendanceFilter.absent) ||
              attendanceState.filters.contains(AttendanceFilter.absentExcused),
          onSelected: (bool selected) {
            if (selected) {
              attendanceStateNotifier.addFilters(
                  {AttendanceFilter.absent, AttendanceFilter.absentExcused});
            } else {
              attendanceStateNotifier.removeFilters(
                  {AttendanceFilter.absent, AttendanceFilter.absentExcused});
            }
          },
        ),
        FilterChip(
          label: Text('Late'),
          selected: attendanceState.filters.contains(AttendanceFilter.late) ||
              attendanceState.filters.contains(AttendanceFilter.lateExcused),
          onSelected: (bool selected) {
            if (selected) {
              attendanceStateNotifier.addFilters(
                  {AttendanceFilter.late, AttendanceFilter.lateExcused});
            } else {
              attendanceStateNotifier.removeFilters(
                  {AttendanceFilter.late, AttendanceFilter.lateExcused});
            }
          },
        ),
      ],
    );
  }
}
