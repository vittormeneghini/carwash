import 'package:carwashapp/core/models/personModel.dart';
import 'package:flutter/material.dart';

class HeaderUnloggedProfile extends StatelessWidget {
  Person loggedPerson;
  HeaderUnloggedProfile({this.loggedPerson});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      color: Colors.blue,
      height: 120.0,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15.0),
            width: 60.0,
            height: 60.0,
            child: loggedPerson == null ? CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 30.0,
                ),
                onPressed: () {},
              ),
            ) : Container(
              child: ClipOval(
            child: Container(
              width: 100,
              height: 50,
              child: Image.network(
                loggedPerson.image,
                fit: BoxFit.cover,
              ),
            ),
          )),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      loggedPerson == null ? "Olá Visitante!" : loggedPerson.fullName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                  )                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
