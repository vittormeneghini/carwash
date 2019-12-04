import 'package:carwashapp/ui/views/collaboratorServiceView/collaboratorServiceView.dart';
import 'package:flutter/material.dart';

class CardSearch extends StatefulWidget {
  String id;
  String image;
  String name;
  String description;

  CardSearch({this.id, this.image, this.name, this.description});
  @override
  _CardSearchState createState() => _CardSearchState(
      id: id, image: image, name: name, description: description);
}

class _CardSearchState extends State<CardSearch> {
  String id;
  String image;
  String name;
  String description;
  _CardSearchState({this.id, this.image, this.name, this.description});
  double patternHeight = 200.0;
  Color patternColor = Colors.grey.withOpacity(0.8);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onDoubleTap: () {
          setState(() {
            patternColor = Colors.lightBlue[50];
            patternHeight = 300.0;
          });
        },
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CollaboratorServiceView(serviceId: id)));
        },
        child: AnimatedContainer(
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: patternColor,
                  blurRadius: 20.0,
                  spreadRadius: 5.0,
                  offset: Offset(
                    10.0,
                    10.0,
                  ),
                )
              ]),
          padding: EdgeInsets.all(20.0),
          duration: Duration(seconds: 1),
          height: patternHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.network(
                  image,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(name,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Container(child: Text(description)))
            ],
          ),
        ));
  }
}
