import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:harmony_hub/styles/styles.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.credentials,
      required this.onPrimaryAction,
      required this.primaryActionText});

  final Credentials? credentials;
  final Future<void> Function() onPrimaryAction;

  final String primaryActionText;

  @override
  Widget build(BuildContext context) {
    var primaryText = credentials?.user.name ?? 'Guest User';
    var secondaryText = credentials?.user.email ?? 'Features are limited';

    var initials = primaryText.split(' ').map((s) => s[0]).join();
    var avatarUrl = credentials?.user.pictureUrl;

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: context.colors.scheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
              spacing: 16.0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: avatarUrl != null
                          ? NetworkImage(avatarUrl.toString())
                          : null,
                      child: avatarUrl == null ? Text(initials) : null,
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(primaryText,
                            style: kListItemSubtitleStyle.copyWith(
                                color: context.colors.scheme.onSurface,
                                fontSize:
                                    context.textStyles.titleMedium.fontSize)),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          secondaryText,
                          style: kListItemSubtitleStyle.copyWith(
                              color: context.colors.scheme.onSurfaceVariant,
                              fontSize: context.textStyles.bodyMedium.fontSize),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FilledButton(
                        onPressed: onPrimaryAction,
                        child: Text(
                          primaryActionText,
                          style: kListItemButtonLabelStyle.copyWith(
                            color: context.colors.scheme.onInverseSurface,
                            fontSize: context.textStyles.labelLarge.fontSize,
                          ),
                        ))
                  ],
                ))
              ]),
        ),
      ),
    );
  }
}

// @override
//   Widget build(BuildContext context) {
//     var user = credentials?.user.name ?? 'Logged out';
//     var email = credentials?.user.email ?? '';

//     return SizedBox(
//       width: double.infinity,
//       child: Card(
//         color: Colors.white,
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 user,
//                 style: TextStyle(
//                     fontSize: context.textStyles.titleMedium.fontSize),
//               ),
//               Text(email,
//                   style: TextStyle(
//                       fontSize: context.textStyles.bodySmall.fontSize)),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 spacing: 8,
//                 children: [
//                   FilledButton(
//                     onPressed: () async => await onPrimaryAction(),
//                     child: Text(
//                       primaryActionText,
//                     ),
//                   ),
//                   // OutlinedButton(
//                   //   onPressed: () {
//                   //     // Define the primary action here
//                   //   },
//                   //   child: const Text('Secondary Action'),
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
