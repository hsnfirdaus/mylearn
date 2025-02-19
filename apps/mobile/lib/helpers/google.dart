import 'package:google_sign_in/google_sign_in.dart';

const webClientId =
    '169147575721-t03dk4endopr46ojc49edq90v2hjebk8.apps.googleusercontent.com';
const iosClientId =
    '169147575721-58rb6odr694sm0pp62hobkm2m7k56h8q.apps.googleusercontent.com';

final GoogleSignIn googleSignIn = GoogleSignIn(
  clientId: iosClientId,
  serverClientId: webClientId,
);
