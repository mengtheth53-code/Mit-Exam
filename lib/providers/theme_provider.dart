import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeColorOption {
  final String name;
  final Color color;

  const ThemeColorOption({required this.name, required this.color});
}

const List<ThemeColorOption> availableThemeColors = [
  ThemeColorOption(name: 'Deep Purple', color: Colors.deepPurple),
  ThemeColorOption(name: 'Royal Blue', color: Colors.indigo),
  ThemeColorOption(name: 'Cyan Teal', color: Colors.teal),
  ThemeColorOption(name: 'Emerald Green', color: Colors.green),
  ThemeColorOption(name: 'Amber Orange', color: Colors.deepOrange),
  ThemeColorOption(name: 'Rose Pink', color: Colors.pink),
  ThemeColorOption(name: 'Crimson Red', color: Colors.red),
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
      primaryColor: Colors.deepPurple,
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
