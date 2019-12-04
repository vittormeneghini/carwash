import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  AppBar appBar;
  Widget personalizedAppBar;
  Widget body;
  Widget bottomMenuNavigation;      
  MainScaffold(
      {this.appBar,
      this.personalizedAppBar,
      this.body,
      this.bottomMenuNavigation});


  existAppBar() {
    return appBar != null;
  }

  @override
  Widget build(BuildContext context) {
    var bodyScaffold = existAppBar()
        ? Container(child: body)
        : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            personalizedAppBar,
            Container(              
              child: body,
            )
          ]);

    return Scaffold(
        appBar: existAppBar() ? appBar : null,
        body: bodyScaffold,
        bottomNavigationBar: bottomMenuNavigation);
  }
}
