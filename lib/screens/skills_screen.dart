import 'package:flutter/material.dart';
import 'package:portfolio_app/utils/colors.dart';
import 'package:portfolio_app/utils/constants.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

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
              'Technical Skills',
              style: TextStyle(
                fontSize: isMobile ? 28 : 40,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ).createShader(const Rect.fromLTWH(0, 0, 300, 50)),
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

          // Skills Grid
          ...AppConstants.skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;
            return FadeInUp(
              delay: Duration(milliseconds: 200 + (index * 100)),
              child: _buildSkillCard(skill, isDark, isMobile),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSkillCard(Skill skill, bool isDark, bool isMobile) {
    return Card(
      elevation: 4,
      color: isDark ? AppColors.cardDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _getCategoryIcon(skill.category),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    skill.category,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Skill Items
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: skill.items.map((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.primary.withOpacity(0.1) : AppColors.primary.withOpacity(0.05),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 14,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.white70 : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Mobile Application Development':
        return Icons.phone_android;
      case 'Backend & Integration':
        return Icons.cloud_queue;
      case 'Programming Languages':
        return Icons.code;
      case 'Tools & Technologies':
        return Icons.build;
      case 'Databases':
        return Icons.storage;
      case 'Other Skills':
        return Icons.psychology;
      default:
        return Icons.star;
    }
  }
}