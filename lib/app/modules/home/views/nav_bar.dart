import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:portfolio/utils/app_colors.dart';

class NavBar extends GetView<HomeController> {
  const NavBar({super.key});

  Widget _navItem(String title) {
    return Obx(() {
      bool isActive = controller.activeSection.value == title;

      return MouseRegion(
        onEnter: (_) => controller.hoveredSection.value = title,
        onExit: (_) => controller.hoveredSection.value = '',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                controller.scrollToSection(title);
              },
              child: Text(
                title,
                style: TextStyle(
                  color:
                      isActive ? AppColors.secondaryColor : AppColors.textColor,
                  fontSize: 28.sp,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w200,
                ),
              ),
            ),
            // underline effect
            controller.activeSection.value != title
                ? AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: 2,
                  width:
                      (isActive || controller.hoveredSection.value == title)
                          ? 70.w
                          : 0,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                )
                : SizedBox(),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ✅ Desktop / Web layout
        return Container(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 35.w),
          color: AppColors.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portfolio',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  _navItem('Home'),
                  10.horizontalSpace,
                  _navItem('About'),
                  10.horizontalSpace,
                  _navItem('Skills'),
                  10.horizontalSpace,
                  _navItem('Experience'),
                  10.horizontalSpace,
                  _navItem('Projects'),
                  10.horizontalSpace,
                  _navItem('Education'),
                  10.horizontalSpace,
                  _navItem('Contact'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ✅ Drawer for Mobile Navigation
class MobileDrawer extends GetView<HomeController> {
  const MobileDrawer({super.key});

  Widget _drawerNavItem(String title) {
    return Obx(
      () => ListTile(
        title: Text(
          title,
          style: TextStyle(
            color:
                controller.activeSection.value == title
                    ? AppColors.secondaryColor
                    : AppColors.textColor,
            fontSize: 18.sp,
            fontWeight:
                controller.activeSection.value == title
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
        ),
        onTap: () {
          controller.scrollToSection(title);
          Get.back();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.cardColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45.r,
                  backgroundImage: AssetImage("images/profile_pic.jpeg"),
                ),
                SizedBox(width: 10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Payal Kumawat", style: TextStyle(
                        color: AppColors.secondary2Color,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600
                    )),
                    SizedBox(height: 5.h,),
                    Text("Flutter Developer", style: TextStyle(
                        color: AppColors.textLightColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600
                    )),
                  ],
                )

              ],
            ),
          ),
          _drawerNavItem('Home'),
          _drawerNavItem('About'),
          _drawerNavItem('Skills'),
          _drawerNavItem('Experience'),
          _drawerNavItem('Projects'),
          _drawerNavItem('Education'),
          _drawerNavItem('Contact'),
        ],
      ),
    );
  }
}
