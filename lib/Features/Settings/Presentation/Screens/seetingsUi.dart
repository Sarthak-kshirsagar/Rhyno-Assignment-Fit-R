import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/settingsProvder.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Background Music',style: TextStyle(
              fontWeight: FontWeight.bold,fontSize:15
            ),),
            Container(
              width: 50,
              height: 50,
              child: Switch(
                splashRadius: 1,

                value: settingsProvider.backgroundMusicEnabled,
                onChanged: (value) {
                  settingsProvider.setBackgroundMusicSetting(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
