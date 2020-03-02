import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/journal_entry.dart';
import 'screens/welcome.dart';
import 'screens/new_entry.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) => ThemeData(
        primarySwatch: Colors.indigo,
        brightness: brightness,
      ),
      // loadBrightnessOnStart: true,
      themedWidgetBuilder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
          routes: {
            '/home':(context) => MyHomePage(),
            '/createJournalEntry': (context) => JournalEntry(),
            '/welcome':(context) => WelcomeScreen(),
            '/journalEntry':(context) => JournalEntriesScreen(),
          },
          initialRoute: '/welcome',
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool darkMode = false;
  Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
      ),
      body: JournalEntriesScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pushNamed(context, '/createJournalEntry');},
        child: const Icon(Icons.add),
      ),

      endDrawer: Drawer(
        child: Container(
            child: DrawerHeader( padding: EdgeInsets.all(8.0), 
            child: SwitchListTile(
              title: Text('Dark Mode'), 
              // value: darkMode, 
              value: isDarkMode(context),
              onChanged: (bool value) { 
                setState(() {
                  changeBrightness();
                  darkMode = !isDarkMode(context);
            });} ), ),
          ),
      ),

    );
  }

  void showChooser() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BrightnessSwitcherDialog(
          onSelectedTheme: (Brightness brightness) {
            DynamicTheme.of(context).setBrightness(brightness);
          },
        );
      },
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
