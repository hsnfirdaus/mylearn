import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/app_alert_dialog.dart';
import 'package:mylearn/helpers/google.dart';
import 'package:mylearn/router.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return ListView(
      children: [
        SizedBox(height: 8),
        ListItem(
          icon: LucideIcons.bookCheck,
          onTap: () => context.push(AppRoute.settingSubject),
          label: "Kelola Mata Kuliah",
        ),
        ListItem(
          icon: LucideIcons.logOut,
          onTap: () async {
            final result = await showDialog<bool>(
              context: context,
              builder:
                  (BuildContext context) => AppAlertDialog(
                    title: 'Apakah anda yakin?',
                    content: 'Anda akan keluar dari akun anda!',
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Batal'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: theme.deleteButton,
                        child: const Text('Keluar'),
                      ),
                    ],
                  ),
            );
            if (result == true) {
              try {
                await googleSignIn.disconnect();
                // ignore: empty_catches
              } catch (e) {}

              await Supabase.instance.client.auth.signOut();
            }
          },
          label: "Keluar",
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Material(
        child: ListTile(
          onTap: onTap,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 32,
              width: 32,
              color: theme.primary,
              child: Icon(icon, color: theme.textLight),
            ),
          ),
          splashColor: Colors.transparent,
          tileColor: theme.backgroundLighest,
          title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
