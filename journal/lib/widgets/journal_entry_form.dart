import 'package:flutter/material.dart';
import '../db/database_manager.dart';
import '../db/journal_entry_dto.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


// import 'dropdown_rating_form_field.dart';
// import '../db/journal_entry_dto.dart';

class JournalEntryFields {
  String title;
  String body;
  DateTime dateTime;
  int rating;

  JournalEntryFields({this.title, this.body, this.rating, this.dateTime});
  String toString() {
    return 'Title: $title, Body: $body, Time: $dateTime, Rating: $rating';
  }
}

class JournalEntryForm extends StatefulWidget {

  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {

  final formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryFields();

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _ratingController = TextEditingController();

  
  final journalEntryValues = JournalEntryDTO();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              autofocus: true ,
              decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              onSaved: (value){
                //Store value in some object
                journalEntryFields.title = value;
              },
              validator: (value){
                if (value.isEmpty){
                  return 'Please enter a title';
                } else {
                  return null;
                }
              },
            ), 
            TextFormField(
              autofocus: true ,
              decoration: InputDecoration(labelText: 'Body', border: OutlineInputBorder()),
              onSaved: (value){
                //Store value in some object
                journalEntryFields.body = value;
              },
              validator: (value){
                if (value.isEmpty){
                  return 'Please enter a body';
                } else {
                  return null;
                }
              },
            ), 
            TextFormField(
              autofocus: true ,
              decoration: InputDecoration(labelText: 'Rating', border: OutlineInputBorder()),
              onSaved: (value){
                //Store value in some object
                journalEntryFields.title = value;
              },
              validator: (value){
                if (value.isEmpty){
                  return 'Please enter a Rating';
                } else {
                  return null;
                }
              },
            ), 
            
            SizedBox(height:10),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    _titleController.clear();
                    _bodyController.clear();
                    _ratingController.clear();
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()){
                      formKey.currentState.save();
                      // Database.(context).saveJournalEntry(journalEntryFields);
                      Navigator.of(context).pushNamed('/journalEntry');
                    }
                }, child: Text('Save Entry'),),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget ratingDropDown() {

  }

  Widget buttons(BuildContext context) {

  }

  Widget cancelButton(BuildContext context) {

  }

  Widget saveButton(BuildContext context) {
    return RaisedButton(
      child: Text('Save'),
      onPressed: () async {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          addDateToJournalEntryValues();
          final databaseManager = DatabaseManager.getInstance();
          // await deleteDatabase('journal.db');
          // var db = await openDatabase('journal.db');

          // final Database database = await openDatabase(
          //   'journal.db', version:1, onCreate: (Database db, int version) async {
          //     await db.execute(
          //       'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL, rating INTEGER NOT NULL, date TEXT NOT NULL);');
          //   }
          // );

          databaseManager.saveJournalEntry(dto: journalEntryValues);
          // await databaseManager.db.transaction((txn) async {
          //   await txn.rawInsert('INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?);',
          //   [journalEntryFields.title, journalEntryFields.body, journalEntryFields.rating, journalEntryFields.dateTime]
          //   );
          // });
          // await db.close();
          // await databaseManager.db.close();

          print('SAVE TO DATABASE?!');

          Navigator.of(context).pop();
        }
      },
    );
  }

  void addDateToJournalEntryValues() {
    journalEntryFields.dateTime = DateTime.now();
  }
}