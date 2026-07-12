import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import 'section_header.dart';

class Education extends StatelessWidget {
  const Education({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = 1.sw < 800;
    final bool isTablet = 1.sw < 1200;

    return Container(
      color: AppColors.surfaceColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.w : 80.w,
        vertical: isMobile ? 60.h : 100.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SectionHeader(
            tag: 'EDUCATION',
            title: 'edu_title'.tr,
            subtitle: 'edu_subtitle'.tr,
          ),
          SizedBox(height: isMobile ? 48.h : 64.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : isTablet ? 2 : 3,
              crossAxisSpacing: isMobile ? 20.w : 24.w,
              mainAxisSpacing: isMobile ? 20.h : 24.h,
              mainAxisExtent: isMobile ? 320.h : 360.h,
            ),
            itemCount: _educationEntries.length,
            itemBuilder: (ctx, i) {
              return _EducationCard(
                  entry: _educationEntries[i], isMobile: isMobile);
            },
          ),
        ],
      ),
    );
  }

  static List<Map<String, dynamic>> get _educationEntries => [
    {
      'year': '2022 – 2026',
      'degree': 'edu1_degree'.tr,
      'institution': 'edu1_inst'.tr,
      'desc_key': 'edu1_desc',
      'grade': '8.72 CGPA',
      'icon': Icons.school_rounded,
      'color': Color(0xFF7C3AED),
    },
    {
      'year': '2020 – 2022',
      'degree': 'edu2_degree'.tr,
      'institution': 'edu2_inst'.tr,
      'desc_key': 'edu2_desc',
      'grade': '90.2%',
      'icon': Icons.menu_book_rounded,
      'color': Color(0xFF06B6D4),
    },
    {
      'year': '2019',
      'degree': 'edu3_degree'.tr,
      'institution': 'edu3_inst'.tr,
      'desc_key': 'edu3_desc',
      'grade': '77.8%',
      'icon': Icons.star_rounded,
      'color': Color(0xFF10B981),
    },
  ];
}

// ─── Education Card ───────────────────────────────────────────────────────────
class _EducationCard extends StatefulWidget {
  final Map<String, dynamic> entry;
  final bool isMobile;
  const _EducationCard({required this.entry, required this.isMobile});

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final e = widget.entry;
    final Color accent = e['color'] as Color;
    final bool isMobile = widget.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -4.0 : 0.0, 0),
        padding: EdgeInsets.all(isMobile ? 55.r : 22.r),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.cardHoverColor : AppColors.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _hovered
                ? accent.withValues(alpha: 0.45)
                : AppColors.borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? accent.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.2),
              blurRadius: _hovered ? 24 : 8,
              offset: Offset(0, _hovered ? 10 : 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon + Year
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile ? 18.r : 10.r),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    e['icon'] as IconData,
                    color: accent,
                    size: isMobile ? Get.width * 0.055 : 22.sp,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 18.w : 10.w,
                    vertical: isMobile ? 5.h : 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                        color: accent.withValues(alpha: 0.3), width: 1),
                  ),
                  child: Text(
                    e['year'] as String,
                    style: TextStyle(
                      color: accent,
                      fontSize: isMobile ? Get.width * 0.026 : 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 20.h : 18.h),

            // Degree
            Text(
              e['degree'] as String,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: isMobile ? Get.width * 0.04 : 16.sp,
                fontWeight: FontWeight.w700,
                height: 1.3,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 4.h),

            // Institution
            Text(
              e['institution'] as String,
              style: TextStyle(
                color: accent,
                fontSize: isMobile ? Get.width * 0.032 : 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12.h),

            // Description
            Expanded(
              child: Text(
                e['desc_key'].toString().tr,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: isMobile ? Get.width * 0.031 : 12.sp,
                  height: 1.65,
                ),
              ),
            ),
            SizedBox(height: 14.h),

            // Grade chip
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 22.w : 12.w,
                vertical: isMobile ? 7.h : 5.h,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    accent.withValues(alpha: 0.2),
                    accent.withValues(alpha: 0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(8.r),
                border:
                    Border.all(color: accent.withValues(alpha: 0.3), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.grade_rounded,
                      color: accent,
                      size: isMobile ? Get.width * 0.032 : 13.sp),
                  SizedBox(width: isMobile ? 10.w : 5.w),
                  Text(
                    e['grade'] as String,
                    style: TextStyle(
                      color: accent,
                      fontSize: isMobile ? Get.width * 0.03 : 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
