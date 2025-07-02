import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/profile_viewmodel.dart';
import 'profile_image.dart';

// Group Members 
// K Kekane, 220043566
// TA Mokgothu, 222029599
// TF Mokone, 222014234
// ST Hadebe, 222078272
// K Taaibosch, 222001440
// TP Montsho, 222034315


class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileViewModel>(context).profile;

    return Column(
      children: [
        ProfileImage(), // Uses the new profile image widget
        SizedBox(height: 10),
        Text("Name: ${profile.name}", style: TextStyle(fontSize: 18)),
        Text("Role: ${profile.role}", style: TextStyle(fontSize: 18)),
        Text("Email: ${profile.email}", style: TextStyle(fontSize: 16)),
        Text("Phone: ${profile.phone}", style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
