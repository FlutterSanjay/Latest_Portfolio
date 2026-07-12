import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:portfolio/utils/app_colors.dart';

// ─── Desktop Navigation Bar ──────────────────────────────────────────────────
class NavBar extends GetView<HomeController> {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 60.w),
      decoration: BoxDecoration(
        color: AppColors.navBarColor.withValues(alpha: 0.95),
        border: const Border(
          bottom: BorderSide(color: AppColors.borderColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ─── Logo ───────────────────────────────────────────────────────────
          _LogoBrand(),
          // ─── Nav items ──────────────────────────────────────────────────────
          Row(
            children: [
              _navItem('Home', 'nav_home'.tr),
              _navItem('About', 'nav_about'.tr),
              _navItem('Skills', 'nav_skills'.tr),
              _navItem('Experience', 'nav_experience'.tr),
              _navItem('Projects', 'nav_projects'.tr),
              _navItem('Certificates', 'nav_certificates'.tr),
              _navItem('Education', 'nav_education'.tr),
              _navItem('Contact', 'nav_contact'.tr),
              SizedBox(width: 20.w),
              // ─── Hire me CTA ───────────────────────────────────────────────
              _HireMeButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navItem(String id, String label) {
    return Obx(() {
      final isActive = controller.activeSection.value == id;
      return MouseRegion(
        onEnter: (_) => controller.hoveredSection.value = id,
        onExit: (_) => controller.hoveredSection.value = '',
        cursor: SystemMouseCursors.click,
        child: Obx(() {
          final isHovered = controller.hoveredSection.value == id;
          return GestureDetector(
            onTap: () => controller.scrollToSection(id),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              padding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primaryColor.withValues(alpha: 0.15)
                    : isHovered
                        ? AppColors.glassColor
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                border: isActive
                    ? Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.4),
                        width: 1,
                      )
                    : null,
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive
                      ? AppColors.primaryLight
                      : isHovered
                          ? AppColors.textColor
                          : AppColors.textSecondary,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}

// ─── Logo Brand Widget ────────────────────────────────────────────────────────
class _LogoBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            'SS',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          'Sanjay Shaw',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

// ─── Hire Me Button ───────────────────────────────────────────────────────────
class _HireMeButton extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => controller.scrollToSection('Contact'),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'Hire Me',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Mobile Drawer ────────────────────────────────────────────────────────────
class MobileDrawer extends GetView<HomeController> {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * 0.75,
      backgroundColor: AppColors.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // ─── Header ─────────────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              decoration: const BoxDecoration(
                color: AppColors.surfaceColor,
                border: Border(
                  bottom: BorderSide(color: AppColors.borderColor, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'images/My_Photo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sanjay Shaw',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        ShaderMask(
                          shaderCallback: (b) =>
                              AppColors.accentGradient.createShader(b),
                          child: Text(
                            'Flutter Developer',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            // ─── Nav items ──────────────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                children: [
                  _drawerItem('Home', 'nav_home'.tr, Icons.home_rounded),
                  _drawerItem('About', 'nav_about'.tr, Icons.person_rounded),
                  _drawerItem('Skills', 'nav_skills'.tr, Icons.psychology_rounded),
                  _drawerItem('Experience', 'nav_experience'.tr, Icons.work_rounded),
                  _drawerItem('Projects', 'nav_projects'.tr, Icons.rocket_launch_rounded),
                  _drawerItem('Certificates', 'nav_certificates'.tr, Icons.workspace_premium_rounded),
                  _drawerItem('Education', 'nav_education'.tr, Icons.school_rounded),
                  _drawerItem('Contact', 'nav_contact'.tr, Icons.mail_rounded),
                ],
              ),
            ),
            // ─── Footer ─────────────────────────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: AppColors.borderColor, width: 1)),
              ),
              child: Center(
                child: Text(
                  '© 2025 Sanjay Shaw',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textMuted,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String id, String label, IconData icon) {
    return Obx(() {
      final isActive = controller.activeSection.value == id;
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            controller.scrollToSection(id);
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primaryColor.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: isActive
                  ? Border.all(
                      color: AppColors.primaryColor.withValues(alpha: 0.3))
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20.sp,
                  color: isActive
                      ? AppColors.primaryLight
                      : AppColors.textSecondary,
                ),
                SizedBox(width: 14.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive
                        ? AppColors.textColor
                        : AppColors.textSecondary,
                  ),
                ),
                if (isActive) ...[
                  const Spacer(),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }
}

