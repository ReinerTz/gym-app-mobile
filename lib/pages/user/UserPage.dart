import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app_mobile/widgets/SharedDrawer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'UserController.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserController _userController = Get.put(UserController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    await _userController.getUserById('user_id');
    _nameController.text = _userController.name.value;
    _emailController.text = _userController.email.value;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery, // Ou ImageSource.camera para tirar foto
    );

    if (pickedImage != null) {
      _userController.updateUser(newAvatar: pickedImage.path);
    }
  }

  Future<void> _updateUserData() async {
    _userController.updateUser(
      newName: _nameController.text,
      newEmail: _emailController.text,
    );
    Get.snackbar('Success', 'User data updated');
    setState(() {
      _isEditing = false;
    });
  }

  Widget _buildAvatar() {
    final avatarPath = _userController.avatar.value;
    if (avatarPath.isNotEmpty) {
      final imageFile = File(avatarPath);
      if (imageFile.existsSync()) {
        return GestureDetector(
          onTap: _isEditing ? _pickImage : null,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: FileImage(imageFile),
          ),
        );
      }
    }

    return GestureDetector(
      onTap: _isEditing ? _pickImage : null,
      child: const CircleAvatar(
        radius: 40,
        child: Icon(Icons.person, size: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          if (_isEditing)
            IconButton(
              onPressed: _updateUserData,
              icon: const Icon(Icons.save),
            )
          else
            IconButton(
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              icon: const Icon(Icons.edit),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(),
            TextFormField(
              controller: _nameController,
              enabled: _isEditing,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: _emailController,
              enabled: _isEditing,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


