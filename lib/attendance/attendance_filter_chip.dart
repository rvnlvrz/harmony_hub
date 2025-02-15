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
            final filter = AttendanceFilter.ready;
            if (selected) {
              attendanceStateNotifier.addFilter(filter);
            } else {
              attendanceStateNotifier.removeFilter(filter);
            }
          },
        ),
        FilterChip(
          label: Text('Present'),
          selected: attendanceState.filters.contains(AttendanceFilter.present),
          onSelected: (bool selected) {
            final filter = AttendanceFilter.present;
            if (selected) {
              attendanceStateNotifier.addFilter(filter);
            } else {
              attendanceStateNotifier.removeFilter(filter);
            }
          },
        ),
        FilterChip(
          label: Text('Absent'),
          selected: attendanceState.filters.contains(AttendanceFilter.absent) ||
              attendanceState.filters.contains(AttendanceFilter.absentExcused),
          onSelected: (bool selected) {
            final filters = {
              AttendanceFilter.absent,
              AttendanceFilter.absentExcused
            };
            if (selected) {
              attendanceStateNotifier.addFilters(filters);
            } else {
              attendanceStateNotifier.removeFilters(filters);
            }
          },
        ),
        FilterChip(
          label: Text('Late'),
          selected: attendanceState.filters.contains(AttendanceFilter.late) ||
              attendanceState.filters.contains(AttendanceFilter.lateExcused),
          onSelected: (bool selected) {
            final filters = {
              AttendanceFilter.late,
              AttendanceFilter.lateExcused
            };
            if (selected) {
              attendanceStateNotifier.addFilters(filters);
            } else {
              attendanceStateNotifier.removeFilters(filters);
            }
          },
        ),
      ],
    );
  }
}
