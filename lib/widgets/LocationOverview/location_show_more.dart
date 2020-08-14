import 'package:flutter/material.dart';
import 'package:Convene/models/global.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(
              "About the Venue",
              style: locationTypeListTitleStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Column(children: <Widget>[
              ConstrainedBox(
                  constraints: widget.isExpanded
                      ? new BoxConstraints()
                      : new BoxConstraints(maxHeight: 60.0),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: new Text(
                      widget.text,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  )),
              widget.isExpanded
                  ? new Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        new GestureDetector(
                            child: Text(
                              'Read More',
                              style: locationTypeListTitleStyle,
                            ),
                            onTap: () =>
                                setState(() => widget.isExpanded = true)),
                      ],
                    )
            ]),
          ),
        ],
      ),
    );
  }
}
