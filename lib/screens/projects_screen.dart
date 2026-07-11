import 'package:flutter/material.dart';
import 'package:portfolio_app/utils/colors.dart';
import 'package:portfolio_app/utils/constants.dart';
import 'package:portfolio_app/widgets/project_card.dart';
import 'package:animate_do/animate_do.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

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
              'My Projects',
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

          // Projects Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            itemCount: AppConstants.projects.length,
            itemBuilder: (context, index) {
              return FadeInUp(
                delay: Duration(milliseconds: 200 + (index * 100)),
                child: ProjectCard(
                  project: AppConstants.projects[index],
                ),
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}