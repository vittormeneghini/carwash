import 'package:flutter/material.dart';

class MessageBallon extends StatelessWidget {
  final String _msg;
  final String _from;
  final bool _isRight;

  const MessageBallon(this._msg, this._from, this._isRight);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5.0, 0.0, 5.0),
      child: Row(
        mainAxisAlignment: _isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: !_isRight ? [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: CircleAvatar(
              child: Icon(Icons.supervised_user_circle),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(_from), Text(_msg)],
          ),
        ] : [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Text(_from), Text(_msg)],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: CircleAvatar(
              child:Icon(Icons.supervised_user_circle),
            ),
          ),          
        ],
      ),
    );
  }
}
