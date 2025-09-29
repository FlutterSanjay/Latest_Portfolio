import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:get/get.dart';

class Skills extends StatelessWidget {
  const Skills({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = 1.sw < 800;
    final isTablet = 1.sw < 1000;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.sp : isTablet ? 40.sp : 80.sp,
        vertical: 40.sp,
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
                  text: 'Skills',
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
            margin: EdgeInsets.only(top: 10.h, bottom: 40.h),
            color: AppColors.secondaryColor,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isMobile
                  ? 1
                  : isTablet
                  ? 2
                  : 4;
              final cardWidth = constraints.maxWidth / crossAxisCount - 10.w;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 60.w,
                  mainAxisSpacing: 50.h,
                  childAspectRatio: isMobile ? 1.4 : isTablet ? 1.5 :  0.8,
                ),
                itemCount: _skillCategories.length,
                itemBuilder: (context, index) {
                  final category = _skillCategories[index];
                  return _buildSkillCard(
                    context,
                    category['title']!,
                    category['icon'] as IconData,
                    category['skills'] as List<Map<String, dynamic>>,
                    cardWidth,
                    isMobile
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(
      BuildContext context,
      String title,
      IconData icon,
      List<Map<String, dynamic>> skills,
      double maxWidth,
      bool isMobile
      ) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isMobile ? Get.width * 0.07 : 0), // Add margin,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 80.w : 40.w, vertical: isMobile ? 20.h : 40.h),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 10.r,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(icon, color: Colors.blueAccent, size: isMobile ? Get.width * 0.06 : 40.sp),
                SizedBox(width: 15.w),
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: isMobile ? Get.width * 0.05 :30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 15.h : 22.h),
            ...skills.map((skill) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skill['name']!,
                    style: TextStyle(
                      color: AppColors.textLightColor,
                      fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  LinearProgressIndicator(
                 
                    
                    value: skill['level']! / 100,
                    backgroundColor: Colors.white.withValues(alpha: 5),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      skill['level']! > 75
                          ? AppColors.secondaryColor
                          : AppColors.primaryColor,
                    ),
                      minHeight: isMobile ? 4.h : 10.h,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _skillCategories = [
    {
      'title': 'AI & Emerging',
      'icon': FontAwesomeIcons.robot, // AI-related icon
      'skills': [
        {'name': 'Large Language Models (LLMs)', 'level': 90},
        {'name': 'AI Integration in Applications', 'level': 85},

        {'name': 'Generative AI APIs', 'level': 80},
      ],
    },
    {
      'title': 'Languages',
      'icon': FontAwesomeIcons.code,
      'skills': [
        {'name': 'Dart', 'level': 90},
        {'name': 'C/C++', 'level': 75},
        {'name': 'Python', 'level': 80},
        {'name': 'JS & TS', 'level': 90},
     
      ],
    },
    {
      'title': 'Frameworks',
      'icon':
          FontAwesomeIcons.layerGroup, // architecture/framework related icon
      'skills': [
        {'name': 'Flutter', 'level': 90},
        {'name': 'State Management (GetX, BLoC)', 'level': 90},
        {'name': 'React Native', 'level': 85},
      ],
    },
    {
      'title': 'Core Concepts',
      'icon': FontAwesomeIcons.lightbulb, // skills/concepts related icon
      'skills': [
        {'name': 'Data Structures & Algorithms (DSA)', 'level': 70},
        {'name': 'Object-Oriented Programming (OOP)', 'level': 85},
        {'name': 'Design Patterns & Clean Architecture', 'level': 80},
        {'name': 'MVVM & MVM', 'level': 80},
      ],
    },

    {
      'title': 'Backend Dev',
      'icon': FontAwesomeIcons.globe, // web/backend related icon
      'skills': [
        {'name': 'Node.js & Express.js', 'level': 90},
        {'name': 'REST APIs', 'level': 90},
        {'name': 'Prisma ORM', 'level': 80},
        {'name': 'HTML & CSS', 'level': 95},
     
       
      ],
    },

    {
      'title': 'Databases',
      'icon': FontAwesomeIcons.database,
      'skills': [
        {'name': 'MySQL', 'level': 85},
        {'name': 'SQLite', 'level': 70},
        {'name': 'MongoDB', 'level': 80},
        {'name': 'Firebase', 'level': 90},
      ],
    },
    {
      'title': 'Developer Tools',
      'icon': FontAwesomeIcons.screwdriverWrench,
      'skills': [
        {'name': 'VS Code', 'level': 95},
        {'name': 'Android Studio', 'level': 85},
        {'name': 'Git & GitHub', 'level': 90},
        {'name': 'Flutter Flow', 'level': 90},
        {'name': 'Docker', 'level': 90},

      ],
    },
  ];
}