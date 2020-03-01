import 'package:flutter/material.dart';

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

  
  // final journalEntryValues = JournalEntryDTO();

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
            
            SizedBox(height:10),
            RaisedButton(
              onPressed: () {
                if (formKey.currentState.validate()){
                  formKey.currentState.save();
                  // Database.of(context).saveJournalEntry(journalEntryFields);
                  Navigator.of(context).pop();
                }
              
            }, child: Text('Save Entry'),)
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
          await deleteDatabase('journal.db');
          // var db = await openDatabase('journal.db');

          final Database database = await openDatabase(
            'journal.db', version:1, onCreate: (Database db, int version) async {
              await db.execute(
                'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, rating INT, date DATETIME');
            }
          );

          await database.transaction((txn) async {
            await txn.rawInsert('INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)',
            // [journalEntryValues.title, journalEntryValues.body, journalEntryValues.rating, journalEntryValues.date]
            );
          });
          // await db.close();
          await database.close();

          print('SAVE TO DATABASE?!');

          Navigator.of(context).pop();
        }
      },
    );
  }

  void addDateToJournalEntryValues() {
    // journalEntryValues.dateTime = DateTime.now();
  }
}