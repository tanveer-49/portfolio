import 'package:flutter/material.dart';
import 'package:portfolio_app/screens/about_screen.dart';
import 'package:portfolio_app/screens/contact_screen.dart';
import 'package:portfolio_app/screens/projects_screen.dart';
import 'package:portfolio_app/screens/skills_screen.dart';
import 'package:portfolio_app/utils/colors.dart';
import 'package:portfolio_app/utils/constants.dart';
import 'package:portfolio_app/widgets/drawer_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool)? onThemeToggle;
  final ThemeMode? currentTheme;

  const HomeScreen({
    super.key,
    this.onThemeToggle,
    this.currentTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _isDark = widget.currentTheme == ThemeMode.dark;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      // FIXED: Pass page controller to drawer
      drawer: CustomDrawer(
        onPageSelected: (index) {
          _navigateToPage(index);
        },
      ),
      appBar: AppBar(
        title: Text(
          AppConstants.name,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 16 : 20,
          ),
        ),
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        elevation: 0,
        actions: [
          // Desktop Navigation
          if (!isMobile)
            Row(
              children: [
                _buildNavButton('Home', 0),
                _buildNavButton('About', 1),
                _buildNavButton('Skills', 2),
                _buildNavButton('Projects', 3),
                _buildNavButton('Contact', 4),
              ],
            ),

          // FIXED: Dark Mode Toggle
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
            onPressed: () {
              setState(() {
                _isDark = !_isDark;
              });
              // Call parent to change theme
              if (widget.onThemeToggle != null) {
                widget.onThemeToggle!(_isDark);
              }
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: const [
          HomeContent(),
          AboutScreen(),
          SkillsScreen(),
          ProjectsScreen(),
          ContactScreen(),
        ],
      ),
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _navigateToPage(index);
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.code), label: 'Skills'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Contact'),
        ],
      )
          : null,
    );
  }

  // FIXED: Navigation method
  void _navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Widget _buildNavButton(String label, int index) {
    final isSelected = _selectedIndex == index;
    return TextButton(
      onPressed: () {
        _navigateToPage(index);
      },
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primary : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}

// ============= HOME CONTENT =============
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Image
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        width: isMobile ? 150 : 200,
                        height: isMobile ? 150 : 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.primaryGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.jpg',
                            fit: BoxFit.cover,
                            width: isMobile ? 150 : 200,
                            height: isMobile ? 150 : 200,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Name
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        AppConstants.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 30 : 46,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                            ).createShader(const Rect.fromLTWH(0, 0, 300, 100)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 300),
                      child: Text(
                        AppConstants.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 22,
                          color: isDark ? Colors.white70 : AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle Badge
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 400),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          AppConstants.subtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Social Icons
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 500),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildSocialIcon(FontAwesomeIcons.linkedin, AppConstants.linkedin),
                          _buildSocialIcon(FontAwesomeIcons.github, AppConstants.github),
                          _buildSocialIcon(FontAwesomeIcons.envelope, 'mailto:${AppConstants.email}'),
                          _buildSocialIcon(FontAwesomeIcons.phone, 'tel:${AppConstants.phone}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),

                    // Buttons
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 600),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: isMobile ? 150 : 180,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 4,
                              ),
                              icon: const Icon(
                                Icons.download,
                                size: 18,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Download CV',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isMobile ? 150 : 180,
                            height: 50,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(color: AppColors.primary, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              icon: Icon(
                                Icons.email,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              label: Text(
                                'Contact Me',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}