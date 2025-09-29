import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:portfolio/utils/app_colors.dart';

import 'app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Size getDesignSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return const Size(1920, 1080); // Desktop / Web base
    } else if (width > 600) {
      return const Size(1024, 768); // Tablet base
    } else {
      return const Size(360, 800); // Mobile base
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (ctx, constraints) {
          final designSize = getDesignSize(ctx);
          return ScreenUtilInit(
            designSize: designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return GetMaterialApp(
                
              title: "Portfolio",
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  scaffoldBackgroundColor: AppColors.backgroundColor,
                  textTheme: GoogleFonts.interTextTheme(
                    Theme
                        .of(context)
                        .textTheme
                        .apply(
                      bodyColor: AppColors.textColor,
                      displayColor: AppColors.textColor,
                    ),
                  ),
                  appBarTheme: AppBarTheme(
                    backgroundColor: AppColors.backgroundColor,
                    elevation: 0,
                    foregroundColor: AppColors.textColor,
                  ),
                ),
                initialRoute: AppPages.INITIAL,
                getPages: AppPages.routes,
              );
            },
          );
        }
          );
  }
}
