import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony_hub/session/session_view.dart';

import 'attendance_state.dart';
// import 'package:harmony_hub/shared/infrastructure/dto/people.dart';

class Attendance extends ConsumerWidget {
  const Attendance({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final AsyncValue<People> members = ref.watch(membersProvider);
    // final attendanceStateNotifier =
    //     ref.read(attendanceStateNotifierProvider.notifier);
    //
    // final attendanceState = ref.watch(attendanceStateNotifierProvider);

    return Center(
        child: Container(
      padding: const EdgeInsets.all(8),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            SessionView(),
            SearchAnchor(
                viewShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                viewBackgroundColor: context.colors.scheme.surface,
                builder: (context, controller) {
                  return SearchBar(
                    controller: controller,
                    backgroundColor:
                        WidgetStatePropertyAll(context.colors.scheme.surface),
                    padding: WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    leading: const Icon(Icons.search),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    elevation: WidgetStatePropertyAll(0),
                    hintText: 'Search for attendees',
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {},
                    );
                  });
                }),
            // create choice chip between ready, present, absent, and late
            AttendanceFilterChip(),
          ]),
    ));
  }
}

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
