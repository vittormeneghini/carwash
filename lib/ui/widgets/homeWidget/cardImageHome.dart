import 'package:flutter/material.dart';

class CardImageHome extends StatefulWidget {
  @override
  _CardImageHomeState createState() => _CardImageHomeState();
}

class _CardImageHomeState extends State<CardImageHome> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Container(
            margin: EdgeInsets.all(5.0),
            height: 200,
            color: Colors.transparent,
            child: Container(
                width: 100.0,
                height: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://st4.depositphotos.com/1007566/19698/v/1600/depositphotos_196988112-stock-illustration-people-car-service.jpg')),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.redAccent,
                ))),
        onTap: () {},
        splashColor: Colors.grey,
      ),
    );
  }
}
