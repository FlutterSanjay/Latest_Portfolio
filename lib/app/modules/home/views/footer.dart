import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import '../../../../utils/app_colors.dart';

class Footer extends GetView<HomeController> {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = 1.sw < 800;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        border: Border(
          top: BorderSide(color: AppColors.borderColor, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.w : 80.w,
        vertical: isMobile ? 48.h : 64.h,
      ),
      child: Column(
        children: [
          // Top content
          isMobile ? _mobileContent() : _desktopContent(),
          SizedBox(height: isMobile ? 40.h : 48.h),

          // Divider with gradient
          Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.borderBright,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          SizedBox(height: isMobile ? 24.h : 28.h),

          // Bottom bar
          isMobile ? _mobileBottom() : _desktopBottom(),
        ],
      ),
    );
  }

  // ─── Desktop layout ──────────────────────────────────────────────────────────
  Widget _desktopContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand + bio
        Expanded(flex: 3, child: _brandSection()),
        SizedBox(width: 60.w),
        // Quick links
        Expanded(flex: 2, child: _quickLinks()),
        SizedBox(width: 60.w),
        // Contact info
        Expanded(flex: 2, child: _footerContact()),
      ],
    );
  }

  Widget _desktopBottom() {
    return Row(
      children: [
        Text(
          '© 2025 Sanjay Shaw. All rights reserved.',
          style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp),
        ),
        const Spacer(),
        Text(
          'Built with Flutter ❤️',
          style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp),
        ),
      ],
    );
  }

  // ─── Mobile layout ───────────────────────────────────────────────────────────
  Widget _mobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _brandSection(),
        SizedBox(height: 36.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _quickLinks()),
            SizedBox(width: 20.w),
            Expanded(child: _footerContact()),
          ],
        ),
      ],
    );
  }

  Widget _mobileBottom() {
    return Column(
      children: [
        Text(
          '© 2025 Sanjay Shaw. All rights reserved.',
          style: TextStyle(
              color: AppColors.textMuted, fontSize: Get.width * 0.028),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6.h),
        Text(
          'Built with Flutter ❤️',
          style: TextStyle(
              color: AppColors.textMuted, fontSize: Get.width * 0.026),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ─── Brand Section ────────────────────────────────────────────────────────────
  Widget _brandSection() {
    final bool isMobile = 1.sw < 800;
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Logo
        ShaderMask(
          shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
          child: Text(
            'Sanjay Shaw',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? Get.width * 0.055 : 22.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'Flutter Developer & Full Stack Engineer passionate about building elegant digital experiences.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? Get.width * 0.031 : 13.sp,
            height: 1.7,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: 20.h),
        // Social icons row
        Row(
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _socialBtn(
              FontAwesomeIcons.linkedinIn,
              'https://www.linkedin.com/in/sanjay-shaw-6a70a7178/',
              const Color(0xFF0A66C2),
              isMobile,
            ),
            SizedBox(width: isMobile ? 20.w : 10.w),
            _socialBtn(
              FontAwesomeIcons.github,
              'https://github.com/FlutterSanjay',
              AppColors.textSecondary,
              isMobile,
            ),
            SizedBox(width: isMobile ? 20.w : 10.w),
            _socialBtn(
              FontAwesomeIcons.envelope,
              'mailto:sanjayshaw80138@gmail.com',
              AppColors.accentCyan,
              isMobile,
            ),
            SizedBox(width: isMobile ? 20.w : 10.w),
            _socialBtn(
              FontAwesomeIcons.code,
              'https://leetcode.com/u/sanjayshaw80138/',
              const Color(0xFFFFA116),
              isMobile,
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialBtn(
      IconData icon, String url, Color color, bool isMobile) {
    return GestureDetector(
      onTap: () => controller.openUrl(url),
      child: Container(
        width: isMobile ? Get.width * 0.085 : 36.w,
        height: isMobile ? Get.width * 0.085 : 36.w,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
          border:
              Border.all(color: color.withValues(alpha: 0.25), width: 1),
        ),
        child: Center(
          child: FaIcon(
            icon,
            color: color,
            size: isMobile ? Get.width * 0.038 : 15.sp,
          ),
        ),
      ),
    );
  }

  // ─── Quick Links ──────────────────────────────────────────────────────────────
  Widget _quickLinks() {
    final bool isMobile = 1.sw < 800;
    const links = [
      'Home', 'About', 'Skills', 'Experience',
      'Projects', 'Certificates', 'Education', 'Contact'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: isMobile ? Get.width * 0.035 : 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          width: isMobile ? 40.w : 32.w,
          height: 2,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        SizedBox(height: 16.h),
        ...links.map((l) => _quickLink(l, isMobile)),
      ],
    );
  }

  Widget _quickLink(String title, bool isMobile) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 8.h : 6.h),
      child: GestureDetector(
        onTap: () => controller.scrollToSection(title),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? Get.width * 0.03 : 12.sp,
          ),
        ),
      ),
    );
  }

  // ─── Contact Info ─────────────────────────────────────────────────────────────
  Widget _footerContact() {
    final bool isMobile = 1.sw < 800;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: isMobile ? Get.width * 0.035 : 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          width: isMobile ? 40.w : 32.w,
          height: 2,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        SizedBox(height: 16.h),
        _infoRow(
            Icons.email_rounded, 'sanjayshaw80138@gmail.com', isMobile),
        SizedBox(height: isMobile ? 10.h : 8.h),
        _infoRow(Icons.phone_rounded, '+91 80138 12268', isMobile),
        SizedBox(height: isMobile ? 10.h : 8.h),
        _infoRow(
            Icons.location_on_rounded, 'Kolkata, India', isMobile),
        SizedBox(height: isMobile ? 16.h : 14.h),
        // Languages
        Text(
          'Languages',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: isMobile ? Get.width * 0.03 : 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 6.h,
          children: [
            _languageChip('English', const Locale('en', 'US'), isMobile),
            _languageChip('Hindi', const Locale('hi', 'IN'), isMobile),
            _languageChip('Bengali', const Locale('bn', 'IN'), isMobile),
          ],
        ),
      ],
    );
  }

  Widget _languageChip(String lang, Locale locale, bool isMobile) {
    return InkWell(
      onTap: () => Get.updateLocale(locale),
      borderRadius: BorderRadius.circular(4.r),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.w : 8.w, vertical: isMobile ? 4.h : 3.h),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Text(
          lang,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? Get.width * 0.026 : 10.sp,
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String value, bool isMobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            color: AppColors.primaryLight,
            size: isMobile ? Get.width * 0.032 : 12.sp),
        SizedBox(width: isMobile ? 12.w : 6.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: isMobile ? Get.width * 0.028 : 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}
