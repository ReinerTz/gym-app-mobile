import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app_mobile/core/routes.dart';

import '../services/AuthService.dart';

class SharedDrawer extends StatelessWidget {
  final String name;
  final String email;
  final String? avatar;

  const SharedDrawer({
    Key? key,
    required this.name,
    required this.email,
    this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newAvatar = avatar ?? name.split(" ").map<String>((word) => word.isNotEmpty ? word[0] : '').toList().join("");

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              child: Text(newAvatar),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Get.offAllNamed(Routes.HOME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              AuthService auth = AuthService();
              auth.logout();
            },
          ),
        ],
      ),
    );
  }
}
