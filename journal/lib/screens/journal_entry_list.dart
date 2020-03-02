import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../db/database_manager.dart';

import '../screens/journal_entry.dart';
// import '../screens/new_entry.dart';

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
    List<JournalEntry> journalEntries = await databaseManager.journalEntries();
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