import 'package:flutter/material.dart';

class CardHome extends StatefulWidget {
  String categoryId;
  String image;
  String title;
  String description;

  CardHome({this.categoryId, this.image, this.title, this.description});

  @override
  _CardHomeState createState() => _CardHomeState(
      categoryId: categoryId,
      image: image,
      title: title,
      description: description);
}

class _CardHomeState extends State<CardHome> {
  String categoryId;
  String image;
  String title;
  String description;
  _CardHomeState({this.categoryId, this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        splashColor: Colors.lightBlue[200],
        child: Container(
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.all(5.0),
                  height: 70,
                  color: Colors.transparent,
                  child: Container(
                      width: 100.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(image)),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.redAccent,
                      ))),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  Text(description)
                ],
              )),
              FlatButton(
                  onPressed: () {},
                  child: Text("Ver mais"),
                  textColor: Colors.white,
                  color: Colors.lightBlue[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)))
            ],
          ),
        ));
  }
}
