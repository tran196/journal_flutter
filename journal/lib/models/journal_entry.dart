class JournalEntry {
  final String title;
  final String body; 
  final int rating;
  final DateTime dateTime;

  JournalEntry({this.title, this.body, this.rating, this.dateTime});
  
  String toString() {
    return 'Title: $title, Body: $body, Rating: $rating, Date: $dateTime';
  }
}