import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/setting_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService.withoutUID().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                child: Row(
                  children: [
                    Icon(Icons.person),
                    Text("logout"),
                  ],
                )),
            TextButton(
              onPressed: () => _showSettingPanel(),
              child: Row(
                children: [
                  Icon(Icons.settings),
                  Text("Setting"),
                ],
              ),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
