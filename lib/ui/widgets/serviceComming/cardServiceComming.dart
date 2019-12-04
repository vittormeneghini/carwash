import 'package:carwashapp/core/models/contractViewModel.dart';
import 'package:carwashapp/ui/views/serviceView/chat.dart';
import 'package:flutter/material.dart';

class CardServiceComming extends StatefulWidget {
  ContractViewModel contractVw;
  CardServiceComming(this.contractVw);

  @override
  _CardServiceCommingState createState() =>
      _CardServiceCommingState(contractVw);
}

class _CardServiceCommingState extends State<CardServiceComming> {
  ContractViewModel contractVw;
  _CardServiceCommingState(this.contractVw);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
          onTap: contractVw.status == 'cancelled'
              ? null
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Chat(contractVw.idContract)));
                },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: ClipOval(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          contractVw.imageService,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 20,
                          child: Text(contractVw.nameService),
                        ),
                        contractVw.finalPrice != null
                            ? Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                height: 18,
                                child: Text(contractVw.finalPrice.toString()),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 18.0,
                    icon: Icon(
                        contractVw.status == 'talking'
                            ? Icons.message
                            : contractVw.status == 'pricing'
                                ? Icons.attach_money
                                : contractVw.status == 'cancelled'
                                    ? Icons.close
                                    : Icons.message,
                        size: 30.0),
                    color: Colors.green,
                    onPressed: contractVw.status == 'cancelled'
                        ? null
                        : () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Chat(contractVw.idContract)));
                          },
                    splashColor: Colors.red[50],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
