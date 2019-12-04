import 'package:carwashapp/core/models/categoryModel.dart';
import 'package:carwashapp/core/models/favoriteModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/models/serviceModel.dart';
import 'package:carwashapp/core/servicesModels/categoryService.dart';
import 'package:carwashapp/core/servicesModels/favoriteService.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:carwashapp/locator.dart';
import 'package:flutter/material.dart';

class CardFavoriteCollaborator extends StatefulWidget {
  FavoriteModel favorite;
  String collaboratorId;
  CardFavoriteCollaborator({this.favorite, this.collaboratorId});

  @override
  _CardFavoriteCollaboratorState createState() =>
      _CardFavoriteCollaboratorState(
          collaboratorId: collaboratorId, favorite: favorite);
}

class _CardFavoriteCollaboratorState extends State<CardFavoriteCollaborator> {  
  var personService = locator<PersonService>();  
  var favoriteService = locator<FavoriteService>();

  FavoriteModel favorite;
  String collaboratorId;
  Person collaborator;
  double rate = 0;

  _CardFavoriteCollaboratorState({this.favorite, this.collaboratorId});

  @override
  void initState() {
    getService();
    super.initState();
  }

  getService() async {
    var _person = await personService.getPersonById(collaboratorId);
    setState(() {
      collaborator = _person;
    });
  }

  @override
  Widget build(BuildContext context) {
    validateScreen() => collaborator != null;

    return validateScreen()
        ? Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: Offset(1.0, 6.0),
                  ),
                ],
                border: Border.all(color: Colors.grey[100], width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  width: 100.0,
                  height: 100.0,
                  child: FittedBox(
                    child: Image.network(collaborator.image),
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 9.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            collaborator.fullName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              rate >= 2.5
                                  ? Icons.star_half
                                  : rate >= 5 ? Icons.star : Icons.star_border,
                              color: Colors.yellow[800],
                            ),
                            Container(
                              child: Text("$rate"),
                              padding: EdgeInsets.only(right: 5.0),
                            ),
                            Container(
                              child: Icon(
                                Icons.remove_circle,
                                size: 5.0,
                                color: Colors.black,
                              ),
                              padding: EdgeInsets.only(right: 2.0),
                            ),                            
                          ],
                        )),
                        Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.remove_circle,
                                    size: 5.0,
                                    color: Colors.black,
                                  ),
                                  padding: EdgeInsets.only(right: 3.0),
                                ),                                
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
                IconButton(
                  splashColor: Colors.red[200],
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red[600],
                  ),
                  onPressed: () async {
                    await favoriteService.unSetFavorite(favorite.id);
                  },
                ),
              ],
            ),
          )
        : Container(
            child: Center(child: CircularProgressIndicator()),
            margin: EdgeInsets.all(20.0),
          );
  }
}
