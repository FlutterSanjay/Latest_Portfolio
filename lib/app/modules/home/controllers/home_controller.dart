import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class HomeController extends GetxController {
  var isDownloading = false.obs;
  var progress = 0.0.obs;

  // ─── GlobalKeys for scroll-to-section ────────────────────────────────────────
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();
  final GlobalKey certificatesKey = GlobalKey();

  List<String> sliderImage = [
    'images/cer.JPG',
    'images/one.jpeg',
    'images/two.jpeg',
    'images/three.jpeg',
  ];

  late Map<String, GlobalKey> selectionKeys;

  final ScrollController scrollController = ScrollController();

  // ─── Contact form controllers ─────────────────────────────────────────────────
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // ─── Reactive state ──────────────────────────────────────────────────────────
  RxBool isMoveUp = true.obs;
  var hoveredSection = ''.obs;
  var activeSection = 'Home'.obs;
  var selectedCategory = 'All'.obs; // Project category filter
  var isSendingMessage = false.obs;

  // ─── GitHub repos ─────────────────────────────────────────────────────────────
  var githubRepos = <Map<String, dynamic>>[].obs;
  var isLoadingRepos = false.obs;
  var showAllProjects = false.obs;
  var reposError = ''.obs;

  static const String _githubUsername = 'FlutterSanjay';

  // ─── Float animation ──────────────────────────────────────────────────────────
  void startAnimation() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 1800));
      isMoveUp.value = !isMoveUp.value;
    }
  }

  // ─── Ordered section list for scroll detection ────────────────────────────────
  static const List<String> _sectionOrder = [
    'Home',
    'About',
    'Skills',
    'Experience',
    'Projects',
    'Certificates',
    'Education',
    'Contact',
  ];

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
      'Certificates': certificatesKey,
    };
    scrollController.addListener(_onScroll);
    startAnimation();
  }

  // ─── Scroll listener: auto-update active section ──────────────────────────────
  void _onScroll() {
    for (final section in _sectionOrder.reversed) {
      final key = selectionKeys[section];
      if (key?.currentContext != null) {
        final box = key!.currentContext!.findRenderObject() as RenderBox?;
        if (box != null) {
          final dy = box.localToGlobal(Offset.zero).dy;
          if (dy <= 120) {
            if (activeSection.value != section) {
              activeSection.value = section;
            }
            break;
          }
        }
      }
    }
  }

  // ─── Form validation ──────────────────────────────────────────────────────────
  bool validateFields() {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        subjectController.text.trim().isEmpty ||
        messageController.text.trim().isEmpty) {
      Get.snackbar(
        'Missing Fields',
        'Please fill in all fields before sending.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
      return false;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
      return false;
    }
    return true;
  }

  // ─── Send message ─────────────────────────────────────────────────────────────
  Future<void> sendMessage() async {
    if (!validateFields()) return;
    isSendingMessage.value = true;
    await Future.delayed(const Duration(seconds: 2)); // simulate API call
    isSendingMessage.value = false;
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
    Get.snackbar(
      'Message Sent! 🎉',
      'Thanks for reaching out. I\'ll get back to you soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onReady() {
    super.onReady();
    isDownloading.value = true;
  }

  @override
  void onClose() {
    scrollController.dispose();
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  // ─── Smooth scroll to section ─────────────────────────────────────────────────
  void scrollToSection(String sectionName) {
    activeSection.value = sectionName;
    final key = selectionKeys[sectionName];
    if (key != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ctx = key.currentContext;
        if (ctx != null) {
          Scrollable.ensureVisible(
            ctx,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubic,
            alignment: 0.0,
          );
        }
      });
    }
  }

  // ─── Open external URL ────────────────────────────────────────────────────────
  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Error',
        'Could not open: $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  // ─── Download / open PDF resume ───────────────
  Future<void> downloadPdf(String url, String fileName) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        Get.snackbar(
          'Resume Opened',
          'Your resume is opening in the browser.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
          borderRadius: 12,
          margin: const EdgeInsets.all(16),
        );
      } else {
        Get.snackbar('Error', 'Could not open resume.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong while opening resume.');
    }
  }

  // ─── Fetch all public GitHub repos ───────────────────────────────────────────
  Future<void> fetchGithubRepos() async {
    if (isLoadingRepos.value) return;
    showAllProjects.value = true;
    isLoadingRepos.value = true;
    reposError.value = '';
    try {
      final uri = Uri.parse(
        'https://api.github.com/users/$_githubUsername/repos'
        '?sort=updated&per_page=100&type=public',
      );
      final response = await http.get(uri, headers: {
        'Accept': 'application/vnd.github.v3+json',
      });
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        // Filter out forks, sort by stars then updated_at
        final repos = data
            .cast<Map<String, dynamic>>()
            .where((r) => r['fork'] == false)
            .toList()
          ..sort((a, b) {
            final starsA = (a['stargazers_count'] as int? ?? 0);
            final starsB = (b['stargazers_count'] as int? ?? 0);
            if (starsB != starsA) return starsB.compareTo(starsA);
            return (b['updated_at'] as String)
                .compareTo(a['updated_at'] as String);
          });
        githubRepos.value = repos;
      } else if (response.statusCode == 403) {
        reposError.value =
            'GitHub API rate limit reached. Please try again later.';
      } else {
        reposError.value = 'Failed to load repositories (${response.statusCode}).';
      }
    } catch (e) {
      reposError.value = 'Network error. Check your connection and try again.';
    } finally {
      isLoadingRepos.value = false;
    }
  }

  void toggleAllProjects() {
    if (!showAllProjects.value) {
      fetchGithubRepos();
    } else {
      showAllProjects.value = false;
    }
  }
}
