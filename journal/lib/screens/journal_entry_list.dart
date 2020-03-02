import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../db/database_manager.dart';

import '../screens/journal_entry.dart';
import '../screens/new_entry.dart';

import '../screens/welcome.dart';

import '../models/journal.dart';
import '../models/journal_entry.dart';


class JournalEntryListScreen extends StatefulWidget {
  @override
  _JournalEntryListScreenState createState() => _JournalEntryListScreenState();
}

class _JournalEntryListScreenState extends State<JournalEntryListScreen> {

  Journal journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final databaseManager =DatabaseManager.getInstance();

    List<Map> journalRecords = await database.rawQuery('SELECT * from journal_entries;');
    final journalEntries = journalRecords.map( (record) {
      return JournalEntry(
        title: record['title'],
        body: record['body'],
        rating: record ['rating'],
        dateTime: DateTime.parse(record['date']));
    }).toList();
    print(journalEntries);
    setState(() {
      journal = Journal(entries: journalEntries);
    });
  }

  Widget build(BuildContext context) {
    return Container(
      
    );
  }

  Widget journalList(BuildContext context) {

  }

  FloatingActionButton addEntryFab(BuildContext context) {

  }

  void displayJournalEntryForm(BuildContext context) {
    
  }
}