import 'package:flutter/material.dart';
import 'package:harmony_hub/session_view.dart';

class Attendance extends StatelessWidget {
  const Attendance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.all(8),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text('Attendance Page'),
        SessionView(),
      ]),
    ));
  }
}
