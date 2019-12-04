import 'package:carwashapp/ui/views/addServiceView/addServiceView.dart';
import 'package:flutter/material.dart';

class CardServiceCollaborator extends StatefulWidget {
  String nameService;
  String id;
  String time;
  String price;
  Function delete;
  CardServiceCollaborator(
      {this.id, this.price, this.time, this.nameService, this.delete});

  @override
  _CardServiceCollaboratorState createState() => _CardServiceCollaboratorState(
      id: id,
      price: price,
      time: time,
      nameService: nameService,
      delete: delete);
}

class _CardServiceCollaboratorState extends State<CardServiceCollaborator> {
  String nameService;
  String id;
  String time;
  String price;
  Function delete;
  bool isBinding = false;

  _CardServiceCollaboratorState(
      {this.id, this.price, this.time, this.nameService, this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(30.0),
        child: Card(
            child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.local_car_wash,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    nameService,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  )
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.all(5.0),
                              child: Row(children: [
                                Icon(
                                  Icons.watch_later,
                                  color: Colors.amber,
                                ),
                                Text(time)
                              ])),
                          Container(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    color: Colors.green,
                                  ),
                                  Text(price)
                                ],
                              ))
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                              size: 35.0,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddServiceView(id.trim())));
                            },
                          ),
                          isBinding
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : IconButton(
                                  icon: Icon(
                                    Icons.restore_from_trash,
                                    color: Colors.red,
                                    size: 35.0,
                                  ),
                                  onPressed: () async {
                                    await delete(id.trim());
                                    setState(() {
                                      isBinding = true;
                                    });
                                  },
                                )
                        ],
                      )
                    ]))));
  }
}
