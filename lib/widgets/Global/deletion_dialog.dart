import 'package:Convene/services/global_service.dart';
import 'package:flutter/material.dart';

class DeletionDialog extends StatefulWidget {
  String collection;

  DeletionDialog(this.collection);

  @override
  _DeletionDialogState createState() => _DeletionDialogState();
}

class _DeletionDialogState extends State<DeletionDialog> {
  final _globalService = new GlobalService();
  @override
  Widget build(BuildContext context) {
    var words = widget.collection.split(" ");

    return AlertDialog(
      title: Text('Are you sure?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
                'You are about to permanenetly delete your ${widget.collection}.'),
            Text('Are you sure about this?'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Approve'),
          onPressed: () {
            _globalService.deletionService(context, words[words.length - 1]);
          },
        ),
      ],
    );
  }
}
