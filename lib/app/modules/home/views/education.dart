import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';

class Education extends StatelessWidget {
  const Education({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = 1.sw < 800;
    bool isTablet = 1.sw < 1000;

    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.w : 80.w,
        vertical: isMobile ? 40.h : 80.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'My ',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: isMobile ? Get.width * 0.06 : 48.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Education',
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
            width: isMobile ? 150.w : 190.w,
            height: isMobile ? 2.h : 6.h,
            color: AppColors.secondaryColor,
            margin: EdgeInsets.only(top: 10.h, bottom: 40.h),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : isTablet ? 2 : 3, // 1 column on mobile, 3 on desktop
              crossAxisSpacing: isMobile ? 20.w : 30.w,
              mainAxisSpacing: isMobile ? 20.h : 30.h,
              childAspectRatio: isMobile ? 1.2 : isTablet ? 1.2 : 0.9, // Adjust aspect ratio for cards
            ),
            itemCount: _educationEntries.length,
            itemBuilder: (context, index) {
              final entry = _educationEntries[index];
              return _buildEducationCard(context, entry, isMobile);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(BuildContext context, Map<String, dynamic> entry, bool isMobile) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 35.w : 25.w, vertical: 25.h),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 5),
            blurRadius: 10.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 5),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Text(
              entry['year']!,
              style: TextStyle(
                backgroundColor: AppColors.primaryColor,
                color: AppColors.textColor,
                fontSize: isMobile ? Get.width * 0.035 : 30.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            entry['degree']!,
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: isMobile ? Get.width * 0.06 :38.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            entry['institution']!,
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: isMobile ? Get.width * 0.05 : 30.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            entry['description']!,
            style: TextStyle(
              color: AppColors.textLightColor,
              fontSize: isMobile ? Get.width * 0.035 : 25.sp,
            ),
          ),
          if (entry['grade'] != null) ...[
            SizedBox(height: 20.h),
            Text(
              entry['grade']!,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static const List<Map<String, dynamic>> _educationEntries = [
    {
      'year': '2022 - 2026',
      'degree': 'Bachelor of Technology - Computer Science and Engineering',
      'institution': 'Central University of Haryana',
      'description':
      'Pursuing my degree with a focus on software development and advanced programming concepts.',
      'grade': 'CGPA: 8.72',
    },
    {
      'year': '2020 - 2022',
      'degree': 'Senior Secondary (XII)',
      'institution': 'Ideal School ,Kalyani (W.B)',
      'description':
      'Completed my senior secondary education with a focus on science subjects.',
      'grade': 'Percentage: 90.2%',
    },
    {
      'year': '2019',
      'degree': 'Secondary Examination (X)',
      'institution': 'Air Force School, Palta',
      'description':
          'Completed my secondary education.',
      'grade': 'Percentage: 77.8%',
    },
  ];

}
