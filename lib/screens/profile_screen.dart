import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../themes/app_colors.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'edit_profile_screen.dart';
import '../themes/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 10,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          /// PROFILE HEADER
          Row(
            children: [

              CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.tertiary,
                child: const Icon(
                    Icons.person,
                    size: 35,
                    color: AppColors.textDark,
                ),
              ),

              const SizedBox(width: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


              Text(
                userProvider.name,
                style: const TextStyle(
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EditProfileScreen(),
                ),
              );
            },
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