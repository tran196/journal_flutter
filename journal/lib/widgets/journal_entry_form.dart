import 'package:flutter/material.dart';
import 'package:journal/widgets/dropdown_rating_form_field.dart';
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

  final db = DatabaseManager.getInstance();
  
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
            // TextFormField(
            //   autofocus: true ,
            //   decoration: InputDecoration(labelText: 'Rating', border: OutlineInputBorder()),
            //   onSaved: (value){
            //     //Store value in some object
            //     journalEntryFields.title = value;
            //   },
            //   validator: (value){
            //     if (value.isEmpty){
            //       return 'Please enter a Rating';
            //     } else {
            //       return null;
            //     }
            //   },
            // ), 

            DropdownRatingFormField(
              maxRating: 4, 
              onSaved: (value) {
                journalEntryFields.rating = value;
              },
              validator: (value){
                if (value < 1){
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
                      saveButton(context);
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
    return DropdownRatingFormField();
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

          databaseManager.saveJournalEntry(dto: journalEntryValues);

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