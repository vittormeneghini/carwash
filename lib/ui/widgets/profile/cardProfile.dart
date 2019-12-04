import 'package:flutter/material.dart';

class CardProfile extends StatefulWidget {
  IconData icon;
  String title;
  Function onPressed;

  CardProfile({this.icon, this.title, this.onPressed});

  @override
  _CardProfileState createState() =>
      _CardProfileState(icon: icon, title: title, onPressed: onPressed);
}

class _CardProfileState extends State<CardProfile> {
  IconData icon;
  String title;
  Function onPressed;

  _CardProfileState({this.icon, this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
            onTap: () {},
            splashColor: Colors.lightBlue[100],
            enableFeedback: true,
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [                  
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 5,
                    offset: Offset(0, 7),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(
                        icon,
                        color: Colors.blueAccent[700],
                        size: 28.0,
                      )),
                  Expanded(
                      child: Text(
                    title,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                  )),
                  Container(
                      padding: EdgeInsets.all(20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blueAccent[700],
                          size: 20.0,
                        ),
                        onPressed: onPressed,
                        splashColor: Colors.lightBlue[100],
                      ))
                ],
              ),
            )));
  }
}
