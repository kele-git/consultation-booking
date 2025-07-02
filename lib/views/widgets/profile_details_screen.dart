import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpg_assignment/views/widgets/update_button.dart';
import '../../viewmodels/profile_viewmodel.dart';
import 'package:image_picker/image_picker.dart';

// Group Members 
// K Kekane, 220043566
// TA Mokgothu, 222029599
// TF Mokone, 222014234
// ST Hadebe, 222078272
// K Taaibosch, 222001440
// TP Montsho, 222034315


class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final profile = profileViewModel.profile;

    return Scaffold(
      appBar: AppBar(title: Text("Profile Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profileViewModel.imageFile != null
                      ? FileImage(profileViewModel.imageFile!)
                      : NetworkImage(profile.image) as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _showImagePicker(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 18,
                      child: Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Name: ${profile.name}", style: TextStyle(fontSize: 20)),
            Text("Role: ${profile.role}", style: TextStyle(fontSize: 16)),
            Text("Email: ${profile.email}", style: TextStyle(fontSize: 16)),
            Text("Phone: ${profile.phone}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            UpdateButton(),
          ],
        ),
      ),
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text("Camera"),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ProfileViewModel>(context, listen: false).updateImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text("Gallery"),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ProfileViewModel>(context, listen: false).updateImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}