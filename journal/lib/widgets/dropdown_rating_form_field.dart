// (c) 2020 Yong Joseph Bakos. Use this freely.
// https://github.com/flutter/flutter/issues/27821
// Usage:
// DropdownRatingFormField(
//   maxRating: 4,
//   validator: (value) { /* ... */ },
//   onSaved: (value) { /* ... */ }
// );

import 'package:flutter/material.dart';

class DropdownRatingFormField extends StatefulWidget {

  final int maxRating;
  final void Function(dynamic) onSaved;
  final String Function(dynamic) validator;

  DropdownRatingFormField({Key key, this.maxRating, this.onSaved, this.validator}) : super(key: key);

  @override
  DropdownRatingFormFieldState createState() => DropdownRatingFormFieldState();
}

class DropdownRatingFormFieldState extends State<DropdownRatingFormField> {

  int selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: selectedValue,
        items:  ratingMenuItems(maxRating: widget.maxRating),
        onChanged: (value) {
          setState( () => selectedValue = value );
        },
        decoration: InputDecoration(
          labelText: 'Rating',
          border: OutlineInputBorder()
        ),
        validator: widget.validator,
         onSaved: widget.onSaved
      );
  }

  List<DropdownMenuItem> ratingMenuItems({int maxRating}) {
    return List<DropdownMenuItem>.generate(maxRating, (i) {
      return DropdownMenuItem(value: i+1, child: Text('${i+1}'));
    });
  }

}