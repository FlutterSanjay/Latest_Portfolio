import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // Navigation
          'nav_home': 'Home',
          'nav_about': 'About',
          'nav_skills': 'Skills',
          'nav_experience': 'Experience',
          'nav_projects': 'Projects',
          'nav_certificates': 'Certificates',
          'nav_education': 'Education',
          'nav_contact': 'Contact',
          
          // Hire Me
          'hire_me': 'Hire me',

          // Hero Section
          'available': 'Available for opportunities',
          'role_flutter': 'Flutter Developer',
          'role_backend': 'Backend Developer',
          'role_fullstack': 'Full Stack Developer',
          'role_mobile': 'Mobile App Specialist',
          'hero_desc': 'A result-oriented Software Engineer specializing in Flutter and full-stack development. Combining 1+ years of hands-on internship experience with a solid academic foundation in Computer Science, I design and build scalable, high-performance mobile and web applications that deliver exceptional user experiences.',
          'download_resume': 'Download Resume',
          
          // About Section
          'about_title': 'About Me',
          'about_subtitle': 'Passionate developer building elegant digital experiences',
          'about_heading': "I'm Sanjay Shaw",
          'about_p1': "I am a Computer Science & Engineering student and Software Engineer with 1+ years of professional internship experience. Specializing in Flutter, Dart, C++, and JavaScript, I focus on architecting responsive, user-centric, and scalable cross-platform applications.",
          'about_p2': "My technical expertise spans full-stack engineering with React.js, Node.js, and Express, alongside database design across MongoDB, MySQL, and Firebase. I have proven experience implementing robust state management (GetX, BLoC) and integrating advanced AI capabilities using LLMs and LangChain to deliver optimized, production-ready solutions.",
          'stat_projects': 'Projects',
          'stat_internships': 'Experience',
          'stat_certificates': 'Certificates',

          // Skills Section
          'skills_title': 'Technical Expertise',
          'skills_subtitle': 'Technologies I work with daily to build great products',
          'skill_cat_1': 'Programming Languages',
          'skill_cat_2': 'Frameworks & Libraries',
          'skill_cat_3': 'Databases',
          'skill_cat_4': 'AI & Emerging Tech',
          'skill_cat_5': 'State Management',
          'skill_cat_6': 'Tools & Platform',

          // Experience Section
          'exp_title': 'Internship Experience',
          'exp_subtitle': 'Real-world projects where I honed my craft',
          'exp_type_internship': 'Internship',
          'exp_view_cert': 'View Certificate',
          'exp1_desc': 'Contributed to building a cross-platform Sales CRM mobile application using Flutter, GetX, and MVC architecture. Worked on 30+ screens, integrated RESTful APIs via Dio with secure authentication (Google/Microsoft OAuth). Assisted in implementing a 4-tier RBAC system and integrated Firebase, ML Kit OCR, and Syncfusion Charts.',
          'exp2_desc': 'Contributed to full-stack feature development using the MERN stack. Designed MongoDB schemas, developed RESTful APIs, implemented secure user authentication, and built responsive user interfaces using React.js and Tailwind CSS within an Agile environment.',
          'exp3_desc': 'Worked on building and optimizing mobile applications using Flutter and Dart. Designed pixel-perfect responsive UIs, integrated secure REST APIs, and improved application load times and performance.',

          // Projects Section
          'proj_title': 'Featured Projects',
          'proj_subtitle': 'A selection of projects that showcase my capabilities',
          'proj_all_repos': 'All GitHub Repositories',
          'proj_all_repos_desc': 'Public repositories sorted by stars',
          'proj_no_featured': 'No featured projects in this category.',
          'proj_loading': 'Loading repositories...',
          'proj_error': 'Failed to load GitHub repositories.',
          'proj_no_repos': 'No repositories found.',
          'proj_retry': 'Retry',
          'proj_no_repos_found': 'No public repositories found.',
          'proj1_desc': 'Developed a cross-platform (Android, iOS & Windows) CRM application for managing the full sales pipeline — from lead discovery to deal closure. Features multi-channel outreach, AI brain assistant, and 4-tier RBAC.',
          'proj2_desc': 'Built a full-stack web application that unifies live HD video calling, real-time instant messaging, and a collaborative code editor into one seamless interface for technical interviews powered by WebRTC & WebSockets.',
          'proj3_desc': 'Developed a cross-platform mobile shopping application using Flutter & Firebase. Architected with GetX MVC for clean state management. Integrated secure auth, real-time database, and dedicated Admin panels.',

          // Education Section
          'edu_title': 'My Education',
          'edu_subtitle': 'Academic foundation that drives my technical expertise',
          'edu1_degree': 'B.Tech — Computer Science & Engineering',
          'edu1_inst': 'Central University of Haryana',
          'edu1_desc': 'Pursuing my degree with deep focus on software development, algorithms, and advanced programming concepts. Active participant in inter-university competitions.',
          'edu2_degree': 'Senior Secondary (XII)',
          'edu2_inst': 'Ideal School, Kalyani (W.B)',
          'edu2_desc': 'Completed senior secondary education with a strong focus on Physics, Chemistry, and Mathematics, building a robust scientific foundation.',
          'edu3_degree': 'Secondary Examination (X)',
          'edu3_inst': 'Air Force School, Palta',
          'edu3_desc': 'Completed secondary education with distinction. Also represented in All India Air Force Athletics Championship — 2nd Position in 800m Race.',

          // Certificates Section
          'cert_title': 'Certifications & Achievements',
          'cert_subtitle': 'Continuous learning and key milestones achieved',
          'cert1_title': 'Flutter Development Bootcamp',
          'cert2_title': 'Flutter Puzzle Hack',
          'cert3_title': 'Full Stack Web Development',
          'cert4_title': 'AI Tools Workshop',
          'cert5_title': 'UI & UX for Beginners',
          'cert6_title': 'Git & GitHub Mastery',
          'cert7_title': 'National Science Day (3rd Position - Working Models)',
          'cert8_title': 'All India Air Force Athletics & Sports Championship (2nd Position - 800m)',
          'cert_err': 'Could not open certificate',

          // Contact Section
          'contact_title': 'Get In Touch',
          'contact_subtitle': "Have a project in mind? I'd love to hear from you",
          'contact_heading': "Let's work together",
          'contact_desc': "I'm currently open to new opportunities. Whether you have a project, a question, or just want to say hi — my inbox is always open!",
          'contact_loc': 'Location',
          'contact_loc_val': 'Kolkata, West Bengal, India',
          'contact_email': 'Email',
          'contact_phone': 'Phone',
          'contact_form_title': 'Send a Message',
          'contact_name': 'Your Name',
          'contact_email_field': 'Your Email',
          'contact_subject': 'Subject',
          'contact_msg': 'Your Message',
          'contact_send': 'Send Message',
        },
        'hi_IN': {
          // Navigation
          'nav_home': 'होम',
          'nav_about': 'मेरे बारे में',
          'nav_skills': 'कौशल',
          'nav_experience': 'अनुभव',
          'nav_projects': 'परियोजनाएं',
          'nav_certificates': 'प्रमाण पत्र',
          'nav_education': 'शिक्षा',
          'nav_contact': 'संपर्क करें',

          // Hire Me
          'hire_me': 'मुझे नियुक्त करें',

          // Hero Section
          'available': 'अवसरों के लिए उपलब्ध',
          'role_flutter': 'Flutter डेवलपर',
          'role_backend': 'बैकएंड डेवलपर',
          'role_fullstack': 'फुल स्टैक डेवलपर',
          'role_mobile': 'मोबाइल ऐप विशेषज्ञ',
          'hero_desc': 'फ्लटर और फुल-स्टैक विकास में विशेषज्ञता रखने वाले एक परिणाम-उन्मुख सॉफ्टवेयर इंजीनियर। कंप्यूटर विज्ञान में एक ठोस शैक्षणिक आधार के साथ 1+ वर्ष के व्यावहारिक इंटर्नशिप अनुभव को मिलाते हुए, मैं स्केलेबल, उच्च-प्रदर्शन वाले मोबाइल और वेब एप्लिकेशन डिज़ाइन और विकसित करता हूँ जो असाधारण उपयोगकर्ता अनुभव प्रदान करते हैं।',
          'download_resume': 'रिज्यूमे डाउनलोड करें',

          // About Section
          'about_title': 'मेरे बारे में',
          'about_subtitle': 'शानदार डिजिटल अनुभव बनाने वाला एक जुनूनी डेवलपर',
          'about_heading': 'मैं संजय शॉ हूँ',
          'about_p1': 'मैं 1+ वर्ष के पेशेवर इंटर्नशिप अनुभव के साथ कंप्यूटर विज्ञान और इंजीनियरिंग का छात्र और सॉफ्टवेयर इंजीनियर हूँ। फ्लटर, डार्ट, C++ और जावास्क्रिप्ट में विशेषज्ञता के साथ, मेरा ध्यान उत्तरदायी, उपयोगकर्ता-केंद्रित और स्केलेबल क्रॉस-प्लेटफ़ॉर्म एप्लिकेशन तैयार करने पर है।',
          'about_p2': 'मेरी तकनीकी विशेषज्ञता मोंगोडीबी, MySQL और फायरबेस में डेटाबेस डिज़ाइन के साथ-साथ रिएक्ट.जीएस, नोड.जीएस और एक्सप्रेस के साथ फुल-स्टैक इंजीनियरिंग तक फैली हुई है। मेरे पास कुशल स्टेट मैनेजमेंट (GetX, BLoC) लागू करने और अनुकूलित, उत्पादन-तैयार समाधान प्रदान करने के लिए एलएलएम और लैंगचेन का उपयोग करके उन्नत एआई क्षमताओं को एकीकृत करने का प्रमाणित अनुभव है।',
          'stat_projects': 'परियोजनाएं',
          'stat_internships': 'अनुभव',
          'stat_certificates': 'प्रमाण पत्र',

          // Skills Section
          'skills_title': 'तकनीकी विशेषज्ञता',
          'skills_subtitle': 'उत्कृष्ट उत्पाद बनाने के लिए जिन तकनीकों के साथ मैं प्रतिदिन काम करता हूँ',
          'skill_cat_1': 'प्रोग्रामिंग भाषाएँ',
          'skill_cat_2': 'फ्रेमवर्क और लाइब्रेरी',
          'skill_cat_3': 'डेटाबेस',
          'skill_cat_4': 'एआई और उभरती तकनीकें',
          'skill_cat_5': 'स्टेट मैनेजमेंट',
          'skill_cat_6': 'उपकरण और प्लेटफ़ॉर्म',

          // Experience Section
          'exp_title': 'इंटर्नशिप अनुभव',
          'exp_subtitle': 'वास्तविक दुनिया की परियोजनाएं जहां मैंने अपने कौशल को निखारा',
          'exp_type_internship': 'इंटर्नशिप',
          'exp_view_cert': 'प्रमाण पत्र देखें',
          'exp1_desc': 'Flutter, GetX और MVC आर्किटेक्चर का उपयोग करके क्रॉस-प्लेटफॉर्म सेल्स CRM मोबाइल एप्लिकेशन बनाने में योगदान दिया। 30+ स्क्रीन पर काम किया, सुरक्षित प्रमाणीकरण (Google/Microsoft OAuth) के साथ Dio के माध्यम से RESTful APIs को एकीकृत किया। 4-स्तरीय RBAC प्रणाली को लागू करने में सहायता की और Firebase, ML किट OCR, और Syncfusion Charts को एकीकृत किया।',
          'exp2_desc': 'MERN स्टैक का उपयोग करके फुल-स्टैक फीचर विकास में योगदान दिया। मोंगोडीबी स्कीमा डिजाइन किए, RESTful APIs विकसित किए, सुरक्षित उपयोगकर्ता प्रमाणीकरण लागू किया, और एक चुस्त वातावरण के भीतर React.js और Tailwind CSS का उपयोग करके उत्तरदायी यूजर इंटरफेस बनाए।',
          'exp3_desc': 'Flutter और Dart का उपयोग करके मोबाइल एप्लिकेशन बनाने और उनके अनुकूलन पर काम किया। पिक्सेल-परफेक्ट रिस्पॉन्सिव यूआई डिज़ाइन किए, सुरक्षित REST APIs को एकीकृत किया, और एप्लिकेशन के प्रदर्शन में सुधार किया।',

          // Projects Section
          'proj_title': 'विशेष रुप से प्रदर्शित परियोजनाएं',
          'proj_subtitle': 'परियोजनाओं का चयन जो मेरी क्षमताओं को प्रदर्शित करता है',
          'proj_all_repos': 'सभी गिटहब रिपॉजिटरी',
          'proj_all_repos_desc': 'सितारों द्वारा क्रमबद्ध सार्वजनिक रिपॉजिटरी',
          'proj_no_featured': 'इस श्रेणी में कोई विशेष परियोजना नहीं है।',
          'proj_loading': 'रिपॉजिटरी लोड हो रहा है...',
          'proj_error': 'गिटहब रिपॉजिटरी लोड करने में विफल।',
          'proj_no_repos': 'कोई रिपॉजिटरी नहीं मिली।',
          'proj_retry': 'पुनः प्रयास करें',
          'proj_no_repos_found': 'कोई सार्वजनिक रिपॉजिटरी नहीं मिली।',
          'proj1_desc': 'लीड खोजने से लेकर डील क्लोजर तक — पूर्ण बिक्री पाइपलाइन के प्रबंधन के लिए एक क्रॉस-प्लेटफॉर्म (Android, iOS और Windows) CRM एप्लिकेशन विकसित किया। इसमें मल्टी-चैनल आउटरीच, AI ब्रेन असिस्टेंट और 4-टियर RBAC की सुविधा है।',
          'proj2_desc': 'एक फुल-स्टैक वेब एप्लिकेशन बनाया जो WebRTC और WebSockets द्वारा संचालित तकनीकी साक्षात्कारों के लिए लाइव एचडी वीडियो कॉलिंग, रीयल-टाइम इंस्टेंट मैसेजिंग और एक सहयोगी कोड संपादक को एक सहज इंटरफ़ेस में एकीकृत करता है।',
          'proj3_desc': 'Flutter और Firebase का उपयोग करके एक क्रॉस-प्लेटफॉर्म मोबाइल शॉपिंग एप्लिकेशन विकसित किया। स्वच्छ राज्य प्रबंधन के लिए GetX MVC के साथ आर्किटेक्ट किया गया। सुरक्षित प्रमाणीकरण, रीयल-टाइम डेटाबेस और समर्पित व्यवस्थापक पैनल को एकीकृत किया गया।',

          // Education Section
          'edu_title': 'मेरी शिक्षा',
          'edu_subtitle': 'शैक्षणिक आधार जो मेरी तकनीकी विशेषज्ञता को संचालित करता है',
          'edu1_degree': 'बी.टेक — कंप्यूटर विज्ञान और इंजीनियरिंग',
          'edu1_inst': 'हरियाणा केंद्रीय विश्वविद्यालय',
          'edu1_desc': 'सॉफ्टवेयर विकास, एल्गोरिदम और उन्नत प्रोग्रामिंग अवधारणाओं पर गहरे ध्यान के साथ अपनी डिग्री हासिल कर रहा हूँ। अंतर-विश्वविद्यालय प्रतियोगिताओं में सक्रिय भागीदार।',
          'edu2_degree': 'वरिष्ठ माध्यमिक (XII)',
          'edu2_inst': 'आदर्श विद्यालय, कल्याणी (प.बं.)',
          'edu2_desc': 'भौतिकी, रसायन विज्ञान और गणित पर विशेष ध्यान देने के साथ वरिष्ठ माध्यमिक शिक्षा पूरी की, एक मजबूत वैज्ञानिक आधार का निर्माण किया।',
          'edu3_degree': 'माध्यमिक परीक्षा (X)',
          'edu3_inst': 'वायु सेना स्कूल, पलटा',
          'edu3_desc': 'डिस्टिंक्शन के साथ माध्यमिक शिक्षा पूरी की। अखिल भारतीय वायु सेना एथलेटिक्स चैम्पियनशिप में भी प्रतिनिधित्व किया - 800 मीटर दौड़ में दूसरा स्थान।',

          // Certificates Section
          'cert_title': 'प्रमाणपत्र और उपलब्धियां',
          'cert_subtitle': 'निरंतर सीखना और प्रमुख मील के पत्थर हासिल किए',
          'cert1_title': 'Flutter Development Bootcamp',
          'cert2_title': 'Flutter Puzzle Hack',
          'cert3_title': 'Full Stack Web Development',
          'cert4_title': 'AI Tools Workshop',
          'cert5_title': 'UI & UX for Beginners',
          'cert6_title': 'Git & GitHub Mastery',
          'cert7_title': 'राष्ट्रीय विज्ञान दिवस (तीसरा स्थान - वर्किंग मॉडल)',
          'cert8_title': 'अखिल भारतीय वायु सेना एथलेटिक्स और खेल चैम्पियनशिप (दूसरा स्थान - 800 मीटर)',
          'cert_err': 'प्रमाणपत्र नहीं खोल सका',

          // Contact Section
          'contact_title': 'संपर्क में रहें',
          'contact_subtitle': 'क्या आपके मन में कोई प्रोजेक्ट है? मुझे आपसे सुनना अच्छा लगेगा',
          'contact_heading': 'आइए मिलकर काम करें',
          'contact_desc': 'मैं वर्तमान में नए अवसरों के लिए खुला हूं। चाहे आपके पास कोई प्रोजेक्ट हो, कोई प्रश्न हो, या बस नमस्ते कहना चाहते हों - मेरा इनबॉक्स हमेशा खुला है!',
          'contact_loc': 'स्थान',
          'contact_loc_val': 'कोलकाता, पश्चिम बंगाल, भारत',
          'contact_email': 'ईमेल',
          'contact_phone': 'फ़ोन',
          'contact_form_title': 'संदेश भेजें',
          'contact_name': 'आपका नाम',
          'contact_email_field': 'आपका ईमेल',
          'contact_subject': 'विषय',
          'contact_msg': 'आपका संदेश',
          'contact_send': 'संदेश भेजें',
        },
      };
}
