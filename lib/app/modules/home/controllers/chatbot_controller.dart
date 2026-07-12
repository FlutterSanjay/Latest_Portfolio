import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:langchain/langchain.dart' as langchain;
import 'package:langchain_anthropic/langchain_anthropic.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class ChatbotController extends GetxController {
  // ─── DashChat users ────────────────────────────────────────────────────────
  final ChatUser currentUser = ChatUser(
    id: 'portfolio_visitor',
    firstName: 'You',
  );

  final ChatUser botUser = ChatUser(
    id: 'sanjay_ai',
    firstName: "Sanjay's",
    lastName: 'AI',
    profileImage:
        'https://ui-avatars.com/api/?name=AI&background=7C3AED&color=fff&rounded=true',
  );

  // ─── Reactive state ────────────────────────────────────────────────────────
  var chatMessages = <ChatMessage>[].obs;
  var isOpen = false.obs;
  var isTyping = false.obs;

  // ─── API keys (Set these in your environment or replace below) ─────────────
  // ─── API keys (Set these in your environment or replace below) ─────────────
  static String get _claudeApiKey => dotenv.env['CLAUDE_API_KEY'] ?? const String.fromEnvironment('CLAUDE_API_KEY', defaultValue: '');

  // ─── LangChain Components ──────────────────────────────────────────────────
  ChatAnthropic? _llm;

  // ─── Full system prompt with Sanjay's complete profile ────────────────────
  static const String _systemPromptTemplate = '''
You are Sanjay Shaw's personal AI portfolio assistant embedded on his portfolio website.
Be friendly, professional, and highly interactive. Feel free to use emojis and Markdown!

Your primary goal is to answer questions about Sanjay using the provided context. Answer in the third person (e.g., "Sanjay is...", "He has...").
If the user asks a question about Sanjay that is NOT in the context, politely suggest they contact him directly.

HOWEVER, if the user asks a general technical question about the technologies in Sanjay's tech stack (e.g., "What is Flutter?", "Explain React", "How does Node.js work?"), you MUST act as an expert developer and answer their technical question clearly, comprehensively, and interactively (using code snippets if appropriate). Do not tell them to contact Sanjay for general technical facts!

Context retrieved from Sanjay's portfolio:
{context}
''';

  // ─── Local keyword fallback ────────────────────────────────────────────────
  static const List<Map<String, String>> _qa = [
    {
      'trigger': 'skill',
      'answer':
          'Sanjay is skilled in Flutter, Dart, React.js, Node.js, Express.js, Firebase, MongoDB & MySQL. He specialises in GetX & BLoC state management, and has hands-on AI experience with LangChain, Gemini API & LLMs. 💡',
    },
    {
      'trigger': 'experienc',
      'answer':
          'Sanjay has 2 internships:\n1️⃣ Flutter Intern @ Gravity Engineering (Jan 2025–Present) — built a cross-platform Sales CRM with 30+ screens, 4-tier RBAC & OAuth.\n2️⃣ MERN Intern @ UptoSkills (Feb–May 2025) — React.js frontend, Node.js APIs, MongoDB.',
    },
    {
      'trigger': 'project',
      'answer':
          'Sanjay has built 6+ projects:\n🏆 Polluxa CRM (on Google Play)\n🎥 Remote Interview Platform (live)\n👟 Footware Store (Flutter)\n🤖 Restaurant AI Chatbot\n🔍 AI Code Reviewer\n✈️ Flights Service Backend',
    },
    {
      'trigger': 'contact',
      'answer':
          'Reach Sanjay at:\n📧 sanjayshaw80138@gmail.com\n📱 +91-8013812268\n💼 linkedin.com/in/sanjay-shaw-6a70a7178\n🐙 github.com/FlutterSanjay',
    },
    {
      'trigger': 'educat',
      'answer':
          'Sanjay is pursuing B.Tech CSE at Central University of Haryana (2022–2026) with a CGPA of 8.72. He scored 90.2% in Class XII and 77.8% in Class X. 🎓',
    },
    {
      'trigger': 'achiev',
      'answer':
          '🥈 2nd Place — 800m Race at All India Air Force Athletics Championship 2019\n🥉 3rd Place — Working Models at National Science Day 2024 (Inter-University Level)',
    },
    {
      'trigger': 'availab',
      'answer':
          'Yes! Sanjay is currently open to new opportunities — internships, full-time roles & freelance projects. Reach out at sanjayshaw80138@gmail.com or on LinkedIn! 🚀',
    },
    {
      'trigger': 'flutter',
      'answer':
          "Flutter is Sanjay's primary expertise — 2+ years building cross-platform apps (Android, iOS, Windows). He's shipped a live CRM on the Play Store, using GetX, BLoC, MVC, and Firebase. 📱",
    },
    {
      'trigger': 'crm',
      'answer':
          'Polluxa CRM is Sanjay\'s flagship project — a cross-platform Sales CRM with 30+ screens, full pipeline management, AI assistant, multi-channel outreach, 4-tier RBAC, and ML Kit OCR. Live on Google Play! 🏆',
    },
    {
      'trigger': 'ai',
      'answer':
          'Sanjay works with LLMs, LangChain, Gemini API & Hugging Face. He built a Restaurant AI Chatbot (LangChain + Gemini) and an AI Code Reviewer. The Polluxa CRM also includes an AI-powered brain assistant. 🤖',
    },
    {
      'trigger': 'hello',
      'answer':
          "Hi there! 👋 I'm Sanjay's portfolio AI assistant. Ask me anything about his skills, experience, projects, education, or how to contact him!",
    },
    {
      'trigger': 'hi',
      'answer':
          "Hello! 👋 I'm here to tell you all about Sanjay Shaw. What would you like to know? Skills, projects, experience, or contact info?",
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _initRAG();
    _addBotMessage(
      "Hi! 👋 I'm **Sanjay's AI assistant**. Ask me about his skills, projects, experience, tech stack, or how to get in touch!",
    );
  }

  Future<void> _initRAG() async {
    if (_claudeApiKey.isEmpty) return; // Silent fallback if no key provided

    try {
      // In production web, route to our Vercel proxy (defined in vercel.json) to bypass CORS.
      // In local development, hit the API directly (requires Windows or --disable-web-security).
      final baseUrl = (kIsWeb && kReleaseMode) 
          ? '${Uri.base.origin}/api/anthropic' 
          : 'https://api.anthropic.com/v1';

      _llm = ChatAnthropic(
        apiKey: _claudeApiKey,
        baseUrl: baseUrl,
        defaultOptions: const ChatAnthropicOptions(
          model: 'claude-3-5-sonnet-20241022',
          temperature: 0.7,
        ),
      );
    } catch (e) {
      // Silently catch and fallback
    }
  }

  void toggleChat() => isOpen.toggle();

  // ─── Called by DashChat onSend ────────────────────────────────────────────
  Future<void> onSend(ChatMessage userMsg) async {
    chatMessages.insert(0, userMsg);
    isTyping.value = true;
    final reply = await _getReply(userMsg.text);
    isTyping.value = false;
    _addBotMessage(reply);
  }

  void _addBotMessage(String text) {
    chatMessages.insert(
      0,
      ChatMessage(
        user: botUser,
        createdAt: DateTime.now(),
        text: text,
      ),
    );
  }

  // ─── RAG Logic ────────────────────────────────────────────────────────────
  Future<String> _getReply(String userText) async {
    if (_llm == null) {
      return _localReply(userText);
    }

    try {
      // 1. Combine entire portfolio into a single context string (Claude handles 200k tokens easily)
      final context = '''
Sanjay Shaw is a Flutter Developer located in Kolkata, West Bengal, India. Email: sanjayshaw80138@gmail.com | Phone: +91-8013812268 | LinkedIn: linkedin.com/in/sanjay-shaw-6a70a7178 | GitHub: github.com/FlutterSanjay | LeetCode: leetcode.com/u/sanjayshaw80138

Sanjay Skills: Languages: Dart, C++, JavaScript. Frameworks: Flutter, Node.js, Express.js, TanStack, Prisma ORM, React.js, DaisyUI. Databases: MongoDB, MySQL, SQFLite, Firebase. AI/ML: LLMs, LangChain, Hugging Face. Tools: Git/GitHub, Docker, Postman, FlutterFlow, Figma. State: GetX, BLoC, Provider.

Experience 1: Flutter Intern at Gravity Engineering Services Pvt. Ltd. (Jan 2025–Present, Raipur). Cross-platform Sales CRM (Android + Windows) using Flutter, GetX, MVC, 30+ screens, APIs via Dio, Google Sign-In, Microsoft Azure AD OAuth, OTP login, 4-tier RBAC, Firebase FCM, ML Kit OCR, Syncfusion Charts.

Experience 2: MERN Intern at UptoSkills (Feb–May 2025, New Delhi). MERN stack: React.js + Tailwind CSS frontend, Node.js + Express.js backend. MongoDB schemas, RESTful APIs, JWT auth, real-time updates.

Projects: 1. Polluxa CRM (Flutter, Firebase, GetX, OAuth, ML Kit) on Google Play Store. 2. Remote Interview Platform (React, WebRTC, WebSockets, Node.js, MongoDB) Live. 3. Footware Store (Flutter, Firebase, GetX). 4. Restaurant AI Chatbot (LangChain, Node.js). 5. AI Code Reviewer (React, AI/ML, Node.js). 6. Flights-Service Backend (Node.js, MySQL, Express.js).

Education: B.Tech CSE from Central University of Haryana (2022–2026), CGPA 8.72. Class XII from Ideal School, Kalyani (W.B), 90.2%. Class X from Air Force School, Palta, 77.8%.

Achievements: 2nd Place in 800m Race at All India Air Force Athletics Championship 2019. 3rd Place in Working Models (Inter-University) at National Science Day 2024, Central Univ. Haryana.
''';

      // 2. Build Chat History for LangChain
      final systemPrompt = _systemPromptTemplate.replaceAll('{context}', context);
      
      List<langchain.ChatMessage> lcMessages = [
        langchain.SystemChatMessage(content: systemPrompt),
      ];

      // Add actual chat history - oldest to newest
      // Anthropic API requires that the first message in the history is a 'user' message.
      // So we skip any leading assistant messages.
      final history = chatMessages.reversed.toList();
      bool foundUserMessage = false;

      for (var m in history) {
        if (m.user.id == currentUser.id) {
          foundUserMessage = true;
          lcMessages.add(langchain.HumanChatMessage(content: langchain.ChatMessageContent.text(m.text)));
        } else if (foundUserMessage) {
          lcMessages.add(langchain.AIChatMessage(content: m.text));
        }
      }

      // 3. Generate response using Claude
      final response = await _llm!.invoke(langchain.PromptValue.chat(lcMessages));
      return response.output.content;

    } catch (e) {
      return _localReply(userText);
    }
  }

  String _localReply(String input) {
    final lower = input.toLowerCase();
    for (final qa in _qa) {
      if (lower.contains(qa['trigger']!)) return qa['answer']!;
    }
    return "Great question! 😊 I can tell you about Sanjay's **skills**, **projects**, **experience**, **education**, or **contact info**. What would you like to know?";
  }
}
