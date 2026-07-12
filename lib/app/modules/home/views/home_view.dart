import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:portfolio/app/modules/home/views/certificate.dart';
import 'package:portfolio/app/modules/home/views/contact_me.dart';
import 'package:portfolio/app/modules/home/views/projects.dart';
import 'package:portfolio/app/modules/home/views/skills.dart';
import '../../../../utils/app_colors.dart';
import '../controllers/home_controller.dart';
import 'about.dart';
import 'education.dart';
import 'experience.dart';
import 'footer.dart';
import 'nav_bar.dart';
import 'chatbot_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = 1.sw < 800;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.navBarColor,
              elevation: 0,
              titleSpacing: 20,
              title: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (b) =>
                        AppColors.primaryGradient.createShader(b),
                    child: Text(
                      'SS',
                      style: TextStyle(
                        fontSize: Get.width * 0.055,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Sanjay Shaw',
                    style: TextStyle(
                      fontSize: Get.width * 0.038,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              actions: [
                Builder(
                  builder: (ctx) => IconButton(
                    icon: Icon(
                      Icons.menu_rounded,
                      color: AppColors.textColor,
                      size: Get.width * 0.065,
                    ),
                    onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  height: 1,
                  color: AppColors.borderColor,
                ),
              ),
            )
          : null,
      endDrawer: isMobile ? const MobileDrawer() : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                // Desktop NavBar
                if (!isMobile) const NavBar(),

                // ── Hero Section ─────────────────────────────────────────────────
                _HeroSection(isMobile: isMobile),

                // ── About ────────────────────────────────────────────────────────
                SizedBox(key: controller.aboutKey, child: const About()),

                // ── Skills ───────────────────────────────────────────────────────
                SizedBox(key: controller.skillsKey, child: const Skills()),

                // ── Experience ───────────────────────────────────────────────────
                SizedBox(
                    key: controller.experienceKey, child: const Experience()),

                // ── Projects ─────────────────────────────────────────────────────
                SizedBox(key: controller.projectsKey, child: const Projects()),

                // ── Certifications ───────────────────────────────────────────────
                SizedBox(
                  key: controller.certificatesKey,
                  child: const Certifications(),
                ),

                // ── Education ────────────────────────────────────────────────────
                SizedBox(key: controller.educationKey, child: const Education()),

                // ── Contact ──────────────────────────────────────────────────────
                SizedBox(key: controller.contactKey, child: const ContactMe()),

                // ── Footer ───────────────────────────────────────────────────────
                const Footer(),
              ],
            ),
          ),
          const SafeArea(child: ChatbotWidget()),
        ],
      ),
    );
  }
}

// ─── Hero Section ─────────────────────────────────────────────────────────────
class _HeroSection extends GetView<HomeController> {
  final bool isMobile;
  const _HeroSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.homeKey,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        // Subtle violet tint gradient
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0E0818),
            AppColors.backgroundColor,
            AppColors.backgroundColor,
          ],
          stops: const [0.0, 0.4, 1.0],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Background ambient orbs ─────────────────────────────────────
          Positioned(
            top: isMobile ? -60 : -120,
            left: isMobile ? -60 : -80,
            child: _ambientOrb(
              isMobile ? 250 : 420,
              AppColors.primaryColor,
              0.10,
            ),
          ),
          Positioned(
            bottom: isMobile ? -60 : -80,
            right: isMobile ? -40 : 60,
            child: _ambientOrb(
              isMobile ? 180 : 320,
              AppColors.accentCyan,
              0.07,
            ),
          ),
          // ── Main content ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24.w : 80.w,
              vertical: isMobile ? 48.h : 80.h,
            ),
            child: isMobile
                ? _mobileHero(context)
                : _desktopHero(context),
          ),
        ],
      ),
    );
  }

  Widget _ambientOrb(double size, Color color, double opacity) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  // ─── Desktop layout ─────────────────────────────────────────────────────────
  Widget _desktopHero(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left — Text content
        Expanded(flex: 5, child: _textContent(context)),
        SizedBox(width: 60.w),
        // Right — Image
        Expanded(flex: 4, child: _imagePanel(context)),
      ],
    );
  }

  // ─── Mobile layout ──────────────────────────────────────────────────────────
  Widget _mobileHero(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _textContent(context),
        SizedBox(height: 48.h),
        _imagePanel(context),
      ],
    );
  }

  // ─── Text content (left) ────────────────────────────────────────────────────
  Widget _textContent(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // "Available for work" badge
        _availableBadge(),
        SizedBox(height: isMobile ? 20.h : 24.h),

        // Greeting
        Text(
          "Hello, I'm",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? Get.width * 0.042 : 20.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: 8.h),

        // Name with gradient
        _gradientName(),
        SizedBox(height: 20.h),

        // Animated typewriter role
        _typewriterRole(),
        SizedBox(height: 24.h),

        // Description
        Text(
          'hero_desc'.tr,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? Get.width * 0.034 : 16.sp,
            height: 1.7,
            letterSpacing: 0.2,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: isMobile ? 36.h : 40.h),

        // CTA Buttons
        _ctaButtons(),
        SizedBox(height: isMobile ? 36.h : 40.h),

        // Social icons
        _socialRow(),
      ],
    );
  }

  Widget _availableBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 30.w : 14.w,
        vertical: isMobile ? 8.h : 7.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentGreen.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: AppColors.accentGreen.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isMobile ? 7 : 7,
            height: isMobile ? 7 : 7,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentGreen,
            ),
          ),
          SizedBox(width: isMobile ? 20.w : 8.w),
          Text(
            'available'.tr,
            style: TextStyle(
              color: AppColors.accentGreen,
              fontSize: isMobile ? Get.width * 0.028 : 13.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradientName() {
    return ShaderMask(
      shaderCallback: (bounds) =>
          const LinearGradient(
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFA78BFA),
              Color(0xFF7C3AED),
            ],
          ).createShader(bounds),
      child: Text(
        'Sanjay Shaw',
        style: TextStyle(
          fontSize: isMobile ? Get.width * 0.11 : 58.sp,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -1,
          height: 1.05,
        ),
        textAlign: isMobile ? TextAlign.center : TextAlign.left,
      ),
    );
  }

  Widget _typewriterRole() {
    return Row(
      mainAxisAlignment:
          isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
          child: Text(
            '// ',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? Get.width * 0.05 : 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        DefaultTextStyle(
          style: TextStyle(
            fontSize: isMobile ? Get.width * 0.05 : 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.accentCyan,
            letterSpacing: 0.5,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            pause: const Duration(milliseconds: 400),
            animatedTexts: [
              TyperAnimatedText(
                'role_flutter'.tr,
                speed: const Duration(milliseconds: 80),
              ),
              TyperAnimatedText(
                'role_backend'.tr,
                speed: const Duration(milliseconds: 80),
              ),
              TyperAnimatedText(
                'role_fullstack'.tr,
                speed: const Duration(milliseconds: 80),
              ),
              TyperAnimatedText(
                'role_mobile'.tr,
                speed: const Duration(milliseconds: 80),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ctaButtons() {
    return Wrap(
      spacing: isMobile ? 40.w : 16.w,
      runSpacing: 14.h,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        // Primary — Download Resume
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => controller.downloadPdf(
              'https://drive.google.com/uc?export=download&id=1B0yyc7t47EYZAl7nIqKWT4X9j3YymI1F',
              'Sanjay_Shaw_Resume',
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 30.w : 24.w,
                vertical: isMobile ? 14.h : 14.h,
              ),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.download_rounded,
                    color: Colors.white,
                    size: isMobile ? Get.width * 0.04 : 18.sp,
                  ),
                  SizedBox(width: isMobile ? 16.w : 8.w),
                  Text(
                    'download_resume'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? Get.width * 0.033 : 15.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Secondary — View Projects
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => controller.scrollToSection('Projects'),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 30.w : 24.w,
                vertical: isMobile ? 14.h : 14.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.glassColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.borderBright,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.rocket_launch_rounded,
                    color: AppColors.textSecondary,
                    size: isMobile ? Get.width * 0.04 : 18.sp,
                  ),
                  SizedBox(width: isMobile ? 16.w : 8.w),
                  Text(
                    'View Projects',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: isMobile ? Get.width * 0.033 : 15.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialRow() {
    return Row(
      mainAxisAlignment:
          isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        _socialIcon(
          FontAwesomeIcons.linkedinIn,
          'https://www.linkedin.com/in/sanjay-shaw-6a70a7178/',
          const Color(0xFF0A66C2),
        ),
        SizedBox(width: isMobile ? 30.w : 14.w),
        _socialIcon(
          FontAwesomeIcons.github,
          'https://github.com/FlutterSanjay',
          AppColors.textSecondary,
        ),
        SizedBox(width: isMobile ? 30.w : 14.w),
        _socialIcon(
          FontAwesomeIcons.envelope,
          'mailto:sanjayshaw80138@gmail.com',
          AppColors.accentCyan,
        ),
        SizedBox(width: isMobile ? 30.w : 14.w),
        _socialIcon(
          FontAwesomeIcons.code,
          'https://leetcode.com/u/sanjayshaw80138/',
          const Color(0xFFFFA116),
        ),
      ],
    );
  }

  Widget _socialIcon(FaIconData icon, String url, Color color) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => controller.openUrl(url),
        child: Container(
          width: isMobile ? Get.width * 0.1 : 44.w,
          height: isMobile ? Get.width * 0.1 : 44.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: color.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          child: Center(
            child: FaIcon(
              icon,
              color: color,
              size: isMobile ? Get.width * 0.045 : 18.sp,
            ),
          ),
        ),
      ),
    );
  }

  // ─── Image panel (right) ─────────────────────────────────────────────────────
  Widget _imagePanel(BuildContext context) {
    return Center(
      child: Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 1800),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(
              top: controller.isMoveUp.value ? 0 : 18,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow ring
                Container(
                  width: isMobile
                      ? MediaQuery.of(context).size.width * 0.78
                      : 440.w,
                  height: isMobile
                      ? MediaQuery.of(context).size.width * 0.52
                      : 320.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withValues(alpha: 0.25),
                        blurRadius: 40,
                        spreadRadius: 4,
                      ),
                      BoxShadow(
                        color: AppColors.accentCyan.withValues(alpha: 0.12),
                        blurRadius: 60,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                ),
                // Image carousel
                ClipRRect(
                  borderRadius: BorderRadius.circular(22.r),
                  child: Container(
                    width: isMobile
                        ? MediaQuery.of(context).size.width * 0.78
                        : 440.w,
                    height: isMobile
                        ? MediaQuery.of(context).size.width * 0.52
                        : 320.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.35),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: double.infinity,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.easeInOutCubic,
                        viewportFraction: 1.0,
                      ),
                      items: controller.sliderImage.map((img) {
                        return Image.asset(
                          img,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.cardColor,
                            child: const Center(
                              child: Icon(
                                Icons.image_rounded,
                                color: AppColors.textMuted,
                                size: 40,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // Tech badge overlays
                Positioned(
                  top: isMobile ? 10 : 16,
                  right: isMobile ? 10 : 16,
                  child: _techBadge('Flutter', const Color(0xFF54C5F8)),
                ),
                Positioned(
                  bottom: isMobile ? 10 : 16,
                  left: isMobile ? 10 : 16,
                  child: _techBadge('Node.js', const Color(0xFF6DB33F)),
                ),
              ],
            ),
          )),
    );
  }

  Widget _techBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.w : 10.w,
        vertical: isMobile ? 6.h : 5.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardColor.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: isMobile ? 12.w : 6.w),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: isMobile ? Get.width * 0.028 : 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
