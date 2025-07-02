import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/profile_viewmodel.dart';

// Group Members 
// K Kekane, 220043566
// TA Mokgothu, 222029599
// TF Mokone, 222014234
// ST Hadebe, 222078272
// K Taaibosch, 222001440
// TP Montsho, 222034315


class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileViewModel>(context).profile;

    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(profile.image), // Loads online image
      onBackgroundImageError:
          (_, __) =>
              Icon(Icons.person, size: 50), // Fallback icon if image fails
    );
  }
}
