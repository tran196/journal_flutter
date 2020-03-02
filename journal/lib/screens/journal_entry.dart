import 'package:flutter/material.dart';
import 'package:journal/widgets/journal_entry_form.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

import 'package:path/path.dart';

class JournalEntriesScreen extends StatelessWidget {

  static const routeKey = 'journal_entries';
  final database = openDatabase('../db/database.dart');

  // A method that retrieves all the dogs from the dogs table.
  Future<List<JournalEntryFields>> entries() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The JournalEntries.
    final List<Map<String, dynamic>> maps = await db.query('SELECT * FROM journal_entries;');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return JournalEntryFields(
        title: maps[i]['title'],
        body: maps[i]['body'],
        rating: maps[i]['rating'],
        dateTime: maps[i]['dateTime']
      );
    });
  }

  final items = List<Map>.generate(10000, (i) {
    return {
      'title': 'Journal Entry $i',
      'subtitle': 'Subtitle text for $i',
    };


  // final items = entries();

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar (title: Text('Journal Entries'),) ,
      body: ListView.builder( itemBuilder: (context, index) {
        return ListTile(
            leading:  FlutterLogo(),
            trailing: Icon(Icons.more_horiz),
            // title: Text('Journal Entry ${items[index]['title']}'),
            // subtitle: Text('Example ${items[index]['subtitle']}'),
            // title: Text('{entries[i]['title']}'),
            // subtitle: Text('Example ${entries[i]['subtitle']}'),
        );
      })
    );
  }
}