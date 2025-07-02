import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/profile.dart';

class ProfileViewModel with ChangeNotifier {
  Profile _profile = Profile(
    name: "Tokollo",
    role: "Student",
    email: "Mokone@gmail.com",
    phone: "08756255551",
    image: "https://www.bing.com/th?id=OIP.8fO6oTSulgfzMfmpIiJ8WQHaHa&w=104&h=104&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2",
  );

  File? _imageFile;

  Profile get profile => _profile;
  File? get imageFile => _imageFile;

  void updateProfile(String name, String role, String email, String phone) {
    _profile = Profile(
      name: name,
      role: role,
      email: email,
      phone: phone,
      image: _profile.image,
    );
    notifyListeners();
  }

  Future<void> updateImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}