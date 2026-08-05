import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/typography/royal_text_styles.dart';
import '../theme/decorations/royal_radius.dart';

import '../widgets/royal_button.dart';
import '../widgets/royal_text_field.dart';
import '../services/supabase_service.dart';
import 'main_navigation_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool enCoursDeChargement = false;
  bool masquerMotDePasse = true;

  Future<void> connexion() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() {
    enCoursDeChargement = true;
  });

  try {
    await SupabaseService.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Ravi de vous revoir !"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const MainNavigationPage(),
      ),
      (route) => false,
    );
  } on AuthException catch (e) {
    if (!mounted) return;

    String messageErreur;

    switch (e.code) {
      case 'invalid_credentials':
      case 'invalid_login_credentials':
        messageErreur = "Email ou mot de passe incorrect.";
        break;

      case 'email_not_confirmed':
        messageErreur =
            "Veuillez confirmer votre adresse email avant de vous connecter.";
        break;

      case 'network_error':
        messageErreur =
            "Impossible de contacter le serveur. Vérifiez votre connexion Internet.";
        break;

      default:
        messageErreur = e.message;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messageErreur),
        backgroundColor: Colors.redAccent,
      ),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Erreur inattendue : $e"),
        backgroundColor: Colors.redAccent,
      ),
    );
  } finally {
    if (mounted) {
      setState(() {
        enCoursDeChargement = false;
      });
    }
  }
}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF1F2937),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Center(
  child: Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: RoyalColors.card,
      borderRadius: RoyalRadius.xl,
      border: Border.all(
        color: RoyalColors.border,
      ),
    ),
    child: const Icon(
      Icons.gavel_rounded,
      size: 52,
      color: RoyalColors.primary,
    ),
  ),
),

                  const SizedBox(height: 24),

                  const Text(
  "Bon retour !",
  textAlign: TextAlign.center,
  style: RoyalTextStyles.headline,
),

                  const SizedBox(height: 8),

                  const Text(
  "Connectez-vous pour accéder à vos enchères.",
  textAlign: TextAlign.center,
  style: RoyalTextStyles.body,
),

                  const SizedBox(height: 36),

                  RoyalTextField(
  controller: emailController,
  hint: "Adresse email",
  icon: Icons.email_outlined,
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return "Veuillez entrer votre email";
    }

    if (!RegExp(
      r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
    ).hasMatch(value)) {
      return "Email invalide";
    }

    return null;
  },
),

                  const SizedBox(height: 16),

                  RoyalTextField(
  controller: passwordController,
  hint: "Mot de passe",
  icon: Icons.lock_outline,
  obscureText: masquerMotDePasse,
  suffixIcon: IconButton(
    icon: Icon(
      masquerMotDePasse
          ? Icons.visibility_off_outlined
          : Icons.visibility_outlined,
    ),
    onPressed: () {
      setState(() {
        masquerMotDePasse = !masquerMotDePasse;
      });
    },
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return "Veuillez entrer votre mot de passe";
    }
    return null;
  },
),

                  const SizedBox(height: 32),

                  RoyalButton(
  text: "Se connecter",
  loading: enCoursDeChargement,
  icon: Icons.login,
  onPressed: connexion,
),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous n'avez pas de compte ?",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "S'inscrire",
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}