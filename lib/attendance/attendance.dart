import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harmony_hub/attendance/attendance_filter_chip.dart';
// import 'package:harmony_hub/attendance/attendance_state.dart';
import 'package:harmony_hub/session/session_view.dart';
import 'package:harmony_hub/shared/infrastructure/dto/people.dart';

// import 'package:harmony_hub/shared/infrastructure/dto/people.dart';

class Attendance extends ConsumerWidget {
  const Attendance({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<People> members = ref.watch(membersProvider);
    // final attendanceStateNotifier =
    //     ref.read(attendanceStateNotifierProvider.notifier);

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
            AttendanceFilterChip(),
            Center(
              child: switch (members) {
                AsyncData(:final value) => Text('Activity: ${value.included}'),
                AsyncError() =>
                  const Text('Oops, something unexpected happened'),
                _ => const CircularProgressIndicator(),
              },
            )
          ]),
    ));
  }
}
