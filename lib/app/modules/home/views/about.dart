import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../controllers/home_controller.dart';
import 'section_header.dart';

class About extends GetView<HomeController> {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = 1.sw < 800;

    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.w : 80.w,
        vertical: isMobile ? 60.h : 100.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SectionHeader(
            tag: 'ABOUT',
            title: 'about_title'.tr,
            subtitle: 'about_subtitle'.tr,
          ),
          SizedBox(height: isMobile ? 48.h : 64.h),
          isMobile ? _mobileLayout(context) : _desktopLayout(context),
        ],
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile image
        Expanded(flex: 2, child: _profileImage(context)),
        SizedBox(width: 60.w),
        // Text content
        Expanded(flex: 3, child: _textContent(context)),
      ],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        _profileImage(context),
        SizedBox(height: 40.h),
        _textContent(context),
      ],
    );
  }

  Widget _profileImage(BuildContext context) {
    final bool isMobile = 1.sw < 800;
    final double size = isMobile
        ? MediaQuery.of(context).size.width * 0.68
        : 300.w;

    return Center(
      child: Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 1800),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(
                top: controller.isMoveUp.value ? 0 : 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glow shadow
                Container(
                  width: size + 20,
                  height: size + 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            AppColors.primaryColor.withValues(alpha: 0.25),
                        blurRadius: 40,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                ),
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(isMobile ? 24.r : 20.r),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(isMobile ? 24.r : 20.r),
                      gradient: AppColors.subtleGradient,
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(isMobile ? 22.r : 18.r),
                      child: Image.asset(
                        'images/My_Photo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.cardColor,
                          child: const Icon(
                            Icons.person_rounded,
                            color: AppColors.textMuted,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _textContent(BuildContext context) {
    final bool isMobile = 1.sw < 800;

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Sub-heading
        ShaderMask(
          shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
          child: Text(
            'about_heading'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? Get.width * 0.045 : 22.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        SizedBox(height: 16.h),

        // Bio paragraphs
        Text(
          'about_p1'.tr,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? Get.width * 0.033 : 15.sp,
            height: 1.8,
            letterSpacing: 0.2,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: 14.h),
        Text(
          'about_p2'.tr,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? Get.width * 0.033 : 15.sp,
            height: 1.8,
            letterSpacing: 0.2,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: 36.h),

        // Stat cards
        Wrap(
          spacing: isMobile ? 16.w : 16.w,
          runSpacing: 16.h,
          alignment:
              isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _statCard('4+', 'stat_projects'.tr, Icons.rocket_launch_rounded),
            _statCard('1+ Yrs', 'stat_internships'.tr, Icons.work_rounded),
            _statCard('7', 'stat_certificates'.tr, Icons.workspace_premium_rounded),
          ],
        ),
        SizedBox(height: 36.h),

        // Skills tags row
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          alignment:
              isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _tag('Flutter'),
            _tag('React.js'),
            _tag('Node.js'),
            _tag('Firebase'),
            _tag('MongoDB'),
            _tag('GetX'),
            _tag('LLMs'),
          ],
        ),
      ],
    );
  }

  Widget _statCard(String count, String label, IconData icon) {
    final bool isMobile = 1.sw < 800;
    return Container(
      width: isMobile ? (Get.width - 80) / 3 : 140.w,
      padding: EdgeInsets.all(isMobile ? 16.r : 20.r),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon,
              color: AppColors.primaryLight,
              size: isMobile ? Get.width * 0.06 : 24.sp),
          SizedBox(height: 8.h),
          ShaderMask(
            shaderCallback: (b) =>
                AppColors.primaryGradient.createShader(b),
            child: Text(
              count,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? Get.width * 0.055 : 28.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: isMobile ? Get.width * 0.027 : 12.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _tag(String label) {
    final bool isMobile = 1.sw < 800;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 22.w : 12.w,
        vertical: isMobile ? 8.h : 6.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.primaryLight,
          fontSize: isMobile ? Get.width * 0.028 : 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

