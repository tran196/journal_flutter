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
              value: isSwitched, 
              onChanged: (bool value) { 
                setState(() {
                  isSwitched = value;
            });} ), ),
          ),
      ),
    );
  }

}

