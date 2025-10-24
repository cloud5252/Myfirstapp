import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final currentuser = FirebaseAuth.instance.currentUser!;
  final usercollection = FirebaseFirestore.instance.collection('users');
  //  final currentuser = FirebaseAuth.instance.currentUser!;
  File? image;
  late ImagePicker _picker;

  profileImageEditModel() {
    _loadImage();
  }

  Future<void> pickImage() async {
    _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      _saveImage(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> _saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', path);
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      image = File(imagePath);
      notifyListeners();
    }
  }

  final numbers = <int>[1, 2, 3];

  Future<void> editfield(BuildContext context, String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey.shade200,
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.black),
        ),
        content: TextField(
          onChanged: (value) {
            newValue = value;
          },
          decoration: InputDecoration(hintText: "Enter new $field"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(newValue);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
    if (newValue.trim().isNotEmpty) {
      await usercollection.doc(currentuser.email).update(
        {field: newValue},
      );
    }
  }
}
