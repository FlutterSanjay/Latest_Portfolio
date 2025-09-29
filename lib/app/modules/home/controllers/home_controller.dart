import 'dart:io' if (dart.library.html) 'dart:html'; // Conditional import
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

import 'package:url_launcher/url_launcher.dart';




class HomeController extends GetxController {
  //TODO: Implement HomeController
  var isDownloading = false.obs;
  var progress = 0.0.obs;

  // GlobalKeys for each section to enable scrolling
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  List<String> sliderImage = [
    'images/cer.JPG',
    'images/one.jpeg',
    'images/two.jpeg',
    'images/three.jpeg',
  ];
  // Map to easily access GlobalKeys by section name
  late Map<String, GlobalKey> selectionKeys;

  // ScrollController for the SingleChildScrollView in HomeView
  final ScrollController scrollController = ScrollController();

  // textEditingController for contact
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // for moving image up and down
  RxBool isMoveUp = true.obs;

  // animation for this image
  void startAnimation() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1600));
      isMoveUp.value = !isMoveUp.value;
    }
  }

  var hoveredSection = ''.obs;
  var activeSection = 'Home'.obs;

  @override
  void onInit() {
    super.onInit();
    selectionKeys = {
      'Home': homeKey,
      'About': aboutKey,
      'Skills': skillsKey,
      'Experience': experienceKey,
      'Projects': projectsKey,
      'Education': educationKey,
      'Contact': contactKey,
    };
    // Listen to scroll events to update the active section
    scrollController.addListener(_onScroll);
    startAnimation();
  }

  // Validation
  bool validateFields() {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        subjectController.text.trim().isEmpty ||
        messageController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        "Error",
        "Enter a valid email",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  // Send message
  Future<void> sendMessage() async {
    if (!validateFields()) return;

    await Future.delayed(const Duration(seconds: 2)); // simulate API call

    // Clear fields
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {}

  void scrollToSection(String sectionName) {
    activeSection.value = sectionName;
    final key = selectionKeys[sectionName];

    if (key != null) {
      // Ensure the widget is rendered before trying to scroll to it
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = key.currentContext;
        if (context != null) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            alignment: 0.0, // Scroll to the top of the target widget
          );
        }
      });
    }
  }

  Future<void> openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }


Future<void> downloadPdf(String url, String fileName) async {
    try {
      if (kIsWeb) {
        // For web, just open in new tab
        final anchor =
            html.AnchorElement(href: url)
              ..download = fileName
              ..target = '_blank';
        html.document.body!.append(anchor);
        anchor.click();
        anchor.remove();
      } else {
        // For mobile, use url_launcher
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        }
      }
      Get.snackbar("Success", "PDF opened");
    } catch (e) {
      Get.snackbar("Error", "Could not open PDF");
    }
  }
}
