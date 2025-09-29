import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../controllers/home_controller.dart';

class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = 1.sw < 800;
    final isTablet = 1.sw < 1000;

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
                  text: 'Projects',
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
          // Project categories (AI, Flutter, Web, Android) - as buttons
          Wrap(
            spacing: isMobile ? 30.w :15.w,
            runSpacing: 15.h,
            alignment: WrapAlignment.center,
            children: [
              _buildCategoryButton('All', isMobile),
              _buildCategoryButton('AI', isMobile),
              _buildCategoryButton('Flutter', isMobile),
              _buildCategoryButton('Web Development', isMobile),
              _buildCategoryButton('Android', isMobile),
            ],
          ),
          SizedBox(height: isMobile ? 50.h : 70.h),
          // Projects Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : isTablet ? 2 : 3, // 1 column on mobile, 3 on desktop
              crossAxisSpacing: isMobile ? 20.w : 30.w,
              mainAxisSpacing: isMobile ? 20.h : 30.h,
              childAspectRatio: isMobile ? 0.74 : isTablet ? 0.6 : 0.5, // Adjust aspect ratio for cards
            ),
            itemCount: _projects.length,
            itemBuilder: (context, index) {
              final project = _projects[index];
              return _buildProjectCard(context, project, isMobile);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category, bool isMobile) {
    // This can be enhanced with state management to filter projects
    return ElevatedButton(
      onPressed: () {
        // Implement filtering logic here
        print('Filter by: $category');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.cardColor,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.w : 25.w, vertical: isMobile ? 10.h : 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(color: AppColors.socialIconColor, width: 1.w),
        ),
        elevation: 3,
      ),
      child: Text(
        category,
        style: TextStyle(
          color: AppColors.textColor,
          fontSize: isMobile ? Get.width * 0.028 : 25.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project, bool isMobile) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 3),
            blurRadius: 10.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
            child: Image.asset(
              project['imageUrl']!,
              fit: BoxFit.cover,
              height: isMobile ? 400.h : 600.h, // Fixed height for image
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: isMobile ? 400.h : 600.h,
                  color: AppColors.textLightColor.withValues(alpha: 2),
                  child: Center(
                    child: Text(
                      'Image Failed to Load',
                      style: TextStyle(color: AppColors.textLightColor, fontSize: 14.sp),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project['title']!,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: isMobile ? Get.width * 0.06 : 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  project['description']!,
                  style: TextStyle(
                    color: AppColors.textLightColor,
                    fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: isMobile ? 10.h : 20.h),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    onPressed: () {
                      // Open project link
                      if (project['link'] != null) {
                        Get.find<HomeController>().openUrl(project['link']!);
                      }
                    },
                    child: Text(
                      'Github Link',
                      style: TextStyle(color: AppColors.primaryColor, fontSize: isMobile ? Get.width * 0.035 : 22.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const List<Map<String, dynamic>> _projects = [
    {
      'title': 'FoodCo App',
      'description':
      'A platform that allows households to monetize their culinary skills, promote healthy eating, and celebrate local culture through shared meals.',
      'imageUrl': 'images/project.webp',
      'link': 'https://github.com/PayalKmt/foodco',
    },
    {
      'title': 'Footware Store – E-Commerce App',
      'description':
          "Developed a comprehensive e-commerce mobile application for footwear shopping with a focus on secure authentication, real-time data handling, and seamless payment integration. ",
      'imageUrl': 'images/project.webp',
      'link': 'https://github.com/FlutterSanjay/Footware_App',
    },
    {
      'title': 'Restaurant AI AssistantDuration',
      'description':
          'Developed an AI-powered restaurant chatbot with LangChain & Gemini API, created Express.js APIs, frontend UI, custom getMenu tool, and secure environment variable handling, providing dynamic menu recommendations and improved user experience',
      'imageUrl': 'images/project.webp',
      'link': 'https://github.com/FlutterSanjay/smart_restorant_chatbot',
    },

    {
      'title': 'AI Code Reviewer Project',
      'description':
          'Developed a web application that uses AI to analyze and review code snippets, providing real-time evaluation and feedback through an intuitive interface. ',
      'imageUrl': 'images/project.webp',
      'link': 'https://github.com/FlutterSanjay/Code_Reviewer',
    },
{
      'title': 'Flights-Service (Node.js Backend)',
      'description':
          'Developed the backend of a flight management system using Node.js, Express.js, and MySQL. Designed relational schemas for flights, passengers, and bookings, and implemented RESTful APIs with user authentication and real-time updates. Applied modular coding practices to ensure a scalable and maintainable architecture.',
      'imageUrl': 'images/project.webp',
      'link': 'https://github.com/FlutterSanjay/Flights-Service',
    },
    
    // Add more projects as needed
  ];

}
