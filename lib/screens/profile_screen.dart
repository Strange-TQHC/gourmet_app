import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          /// PROFILE HEADER
          Row(
            children: [

              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.orange.shade100,
                child: const Icon(Icons.person, size: 35),
              ),

              const SizedBox(width: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Guest User",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    user?.email ?? "No Email",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 30),

          /// OPTIONS
          profileTile(
            icon: Icons.edit,
            title: "Edit Profile",
            onTap: () {},
          ),

          profileTile(
            icon: Icons.location_on_outlined,
            title: "Addresses",
            onTap: () {},
          ),

          profileTile(
            icon: Icons.favorite_border,
            title: "Your Collections",
            onTap: () {},
          ),

          profileTile(
            icon: Icons.info_outline,
            title: "About",
            onTap: () {},
          ),

          profileTile(
            icon: Icons.feedback_outlined,
            title: "Feedback",
            onTap: () {},
          ),

          const SizedBox(height: 20),

          /// LOGOUT
          profileTile(
            icon: Icons.logout,
            title: "Logout",
            color: Colors.red,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }

  /// REUSABLE TILE
  Widget profileTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),

      leading: Icon(icon, color: color),

      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color,
        ),
      ),

      trailing: const Icon(Icons.arrow_forward_ios, size: 16),

      onTap: onTap,
    );
  }
}