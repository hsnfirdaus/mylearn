import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mylearn/helpers/google.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    void showError(String message) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    Future doSignIn() async {
      try {
        final googleUser = await googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        final accessToken = googleAuth.accessToken;
        final idToken = googleAuth.idToken;

        if (accessToken == null) {
          throw 'No Access Token found.';
        }
        if (idToken == null) {
          throw 'No ID Token found.';
        }

        return supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );
      } catch (e) {
        showError(e.toString());
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: theme.background,
      ),
      child: Container(
        color: theme.background,
        child: SafeArea(
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image(
                        image: AssetImage('assets/illustration.jpeg'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 12,
                      children: [
                        Text(
                          "Selamat Datang di Aplikasi MyLearn!",
                          style: context.appTheme.heading1,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Masuk menggunakan akun Google anda untuk mulai menggunakan aplikasi.",
                          style: theme.bodyText,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
                          return doSignIn();
                        }

                        await supabase.auth.signInWithOAuth(
                          OAuthProvider.google,
                        );
                      },
                      child: Text(
                        "Masuk Dengan Google",
                        style: theme.buttonText,
                      ),
                    ),
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
