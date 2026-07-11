import 'package:flutter/material.dart';
import 'package:portfolio_app/utils/colors.dart';
import 'package:portfolio_app/utils/constants.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Section Title
          FadeInDown(
            child: Text(
              'Contact Me',
              style: TextStyle(
                fontSize: isMobile ? 28 : 40,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ).createShader(const Rect.fromLTWH(0, 0, 250, 50)),
              ),
            ),
          ),
          const SizedBox(height: 10),

          FadeInDown(
            delay: const Duration(milliseconds: 200),
            child: Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 30),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Form
              Expanded(
                flex: 2,
                child: FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Card(
                    elevation: 4,
                    color: isDark ? AppColors.cardDark : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Send Me a Message',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Name Field
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Your Name',
                                hintText: 'Enter your name',
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Your Email',
                                hintText: 'Enter your email',
                                prefixIcon: const Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),

                            // Message Field
                            TextFormField(
                              controller: _messageController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                labelText: 'Your Message',
                                hintText: 'Enter your message',
                                alignLabelWithHint: true,
                                prefixIcon: const Icon(Icons.message),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your message';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _submitForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Send Message',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Contact Info
              if (!isMobile) const SizedBox(width: 30),
              if (!isMobile)
                Expanded(
                  flex: 1,
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Card(
                      elevation: 4,
                      color: isDark ? AppColors.cardDark : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contact Info',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildContactInfoItem(
                              Icons.location_on,
                              'Location',
                              AppConstants.location,
                              isDark,
                            ),
                            const SizedBox(height: 15),
                            _buildContactInfoItem(
                              Icons.email,
                              'Email',
                              AppConstants.email,
                              isDark,
                            ),
                            const SizedBox(height: 15),
                            _buildContactInfoItem(
                              Icons.phone,
                              'Phone',
                              AppConstants.phone,
                              isDark,
                            ),
                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 10),
                            Text(
                              'Follow Me',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildSocialIconButton(
                                  FontAwesomeIcons.linkedin,
                                  AppConstants.linkedin,
                                ),
                                _buildSocialIconButton(
                                  FontAwesomeIcons.github,
                                  AppConstants.github,
                                ),
                                _buildSocialIconButton(
                                  FontAwesomeIcons.envelope,
                                  'mailto:${AppConstants.email}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildContactInfoItem(IconData icon, String label, String value, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIconButton(IconData icon, String url) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(22.5),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement email sending
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message sent successfully!'),
          backgroundColor: AppColors.primary,
        ),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }
}