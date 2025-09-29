import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';

class Experience extends StatelessWidget {
  const Experience({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = 1.sw < 800;

    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.h : 80.h,
        vertical: isMobile ? 40.w : 80.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Internship ',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: isMobile ? Get.width * 0.06 : 48.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Experience',
                  style: TextStyle(
                    fontSize: isMobile ? Get.width * 0.06 : 48.sp,
                    fontWeight: FontWeight.bold,
                    foreground:
                    Paint()
                      ..shader = LinearGradient(
                        colors: [
                          AppColors.secondaryColor,
                          AppColors.secondary2Color,
                        ],
                      ).createShader(Rect.fromLTWH(0, 0, 300, 100)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: isMobile ? 200.w : 400.w,
            height: isMobile ? 2.h :6.h,
            color: AppColors.secondaryColor,
            margin: EdgeInsets.only(top: 10.h, bottom: 40.h),
          ),
          // Timeline layout
          isMobile
              ? _buildMobileTimeline(_experiences, isMobile)
              : _buildDesktopTimeline(_experiences, isMobile),
        ],
      ),
    );
  }

  Widget _buildDesktopTimeline(List<Map<String, dynamic>> experiences, bool isMobile) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        final experience = experiences[index];
        bool isEven = index % 2 == 0; // For alternating left/right layout

        return IntrinsicHeight( // Ensure children take up full height for the line
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left side content
              Expanded(
                child: isEven
                    ? _buildExperienceCard(context, experience, isMobile)
                    : Container(), // Empty container for spacing
              ),
              // Timeline vertical line and dot
              Column(
                children: [
                  Container(
                    width: 5.w,
                    height: 50.h, // Line above dot
                    color: AppColors.textLightColor,
                  ),
                  Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.secondaryColor, width: 4.w),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 5.w,
                      color: AppColors.textLightColor,
                    ),
                  ),
                ],
              ),
              // Right side content
              Expanded(
                child: !isEven
                    ? _buildExperienceCard(context, experience, isMobile)
                    : Container(), // Empty container for spacing
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileTimeline(List<Map<String, dynamic>> experiences, bool isMobile) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        final experience = experiences[index];
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    width: 2,
                    height: 20, // Line above dot
                    color: AppColors.textLightColor,
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.secondaryColor, width: 3),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppColors.textLightColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _buildExperienceCard(context, experience, isMobile),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExperienceCard(BuildContext context, Map<String, dynamic> experience, bool isMobile) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h).copyWith(right: 8.w, left: 8.w),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.w : 25.w, // scales with screen width
        vertical: isMobile ? 15.h : 25.h,   // scales with screen height
      ),
      height: isMobile ? 390.h : 450.h,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 4),
            blurRadius: 10.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile? 30.w : 12.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 5),
              borderRadius: BorderRadius.circular(7.r),
            ),
            child: Text(
              experience['duration']!,
              style: TextStyle(
                backgroundColor: AppColors.primaryColor,
                color: AppColors.textColor,
                fontSize: isMobile ? Get.width * 0.035 : 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            experience['title']!,
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: isMobile ? Get.width * 0.05 : 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            experience['company']!,
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: isMobile ? Get.width * 0.03 : 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            experience['description']!,
            style: TextStyle(
              color: AppColors.textLightColor,
              fontSize: isMobile ? Get.width * 0.035 : 25.sp,
            ),
          ),
        ],
      ),
    );
  }

  static const List<Map<String, dynamic>> _experiences = [
    {
      'duration': '09th Feb - 09th May 2025',
      'title': 'MERN Intern',
      'company': 'UptoSkills',
      'description':
          'During my internship, I worked on full-stack development using the MERN stack (MongoDB, Express.js, React.js, Node.js). I built responsive UIs with React.js and Tailwind CSS, designed MongoDB schemas, implemented RESTful APIs with authentication, and enabled real-time updates.',
    },
    {
      'duration': '17 June - 29 July 2024',
      'title': 'Flutter Developer Intern',
      'company': 'Triazine Software Private Limited',
      'description':
      'Developed and maintained Flutter applications, focusing on UI/UX improvements and performance optimization. Worked closely with senior developers to implement new features and debug existing codebases. Gained hands-on experience in mobile app development lifecycle.',
    },
    // Add more experiences as needed
  ];

}
