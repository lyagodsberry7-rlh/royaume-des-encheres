import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/kyc_image_picker.dart';
import '../widgets/kyc_stepper.dart';
import '../widgets/kyc_textfield.dart';

class VerificationIdentitePage extends StatefulWidget {
  const VerificationIdentitePage({super.key});

  @override
  State<VerificationIdentitePage> createState() =>
      _VerificationIdentitePageState();
}

class _VerificationIdentitePageState
    extends State<VerificationIdentitePage> {
  final _formKey = GlobalKey<FormState>();

  final supabase = Supabase.instance.client;

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final numeroController = TextEditingController();
  final dateController = TextEditingController();

  final picker = ImagePicker();

  DateTime? dateNaissance;

  String typeDocument = "Carte nationale";

  File? recto;
  File? verso;
  File? selfie;

  bool chargement = false;

  bool dejaUneDemande = false;

  String? statut;

  String? commentaireAdmin;

  @override
void initState() {
  super.initState();
  verifierKyc();
}

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    numeroController.dispose();
    dateController.dispose();
    super.dispose();
  }

Future<void> verifierKyc() async {
  final user = supabase.auth.currentUser;

  if (user == null) return;

  final data = await supabase
      .from("kyc_verifications")
      .select()
      .eq("user_id", user.id)
      .maybeSingle();

  if (data != null) {
    setState(() {
      dejaUneDemande = true;
      statut = data["statut"] as String?;
commentaireAdmin = data["commentaire_admin"] as String?;
    });
  }
}

  Future<void> choisirDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime(2000),
    );

    if (date == null) return;

    setState(() {
      dateNaissance = date;

      dateController.text =
          "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
    });
  }

  Future<void> choisirImage(String type) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Prendre une photo"),
                onTap: () =>
                    Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choisir dans la galerie"),
                onTap: () =>
                    Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (source == null) return;

    final image = await picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (image == null) return;

    setState(() {
      switch (type) {
        case "recto":
          recto = File(image.path);
          break;

        case "verso":
          verso = File(image.path);
          break;

        case "selfie":
          selfie = File(image.path);
          break;
      }
    });
  }

  Future<String> uploadImage(
    File fichier,
    String nom,
  ) async {
    final user = supabase.auth.currentUser!;

    final chemin =
        "${user.id}/$nom";

    await supabase.storage
        .from("kyc-documents")
        .upload(
          chemin,
          fichier,
          fileOptions: const FileOptions(
            upsert: true,
          ),
        );

    return chemin;
  }

  Future<void> envoyer() async {
    if (!_formKey.currentState!.validate()) return;

    if (dateNaissance == null ||
        recto == null ||
        verso == null ||
        selfie == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Veuillez compléter toutes les étapes.",
          ),
        ),
      );
      return;
    }

    setState(() {
      chargement = true;
    });

    try {
      final user = supabase.auth.currentUser!;

      final rectoPath =
          await uploadImage(recto!, "recto.jpg");

      final versoPath =
          await uploadImage(verso!, "verso.jpg");

      final selfiePath =
          await uploadImage(selfie!, "selfie.jpg");

      await supabase
          .from("kyc_verifications")
          .insert({
        "user_id": user.id,
        "nom": nomController.text.trim(),
        "prenom": prenomController.text.trim(),
        "numero_document":
            numeroController.text.trim(),
        "date_naissance":
            dateNaissance!
                .toIso8601String()
                .split("T")
                .first,
        "type_document":
            typeDocument,
        "recto_url":
            rectoPath,
        "verso_url":
            versoPath,
        "selfie_url":
            selfiePath,
        "statut":
            "pending",
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Votre demande a été envoyée.",
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    if (mounted) {
      setState(() {
        chargement = false;
      });
    }
  }

    @override
  Widget build(BuildContext context) {

if (dejaUneDemande) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Vérification d'identité"),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [

    Icon(
      statut == "approved"
          ? Icons.verified
          : statut == "pending"
              ? Icons.hourglass_top
              : Icons.cancel,
      size: 70,
      color: statut == "approved"
          ? Colors.green
          : statut == "pending"
              ? Colors.orange
              : Colors.red,
    ),

    const SizedBox(height: 20),


    Text(
      statut == "approved"
          ? "Votre identité est vérifiée."
          : statut == "pending"
              ? "Votre demande est en cours d'analyse."
              : "Votre demande a été refusée.",
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),


    const SizedBox(height: 15),


    if (statut == "pending")
      const Text(
        "Notre équipe examine actuellement vos documents.\n"
        "Vous recevrez une notification après validation.",
        textAlign: TextAlign.center,
      ),


    if (statut == "approved")
      const Text(
        "Félicitations ! Votre compte possède maintenant "
        "le badge vendeur vérifié.",
        textAlign: TextAlign.center,
      ),


    if (statut == "rejected")
      Column(
        children: [

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Motif :\n"
              "${commentaireAdmin ?? "Aucun motif indiqué"}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),


          const SizedBox(height: 20),


          ElevatedButton.icon(
            onPressed: () {

              setState(() {
                dejaUneDemande = false;

                nomController.clear();
                prenomController.clear();
                numeroController.clear();
                dateController.clear();

                recto = null;
                verso = null;
                selfie = null;

              });

            },

            icon: const Icon(
              Icons.refresh,
            ),

            label: const Text(
              "Soumettre une nouvelle demande",
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFFD4AF37),
              foregroundColor:
                  Colors.white,
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

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        title: const Text("Vérification d'identité"),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [

              const KycStepper(
                currentStep: 2,
              ),

              const SizedBox(height: 10),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Informations personnelles",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      KycTextField(
                        label: "Nom",
                        icon: Icons.person_outline,
                        controller: nomController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return "Veuillez saisir votre nom";
                          }
                          return null;
                        },
                      ),

                      KycTextField(
                        label: "Prénom",
                        icon: Icons.badge_outlined,
                        controller: prenomController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return "Veuillez saisir votre prénom";
                          }
                          return null;
                        },
                      ),

                      KycTextField(
                        label: "Date de naissance",
                        icon: Icons.calendar_month_outlined,
                        controller: dateController,
                        readOnly: true,
                        onTap: choisirDate,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Choisissez une date";
                          }
                          return null;
                        },
                      ),

                      KycTextField(
                        label: "Numéro du document",
                        icon: Icons.credit_card,
                        controller: numeroController,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return "Numéro obligatoire";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 8),

                      DropdownButtonFormField<String>(
                        initialValue: typeDocument,
                        decoration: InputDecoration(
                          labelText: "Type de document",
                          prefixIcon: const Icon(
                            Icons.assignment_ind_outlined,
                            color: Color(0xFFD4AF37),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Carte nationale",
                            child: Text("Carte nationale"),
                          ),
                          DropdownMenuItem(
                            value: "Passeport",
                            child: Text("Passeport"),
                          ),
                          DropdownMenuItem(
                            value: "Permis de conduire",
                            child: Text("Permis de conduire"),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;

                          setState(() {
                            typeDocument = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              KycImagePicker(
                titre: "Recto du document",
                description:
                    "Prenez une photo nette du recto.",
                image: recto,
                onTap: () => choisirImage("recto"),
              ),

              KycImagePicker(
                titre: "Verso du document",
                description:
                    "Prenez une photo nette du verso.",
                image: verso,
                onTap: () => choisirImage("verso"),
              ),

              KycImagePicker(
                titre: "Selfie",
                description:
                    "Prenez un selfie bien éclairé.",
                image: selfie,
                onTap: () => choisirImage("selfie"),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: chargement
                      ? null
                      : envoyer,
                  icon: chargement
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.verified_user,
                        ),
                  label: Text(
                    chargement
                        ? "Envoi en cours..."
                        : "Envoyer ma demande",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFD4AF37),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}