import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/typography/royal_text_styles.dart';
import '../theme/decorations/royal_radius.dart';

import '../widgets/royal_button.dart';
import '../widgets/royal_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  bool enCoursDeChargement = false;
  bool masquerMotDePasse = true;

  Future<void> inscrire() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      enCoursDeChargement = true;
    });

    try {
      await Supabase.instance.client.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Votre compte a été créé avec succès !"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur d'inscription : ${e.toString()}"),
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
        iconTheme: const IconThemeData(color: Color(0xFF1F2937)),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo / Icône d'Enchère Stylisé (Cohérence avec LoginPage)
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
      Icons.person_add_alt_1_rounded,
      size: 50,
      color: RoyalColors.primary,
    ),
  ),
),
                  const SizedBox(height: 24),
                  
                  // Titres d'accueil
                  const Text(
                    "Rejoignez l'aventure",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
  "Rejoignez Royalis et commencez à vendre ou enchérir.",
  textAlign: TextAlign.center,
  style: RoyalTextStyles.body,
),
                  const SizedBox(height: 36),

                  // Saisie de l'Email
                  RoyalTextField(
  controller: emailController,
  hint: "Adresse email",
  icon: Icons.email_outlined,
  keyboardType: TextInputType.emailAddress,
  validator: (v) {
    if (v == null || v.isEmpty) {
      return "Veuillez entrer une adresse email";
    }

    if (!RegExp(
      r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
    ).hasMatch(v)) {
      return "Email invalide";
    }

    return null;
  },
),
                  const SizedBox(height: 16),

                  // Saisie du Mot de Passe
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
  validator: (v) {
    if (v == null || v.isEmpty) {
      return "Veuillez entrer un mot de passe";
    }

    if (v.length < 6) {
      return "Minimum 6 caractères";
    }

    return null;
  },
),
                  const SizedBox(height: 32),

                  // Bouton Créer un compte avec indicateur de chargement
                  RoyalButton(
  text: "Créer mon compte",
  icon: Icons.person_add_alt_1,
  loading: enCoursDeChargement,
  onPressed: inscrire,
),
                  const SizedBox(height: 24),

                  // Redirection vers la connexion si déjà inscrit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous avez déjà un compte ?",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Se connecter",
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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