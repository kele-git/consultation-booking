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


class UpdateButton extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  UpdateButton({super.key});

  void _updateProfile(BuildContext context) {
    final newName = nameController.text.trim();
    final newRole = roleController.text.trim();
    final newEmail = emailController.text.trim();
    final newPhone = phoneController.text.trim();

    if (newName.isEmpty || newRole.isEmpty || newEmail.isEmpty || newPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    Provider.of<ProfileViewModel>(context, listen: false)
        .updateProfile(newName, newRole, newEmail, newPhone);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileViewModel>(context).profile;

    nameController.text = profile.name;
    roleController.text = profile.role;
    emailController.text = profile.email;
    phoneController.text = profile.phone;

    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Update Profile"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
                  TextField(controller: roleController, decoration: InputDecoration(labelText: "Role")),
                  TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
                  TextField(controller: phoneController, decoration: InputDecoration(labelText: "Phone")),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
              ElevatedButton(onPressed: () => _updateProfile(context), child: Text("Update")),
            ],
          ),
        );
      },
      child: Text("Update Profile"),
    );
  }
}
