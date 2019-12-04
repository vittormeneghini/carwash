import 'package:flutter/material.dart';

class DialogUtil {
  
  void show({title,
      bodyText,
      closeText,
      acceptText,
      acceptFuncion,
      buildContext}) {
    showDialog(
        context: buildContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(bodyText),
            actions: <Widget>[
              FlatButton(
                child: Text(closeText),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(acceptText),
                onPressed: () {
                  acceptFuncion();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
