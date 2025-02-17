import 'package:flutter/material.dart';
import 'package:mylearn/components/layout/top_rounded_list.dart';
import 'package:mylearn/screen/home/home_top_bar.dart';
import 'package:mylearn/theme/theme_extension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Container(
      color: theme.primary,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          HomeTopBar(),
          TopRoundedList(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 12, left: 12, right: 12),
                      child: Text("Jadwal Hari Ini", style: theme.heading3),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.background200),
                        borderRadius: BorderRadius.circular(10),
                        color: theme.backgroundLighest,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "https://if.polibatam.ac.id/assets/backupold/img/dosen/supar.jpg",
                              height: 40,
                              width: 40,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pengantar Rekayasa Perangkat Lunak",
                                  style: theme.bodyText.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text("08.00 - 11.00", style: theme.metaText),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 42,
                              width: 42,
                              color: theme.primary,
                              child: Column(
                                children: [
                                  Text(
                                    "TA",
                                    style: TextStyle(
                                      color: theme.textLight,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "12.4",
                                    style: TextStyle(
                                      color: theme.textLight,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
