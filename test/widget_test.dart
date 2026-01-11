// AI Chat Widget Tests
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:ai_chat/main.dart';
import 'package:ai_chat/services/chat_service.dart';
import 'package:ai_chat/screens/splash_screen.dart';

void main() {
  group('AI Chat App Tests', () {
    testWidgets('App renders SplashScreen initially', (WidgetTester tester) async {
      // Build the app with a mock ChatService
      await tester.pumpWidget(
        Provider<ChatService>(
          create: (_) => ChatService('test_api_key'),
          child: const MyApp(),
        ),
      );

      // Verify that the splash screen is displayed
      expect(find.byType(SplashScreen), findsOneWidget);
    });

    testWidgets('MyApp builds without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        Provider<ChatService>(
          create: (_) => ChatService('test_api_key'),
          child: const MyApp(),
        ),
      );

      // Verify app renders
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('SplashScreen displays app title', (WidgetTester tester) async {
      await tester.pumpWidget(
        Provider<ChatService>(
          create: (_) => ChatService('test_api_key'),
          child: const MyApp(),
        ),
      );

      // Wait for animations to start
      await tester.pump(const Duration(milliseconds: 1500));

      // Check for app title
      expect(find.text('AI Chat'), findsOneWidget);
    });
  });

  group('ChatService Tests', () {
    test('ChatService initializes with API key', () {
      final chatService = ChatService('test_key');
      expect(chatService, isNotNull);
    });
  });
}
