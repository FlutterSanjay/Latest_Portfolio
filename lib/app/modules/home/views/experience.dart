import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import 'section_header.dart';
import '../controllers/home_controller.dart' as import_home_controller;

class Experience extends StatelessWidget {
  const Experience({super.key});

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
            tag: 'EXPERIENCE',
            title: 'exp_title'.tr,
            subtitle: 'exp_subtitle'.tr,
          ),
          SizedBox(height: isMobile ? 48.h : 64.h),
          // Timeline
          isMobile
              ? _MobileTimeline(experiences: _experiences)
              : _DesktopTimeline(experiences: _experiences),
        ],
      ),
    );
  }

  static List<Map<String, dynamic>> get _experiences => [
    {
      'duration': '05 Jan 2025 – Present',
      'title': 'Flutter Intern',
      'company': 'Gravity Engineering Services pvt.Ltd',
      'type': 'exp_type_internship'.tr,
      'color': const Color(0xFF7C3AED),
      'desc_key': 'exp1_desc',
      'skills': [
        'Flutter',
        'Firebase (Auth, FCM, Analytics)',
        'GetX',
        'Google Sign-In',
        'Microsoft OAuth',
        'ML Kit OCR',
        'Workmanager',
        'Microsoft Clarity'
      ],
      'certificateUrl': 'https://drive.google.com/file/d/1N0efnQDBBbpkhB7VhwmmMQZ9jXpccjd5/view?usp=sharing',
    },
    {
      'duration': '09 Feb 2025 – 09 May 2025',
      'title': 'MERN Intern',
      'company': 'UptoSkills',
      'type': 'exp_type_internship'.tr,
      'color': const Color(0xFF06B6D4),
      'desc_key': 'exp2_desc',
      'skills': [
        'React',
        'TailwindCSS',
        'TanStack Query',
        'Clerk Auth',
        'Node.js',
        'Express 5',
        'MongoDB',
        'Inngest'
      ],
    },
    {
      'duration': '15 Jun 2024 – 15 Dec 2024',
      'title': 'Flutter Developer Intern',
      'company': 'Traizine Technologies',
      'type': 'exp_type_internship'.tr,
      'color': const Color(0xFFF59E0B),
      'desc_key': 'exp3_desc',
      'skills': [
        'Flutter',
        'Dart',
        'REST APIs',
        'State Management',
        'Git/GitHub',
        'UI Design'
      ],
    },
  ];
}

// ─── Desktop Timeline ─────────────────────────────────────────────────────────
class _DesktopTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> experiences;
  const _DesktopTimeline({required this.experiences});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(experiences.length, (i) {
        final exp = experiences[i];
        final isLast = i == experiences.length - 1;
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 50.w, // Space for timeline connector
                bottom: 28.h,
              ),
              child: _ExperienceCard(experience: exp, isMobile: false),
            ),
            Positioned(
              top: 0,
              bottom: isLast ? null : 0,
              left: 0,
              width: 50.w,
              child: Align(
                alignment: Alignment.topCenter,
                child: _TimelineConnector(
                  color: exp['color'] as Color,
                  isLast: isLast,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ─── Mobile Timeline ──────────────────────────────────────────────────────────
class _MobileTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> experiences;
  const _MobileTimeline({required this.experiences});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(experiences.length, (i) {
        final exp = experiences[i];
        final isLast = i == experiences.length - 1;
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 45.w, // Space for timeline connector
                bottom: 24.h,
              ),
              child: _ExperienceCard(experience: exp, isMobile: true),
            ),
            Positioned(
              top: 0,
              bottom: isLast ? null : 0,
              left: 0,
              width: 45.w,
              child: Align(
                alignment: Alignment.topCenter,
                child: _TimelineConnector(
                  color: exp['color'] as Color,
                  isLast: isLast,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ─── Timeline Connector ───────────────────────────────────────────────────────
class _TimelineConnector extends StatelessWidget {
  final Color color;
  final bool isLast;
  const _TimelineConnector({required this.color, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24.h),
        // Dot
        Container(
          width: 18.w,
          height: 18.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 7.w,
              height: 7.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    color.withValues(alpha: 0.6),
                    color.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Experience Card ──────────────────────────────────────────────────────────
class _ExperienceCard extends StatefulWidget {
  final Map<String, dynamic> experience;
  final bool isMobile;
  const _ExperienceCard({required this.experience, required this.isMobile});

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;
    final Color accent = exp['color'] as Color;
    final bool isMobile = widget.isMobile;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(isMobile ? 60.r : 24.r),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.cardHoverColor : AppColors.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _hovered
                ? accent.withValues(alpha: 0.4)
                : AppColors.borderColor,
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: type badge + duration
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 22.w : 10.w,
                    vertical: isMobile ? 5.h : 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      color: accent.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    exp['type'] as String,
                    style: TextStyle(
                      color: accent,
                      fontSize: isMobile ? Get.width * 0.027 : 11.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.textMuted,
                  size: isMobile ? Get.width * 0.03 : 12.sp,
                ),
                SizedBox(width: isMobile ? 10.w : 5.w),
                Text(
                  exp['duration'] as String,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: isMobile ? Get.width * 0.028 : 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 16.h : 16.h),

            // Role title
            Text(
              exp['title'] as String,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: isMobile ? Get.width * 0.048 : 22.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 4.h),

            // Company
            Text(
              exp['company'] as String,
              style: TextStyle(
                color: accent,
                fontSize: isMobile ? Get.width * 0.033 : 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: isMobile ? 14.h : 14.h),

            // Description
            Text(
              exp['desc_key'].toString().tr,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: isMobile ? Get.width * 0.032 : 13.sp,
                height: 1.7,
              ),
            ),
            SizedBox(height: isMobile ? 16.h : 16.h),

            // Skills used
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: (exp['skills'] as List<String>).map((s) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 18.w : 10.w,
                    vertical: isMobile ? 5.h : 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    s,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: isMobile ? Get.width * 0.026 : 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            
            if (exp['certificateUrl'] != null) ...[
              SizedBox(height: isMobile ? 24.h : 20.h),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    final controller = Get.find<import_home_controller.HomeController>();
                    controller.openUrl(exp['certificateUrl'] as String);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.open_in_new_rounded,
                        size: isMobile ? Get.width * 0.035 : 14.sp,
                        color: _hovered ? accent : AppColors.textMuted,
                      ),
                      SizedBox(width: isMobile ? 10.w : 6.w),
                      Text(
                        'exp_view_cert'.tr,
                        style: TextStyle(
                          color: _hovered ? accent : AppColors.textMuted,
                          fontSize: isMobile ? Get.width * 0.03 : 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
