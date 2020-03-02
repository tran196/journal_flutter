import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import 'package:journal/widgets/journal_entry_form.dart';

class JournalEntry extends StatefulWidget {
  @override
  JournalEntryState createState() => JournalEntryState();
}

class JournalEntryState extends State<JournalEntry> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _ratingController = TextEditingController();

  bool darkMode = false;
  Brightness brightness;


  // Widget build (BuildContext context) {
  //   return Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     appBar: AppBar(title: Text('Journal Entry'),),
  //     body: SafeArea(
  //       child: ListView(
  //         padding: EdgeInsets.symmetric(horizontal: 24.0),
  //         children: <Widget>[
  //           SizedBox(height: 20.0),
  //           Column(
  //             children: <Widget>[
  //               SizedBox(height: 16.0),
  //               Text('Create New Event', 
  //                     style: const TextStyle(fontSize: 36.0),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 50.0),
  //           // [Event Name]
  //           TextField(
  //             controller: _titleController,
  //             decoration: InputDecoration(
  //               filled: true,
  //               labelText: 'Title',
  //             ),
  //           ),
  //           // spacer
  //           SizedBox(height: 12.0),
  //           // [Event Location]
  //           TextField(
  //             controller: _bodyController,
  //             decoration: InputDecoration(
  //               filled: true,
  //               labelText: 'Body',
  //             ),
  //             obscureText: false,
  //           ),
  //           SizedBox(height: 12.0),
  //           // [Event Date]
  //           TextField(
  //             controller: _ratingController,
  //             decoration: InputDecoration(
  //               filled: true,
  //               labelText: 'Rating',
  //             ),
  //             obscureText: false,
  //           ),
  //           SizedBox(height: 12.0),

  //           ButtonBar(
  //             children: <Widget>[
  //               FlatButton(
  //                 child: Text('CANCEL'),
  //                 onPressed: () {
  //                   _titleController.clear();
  //                   _bodyController.clear();
  //                   _ratingController.clear();
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //               RaisedButton(
  //                 child: Text('SAVE'),
  //                 onPressed: () {
  //                   Navigator.pushNamed(context, '/home');
  //                 },
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //     endDrawer: Drawer(
  //       child: Container(
  //           child: DrawerHeader( padding: EdgeInsets.all(8.0), 
  //           child: SwitchListTile(
  //             title: Text('Dark Mode'), 
  //             value: darkMode, 
  //             onChanged: (bool value) { 
  //               setState(() {
  //                 changeBrightness();
  //                 darkMode = !isDarkMode(context);
  //           });} ), ),
  //         ),
  //     ),
  //     );
  // }


  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: JournalEntryForm(),

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