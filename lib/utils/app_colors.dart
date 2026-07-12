import 'package:flutter/material.dart';

class AppColors {
  // ─── BACKGROUNDS ────────────────────────────────────────────────────────────
  static const Color backgroundColor = Color(0xFF080810);
  static const Color surfaceColor = Color(0xFF0F0F1A);
  static const Color cardColor = Color(0xFF13131F);
  static const Color cardHoverColor = Color(0xFF1A1A2E);
  static const Color navBarColor = Color(0xFF0A0A14);

  // ─── PRIMARY  (Violet → Indigo) ─────────────────────────────────────────────
  static const Color primaryColor = Color(0xFF7C3AED);
  static const Color primaryDark = Color(0xFF5B21B6);
  static const Color primaryLight = Color(0xFFA855F7);
  static const Color primary2Color = Color(0xFF8E2DE2);
  static const Color primary3Color = Color(0xFF5B21B6);
  static const Color primary4Color = Color(0xFF6D4AED);
  static const Color primary5Color = Color(0xFFA78BFA);
  static const Color indigoColor = Color(0xFF4F46E5);

  // ─── ACCENT COLORS ──────────────────────────────────────────────────────────
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentPink = Color(0xFFEC4899);

  // ─── TEXT ────────────────────────────────────────────────────────────────────
  static const Color textColor = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textLightColor = Color(0xFF94A3B8); // legacy compat

  // ─── BORDERS & GLASS ─────────────────────────────────────────────────────────
  static const Color borderColor = Color(0x1AFFFFFF); // white 10 %
  static const Color borderBright = Color(0x33FFFFFF); // white 20 %
  static const Color glassColor = Color(0x0DFFFFFF); // white 5 %
  static const Color glassBright = Color(0x1AFFFFFF); // white 10 %

  // ─── LEGACY / COMPAT ─────────────────────────────────────────────────────────
  static const Color secondaryColor = Color(0xFF10B981);
  static const Color secondary2Color = Color(0xFF34D399);
  static const Color buttonColor = Color(0xFF7C3AED);
  static const Color buttonBorderColor = Color(0xFF10B981);
  static const Color socialIconColor = Color(0xFFF1F5F9);
  static const Color whiteBackgroundColor = Color(0xffffffff);
  static const Color cardGradientStart = Color(0xFF7C3AED);
  static const Color cardGradientEnd = Color(0xFF06B6D4);

  // ─── GRADIENTS ───────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF4F46E5), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient subtleGradient = LinearGradient(
    colors: [Color(0xFF13131F), Color(0xFF1A1A2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ─── CONVENIENCE HELPERS ──────────────────────────────────────────────────────
  /// A violet-to-cyan gradient used for skill bars, badges, etc.
  static const LinearGradient barGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)],
  );

  /// Timeline connector / divider accent
  static const LinearGradient timelineGradient = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF4F46E5), Color(0xFF06B6D4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
