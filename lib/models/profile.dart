class Profile {
  final String id;
  final String? email;
  final String? username;
  final String? nom;
  final String? prenom;
  final String? telephone;
  final String? ville;
  final String? description;
  final String? avatarUrl;
  final double note;
  final int nbVentes;
  final int nbAchats;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Profile({
    required this.id,
    this.email,
    this.username,
    this.nom,
    this.prenom,
    this.telephone,
    this.ville,
    this.description,
    this.avatarUrl,
    this.note = 0,
    this.nbVentes = 0,
    this.nbAchats = 0,
    this.createdAt,
    this.updatedAt,
  });


  factory Profile.fromJson(Map<String, dynamic> json) {

    return Profile(
      id: json['id'] ?? '',
      email: json['email'],
      username: json['username'],
      nom: json['nom'],
      prenom: json['prenom'],
      telephone: json['telephone'],
      ville: json['ville'],
      description: json['description'],
      avatarUrl: json['avatar_url'],
      note: (json['note'] ?? 0).toDouble(),
      nbVentes: json['nb_ventes'] ?? 0,
      nbAchats: json['nb_achats'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );

  }


  Map<String, dynamic> toJson(){

    return {

      'id': id,
      'email': email,
      'username': username,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'ville': ville,
      'description': description,
      'avatar_url': avatarUrl,
      'note': note,
      'nb_ventes': nbVentes,
      'nb_achats': nbAchats,

    };

  }


  String get nomComplet {

    if((prenom ?? '').isNotEmpty || (nom ?? '').isNotEmpty){

      return "${prenom ?? ''} ${nom ?? ''}".trim();

    }

    return username ?? email ?? "Utilisateur";

  }

}