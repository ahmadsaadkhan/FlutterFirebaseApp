import 'package:MyDevAppFirebase/screens/home/setting_form.dart';
import 'package:MyDevAppFirebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:MyDevAppFirebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:MyDevAppFirebase/screens/home/brew_list.dart';
import 'package:MyDevAppFirebase/models/brew.dart';

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
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew Crew'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Logout')),
            FlatButton.icon(
              onPressed: () => _showSettingPanel(),
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )),
            child: BrewList()),
      ),
    );
  }
}
