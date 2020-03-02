

class JournalEntryDTO {

  String title;
  String body;
  int rating;
  DateTime dateTime;

  String toString() =>
  'Title: $title, Body: $body, Rating: $rating, Date: $dateTime';
}