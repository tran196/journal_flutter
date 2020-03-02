import 'dart:async';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isSwitched = true;

  Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome'),
        actions: <Widget>[

        ],
      ),
      endDrawer: Drawer(
          child: Container(
            child: DrawerHeader( padding: EdgeInsets.all(8.0), 
            child: SwitchListTile(
              title: Text('Dark Mode'), 
              value: isDarkMode(context), 
              onChanged: (bool value) { 
                setState(() {
                  isSwitched = value;
                  changeBrightness();
            });} ), ),
          ),
      ),
      body: Container(child: Center(child: Icon(Icons.note, size:55.0,))),

      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pushNamed(context, '/createJournalEntry');},
        child: const Icon(Icons.add),
      ),
    );
  }


  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
  }

  bool isDarkMode (BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {return true;}
    else {return false;}
  }
}
