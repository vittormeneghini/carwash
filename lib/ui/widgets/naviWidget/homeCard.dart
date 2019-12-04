import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  Widget carrousel;
  String title;
  Function onPressed;
  HomeCard({this.carrousel, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 14.0, bottom: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18.0),
                ),
                margin: EdgeInsets.only(left: 10.0),
              ),
              FlatButton(
                  child: Text(
                    "Ver mais",
                    style: TextStyle(color: Colors.red[300]),
                  ),
                  onPressed: onPressed)
            ],
          ),
          carrousel
        ],
      ),
    );
  }
}
