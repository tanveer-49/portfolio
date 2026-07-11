import 'package:flutter/material.dart';
import 'package:portfolio_app/utils/colors.dart';
import 'package:portfolio_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int)? onPageSelected;

  const CustomDrawer({
    super.key,
    this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: Container(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppConstants.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppConstants.title,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Navigation Items
            _buildDrawerItem(
              context,
              icon: Icons.home,
              title: 'Home',
              index: 0,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.person,
              title: 'About',
              index: 1,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.code,
              title: 'Skills',
              index: 2,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.work,
              title: 'Projects',
              index: 3,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.contact_mail,
              title: 'Contact',
              index: 4,
            ),

            const Divider(),

            // Social Links
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Connect with me',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildDrawerSocialIcon(Icons.link, AppConstants.linkedin),
                      const SizedBox(width: 15),
                      _buildDrawerSocialIcon(Icons.code, AppConstants.github),
                      const SizedBox(width: 15),
                      _buildDrawerSocialIcon(Icons.email, 'mailto:${AppConstants.email}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required int index,
      }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      onTap: () {
        // Close drawer
        Navigator.pop(context);
        // Call the callback with selected index
        if (onPageSelected != null) {
          onPageSelected!(index);
        }
      },
    );
  }

  Widget _buildDrawerSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}