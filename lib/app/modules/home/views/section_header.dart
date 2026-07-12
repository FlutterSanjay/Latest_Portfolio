import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';

/// Shared public section header used across all portfolio sections.
class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = 1.sw < 800;
    return Column(
      children: [
        // Tag pill
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 30.w : 14.w,
            vertical: isMobile ? 7.h : 5.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          child: Text(
            '— $tag —',
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: isMobile ? Get.width * 0.027 : 11.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Title with gradient
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Color(0xFFF1F5F9), Color(0xFFA78BFA)],
          ).createShader(b),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? Get.width * 0.075 : 40.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Subtitle
        if (subtitle != null) ...[
          SizedBox(height: 10.h),
          Text(
            subtitle!,
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: isMobile ? Get.width * 0.031 : 14.sp,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],

        // Gradient underline
        SizedBox(height: 20.h),
        Container(
          width: 60.w,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ],
    );
  }
}
