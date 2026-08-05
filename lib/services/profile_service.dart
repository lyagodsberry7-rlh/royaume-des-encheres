import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile.dart';


class ProfileService {


  static final SupabaseClient supabase =
      Supabase.instance.client;



  // Récupérer le profil connecté

  static Future<Profile?> getMyProfile() async {


    final user = supabase.auth.currentUser;


    if(user == null){
      return null;
    }


    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();


    if(response == null){

      return await createProfile();

    }


    return Profile.fromJson(response);


  }





  // Création automatique du profil

  static Future<Profile?> createProfile() async {


    final user = supabase.auth.currentUser;


    if(user == null){
      return null;
    }


    final data = {


      'id': user.id,

      'email': user.email,

      'username':
      user.userMetadata?['username']
          ??
      user.email!.split('@').first,


      'nb_ventes':0,

      'nb_achats':0,

      'note':0,


    };


    final result = await supabase
        .from('profiles')
        .insert(data)
        .select()
        .single();


    return Profile.fromJson(result);


  }





  // Modifier profil

  static Future<void> updateProfile({

    required Map<String,dynamic> data,

  }) async {


    final user = supabase.auth.currentUser;


    if(user == null){
      throw Exception("Utilisateur non connecté");
    }



    await supabase
        .from('profiles')
        .update(data)
        .eq('id', user.id);


  }





  // Déconnexion

  static Future<void> logout() async {

    await supabase.auth.signOut();

  }


}