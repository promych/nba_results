import 'package:flutter/material.dart';

// TODO: Date selector in appbar

class DatePicker extends StatelessWidget {
  final bool isVisible;

  const DatePicker({Key key, this.isVisible = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isVisible ? Icon(Icons.date_range) : Container(),
      onPressed: () => _selectDate(context),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2020),
        builder: (BuildContext context, Widget child) {
          return child;
        });
    // if (picked != null) setState(() => _value = picked.toString());
  }
}
