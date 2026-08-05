import 'package:supabase_flutter/supabase_flutter.dart';


class KycService {

  final supabase = Supabase.instance.client;


  Future<bool> utilisateurVerifie() async {

    final user = supabase.auth.currentUser;

    if (user == null) {
      return false;
    }


    final data = await supabase
        .from("kyc_verifications")
        .select("statut")
        .eq("user_id", user.id)
        .maybeSingle();


    if (data == null) {
      return false;
    }


    return data["statut"] == "approved";
  }

Future<bool> vendeurEstVerifie(String vendeurUid) async {

  final data = await supabase
      .from("kyc_verifications")
      .select("statut")
      .eq("user_id", vendeurUid)
      .maybeSingle();


  if (data == null) {
    return false;
  }


  return data["statut"] == "approved";
}

}