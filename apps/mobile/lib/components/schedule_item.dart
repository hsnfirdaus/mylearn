import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mylearn/components/lecturer_avatar.dart';
import 'package:mylearn/theme/theme_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({super.key, required this.item});

  final PostgrestMap item;

  Future<void> _launchUrl(String url) async {
    final Uri parsedUrl = Uri.parse(url);

    if (!await launchUrl(parsedUrl)) {
      throw Exception('Could not launch $parsedUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    final hasRoomOrLink =
        (item['room_code'] != null && item['room_code'] != "") ||
        (item['zoom_link'] != null && item['zoom_link'] != "");

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.background200),
        borderRadius: BorderRadius.circular(10),
        color: theme.backgroundLighest,
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LecturerAvatar(url: item['lecturer_photo_url']),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['subject_name'],
                  style: theme.bodyText.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '${(item['start_time'] as String).substring(0, 5)} - ${(item['end_time'] as String).substring(0, 5)}',
                  style: theme.metaText,
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          hasRoomOrLink
              ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 42,
                  width: 42,
                  color: theme.primary,
                  child: Builder(
                    builder: (context) {
                      if (item['room_code'] == null ||
                          item['room_code'] == "") {
                        return Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () => _launchUrl(item['zoom_link']),
                            child: Icon(
                              LucideIcons.video,
                              color: theme.textLight,
                            ),
                          ),
                        );
                      }
                      final splitted = (item['room_code'] as String).split(" ");
                      if (splitted.length < 2) {
                        return Text(
                          item['room_code'],
                          style: TextStyle(
                            color: theme.textLight,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        );
                      }
                      return Column(
                        children: [
                          Text(
                            splitted[0],
                            style: TextStyle(
                              color: theme.textLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            splitted[1],
                            style: TextStyle(
                              color: theme.textLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }
}
