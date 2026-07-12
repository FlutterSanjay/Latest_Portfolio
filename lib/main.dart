import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'app/translations/app_translations.dart';
import 'app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Size getDesignSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) {
      return const Size(1920, 1080);
    } else if (width >= 800) {
      return const Size(1024, 768);
    } else {
      return const Size(390, 844);
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
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: TextScaler.linear(mediaQuery.size.width < 800 ? 1.0 : 1.15),
              ),
              child: GetMaterialApp(
                translations: AppTranslations(),
                locale: const Locale('en', 'US'),
                fallbackLocale: const Locale('en', 'US'),
                title: 'Sanjay Shaw — Portfolio',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  useMaterial3: true,
                scaffoldBackgroundColor: AppColors.backgroundColor,
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primaryColor,
                  secondary: AppColors.accentCyan,
                  surface: AppColors.surfaceColor,
                  error: Color(0xFFEF4444),
                ),
                textTheme: GoogleFonts.interTextTheme(
                  Theme.of(context).textTheme.apply(
                        bodyColor: AppColors.textColor,
                        displayColor: AppColors.textColor,
                      ),
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: AppColors.navBarColor,
                  elevation: 0,
                  foregroundColor: AppColors.textColor,
                  surfaceTintColor: Colors.transparent,
                ),
                cardTheme: CardThemeData(
                  color: AppColors.cardColor,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: AppColors.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                  ),
                  hintStyle:
                      const TextStyle(color: AppColors.textMuted, fontSize: 14),
                ),
              ),
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
            ),
            );
          },
        );
      },
    );
  }
}
