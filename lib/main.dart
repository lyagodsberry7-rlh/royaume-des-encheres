import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/login_page.dart';
import 'pages/main_navigation_page.dart';
import 'services/supabase_service.dart';

import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

   const supabaseUrl = 'https://ikglzslzifixwwnldxar.supabase.co';

   const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlrZ2x6c2x6aWZpeHd3bmxkeGFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEyNzQxMjAsImV4cCI6MjA5Njg1MDEyMH0.m_JCRxOW25B6k0pgmsNmikr1i8nHg4dMRoBTFH4K7oU';
  
   try {
    await Supabase.initialize(
      url: supabaseUrl,
      publishableKey: supabaseAnonKey,
    );

    developer.log(
      '✅ Supabase initialisé',
      name: 'Supabase',
    );
  } catch (e, stackTrace) {
    developer.log(
      '❌ Erreur Supabase',
      name: 'Supabase',
      error: e,
      stackTrace: stackTrace,
    );

    rethrow;
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MonApp(),
    ),
  );
}

class MonApp extends StatelessWidget {
  const MonApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'ROYALIS',

      theme: AppTheme.light,

      darkTheme: AppTheme.dark,

      themeMode: themeProvider.themeMode,

      home: StreamBuilder<AuthState>(
        stream: SupabaseService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    "Impossible de se connecter au serveur.",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }

          if (snapshot.data?.session != null) {
            return const MainNavigationPage();
          }

          return const LoginPage();
        },
      ),
    );
  }
}