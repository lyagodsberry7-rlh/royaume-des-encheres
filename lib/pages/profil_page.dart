import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';
import '../theme/colors/royal_colors.dart';
import '../theme/typography/royal_text_styles.dart';

import '../widgets/royal_button.dart';

import '../services/kyc_service.dart';

import 'conversations_page.dart';
import 'favoris_page.dart';
import 'login_page.dart';
import 'mes_articles_page.dart';
import 'mes_encheres_page.dart';
import 'notifications_page.dart';
import 'verification_identite_page.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  User? user;


final KycService kycService = KycService();

bool utilisateurVerifie = false;

  @override
void initState() {
  super.initState();

  user = Supabase.instance.client.auth.currentUser;

  verifierCompte();
}


Future<void> verifierCompte() async {

  final resultat =
      await kycService.utilisateurVerifie();


  if(!mounted) return;


  setState(() {
    utilisateurVerifie = resultat;
  });

}

  void ouvrirPageConnectee(Widget page) {
    if (user == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      ).then((_) {
        setState(() {
          user = Supabase.instance.client.auth.currentUser;
        });
      });
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool estConnecte = user != null;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: RoyalColors.background,

     appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  centerTitle: true,
  title: const Text(
    "Mon Profil",
    style: RoyalTextStyles.title,
  ),
),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 10),

            //=========================================================
            // HEADER
            //=========================================================

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [

                  Stack(
                    children: [

                      CircleAvatar(
                        radius: 48,
                        backgroundColor:
   RoyalColors.primary.withValues(alpha: 0.15),

                        child: Icon(
                          Icons.person,
                          size: 54,
                          color: RoyalColors.text,
                        ),
                      ),

                      if (estConnecte)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Text(
                    estConnecte
                        ? (user!.email ?? "")
                        : "Utilisateur non connecté",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  if (estConnecte)
  Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 5,
    ),

    decoration: BoxDecoration(
      color: utilisateurVerifie
          ? Colors.green.withValues(alpha: 0.15)
          : const Color(0xFFD4AF37)
              .withValues(alpha: 0.15),

      borderRadius: BorderRadius.circular(20),
    ),

    child: Text(
      utilisateurVerifie
          ? "🟢 Vendeur vérifié"
          : "👑 Membre Royalis",

      style: TextStyle(
        color: utilisateurVerifie
            ? Colors.green
            : RoyalColors.primary,

        fontWeight: FontWeight.bold,

        fontSize: 12,
      ),
    ),
  ),

if (!estConnecte)
  Padding(
    padding: const EdgeInsets.only(top: 18),
    child: SizedBox(
      width: double.infinity,
      child: RoyalButton(
  text: "Se connecter",
  icon: Icons.login,
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    ).then((_) {
      setState(() {
        user = Supabase.instance.client.auth.currentUser;
      });
    });
  },
),
    ),
  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            //=========================================================
            // STATISTIQUES
            //=========================================================

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  buildStatCard(
                    "0",
                    "Articles",
                    Icons.inventory_2_outlined,
                  ),

                  buildStatCard(
                    "0",
                    "Enchères",
                    Icons.gavel_outlined,
                  ),

                  buildStatCard(
                    "0",
                    "Favoris",
                    Icons.favorite_outline,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            sectionTitre("Mon activité"),

            buildCardMenu(
              children: [

                buildTileMenu(
                  icon: Icons.chat_bubble_outline,
                  title: "Conversations",
                  onTap: () => ouvrirPageConnectee(
                    const ConversationsPage(),
                  ),
                ),

                const Divider(height: 1),

                buildTileMenu(
                  icon: Icons.inventory_2_outlined,
                  title: "Mes articles",
                  onTap: () => ouvrirPageConnectee(
                    const MesArticlesPage(),
                  ),
                ),

                const Divider(height: 1),

                buildTileMenu(
                  icon: Icons.gavel_outlined,
                  title: "Mes enchères gagnées",
                  onTap: () => ouvrirPageConnectee(
                    const MesEncheresPage(),
                  ),
                ),

                const Divider(height: 1),

                buildTileMenu(
                  icon: Icons.favorite_border,
                  title: "Mes favoris",
                  onTap: () => ouvrirPageConnectee(
                    const FavorisPage(),
                  ),
                ),

                const Divider(height: 1),

                buildTileMenu(
                  icon: Icons.notifications_none,
                  title: "Notifications",
                  onTap: () => ouvrirPageConnectee(
                    const NotificationsPage(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            sectionTitre("Compte"),

            buildCardMenu(
              children: [

                const Divider(height: 1),

                buildTileMenu(
  icon: Icons.verified_user_outlined,
  title: "Vérification d'identité",
  onTap: () => ouvrirPageConnectee(
    const VerificationIdentitePage(),
  ),
),

                const Divider(height: 1),

                buildTileMenu(
                  icon: Icons.settings_outlined,
                  title: "Paramètres",
                  onTap: () {},
                ),

                const Divider(height: 1),

ListTile(
  leading: Container(
    padding: const EdgeInsets.all(9),
    decoration: BoxDecoration(
  color: RoyalColors.text.withValues(alpha: .05),
  shape: BoxShape.circle,
),
    child: const Icon(
      Icons.dark_mode_rounded,
      color: Color(0xffD4AF37),
    ),
  ),

  title: const Text(
    "Mode sombre",
    style: TextStyle(
      fontWeight: FontWeight.w600,
    ),
  ),

  trailing: Switch(
    value: themeProvider.themeMode == ThemeMode.dark,

    onChanged: (value) {
      themeProvider.setThemeMode(
        value ? ThemeMode.dark : ThemeMode.light,
      );
    },
  ),
),
              ],
            ),

                        const SizedBox(height: 28),

            //=========================================================
            // DECONNEXION
            //=========================================================

            if (estConnecte)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.red.shade100,
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.logout_rounded,
                        color: Colors.red,
                      ),
                    ),
                    title: const Text(
                      "Déconnexion",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    subtitle: const Text(
                      "Se déconnecter du compte Royalis",
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () async {
                      await Supabase.instance.client.auth.signOut();

                      if (!context.mounted) return;

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  //=========================================================
  // TITRE DE SECTION
  //=========================================================

  Widget sectionTitre(String titre) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 8,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          titre,
          style: const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  letterSpacing: .5,
  color: RoyalColors.hint,
),
        ),
      ),
    );
  }

  //=========================================================
  // CARTE
  //=========================================================

  Widget buildCardMenu({
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  //=========================================================
  // STATISTIQUES
  //=========================================================

  Widget buildStatCard(
    String valeur,
    String titre,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color:RoyalColors.primary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: RoyalColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          valeur,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          titre,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  //=========================================================
  // MENU
  //=========================================================

  Widget buildTileMenu({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      leading: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: const Color(0xff1F2937).withValues(alpha: .05),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: RoyalColors.primary,
          size: 21,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xff1F2937),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15,
        color: Colors.grey.shade400,
      ),
      onTap: onTap,
    );
  }
}