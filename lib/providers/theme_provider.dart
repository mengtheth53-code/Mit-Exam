import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeColorOption {
  final String name;
  final Color color;

  const ThemeColorOption({required this.name, required this.color});
}

const List<ThemeColorOption> availableThemeColors = [
  ThemeColorOption(name: 'Neon Purple', color: Color(0xFF8B5CF6)),
  ThemeColorOption(name: 'Cyber Indigo', color: Color(0xFF6366F1)),
  ThemeColorOption(name: 'Electric Teal', color: Color(0xFF06B6D4)),
  ThemeColorOption(name: 'Emerald Green', color: Color(0xFF10B981)),
  ThemeColorOption(name: 'Sunset Amber', color: Color(0xFFF59E0B)),
  ThemeColorOption(name: 'Neon Pink', color: Color(0xFFEC4899)),
  ThemeColorOption(name: 'Crimson Red', color: Color(0xFFEF4444)),
];

class ThemeState {
  final ThemeMode themeMode;
  final Color primaryColor;

  const ThemeState({
    required this.themeMode,
    required this.primaryColor,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    Color? primaryColor,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}

class ThemeNotifier extends Notifier<ThemeState> {
  @override
  ThemeState build() {
    return const ThemeState(
      themeMode: ThemeMode.system,
      primaryColor: Color(0xFF8B5CF6),
    );
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void setPrimaryColor(Color color) {
    state = state.copyWith(primaryColor: color);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(() {
  return ThemeNotifier();
});
