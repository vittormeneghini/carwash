import 'package:carwashapp/core/models/favoriteModel.dart';
import 'package:carwashapp/core/servicesModels/favoriteService.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/userAuthenticatedService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/views/collaboratorServiceView/collaboratorProfileServiceView.dart';
import 'package:carwashapp/ui/widgets/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CardCollaborator extends StatefulWidget {
  String id;
  String image;
  String name;
  double stars;
  double price;
  String serviceId;
  String serviceCollaboratorId;

  CardCollaborator({this.serviceCollaboratorId, this.id, this.image, this.name, this.serviceId});

  @override
  _CardCollaboratorState createState() => _CardCollaboratorState(
    serviceCollaboratorId: serviceCollaboratorId,
      id: id, image: image, name: name, serviceId: serviceId);
}

class _CardCollaboratorState extends State<CardCollaborator> {
  String id;
  String image;
  String name;
  double stars;
  double price;
  String serviceId;
  IconData iconStar;
  String idFavorite;
  bool isFavorite = false;
  String serviceCollaboratorId;
  var serviceAuthenticated = UserAuthenticatedService();

  _CardCollaboratorState({this.serviceCollaboratorId, this.id, this.image, this.name, this.serviceId});

  var personService = locator<PersonService>();
  var favoriteService = locator<FavoriteService>();

  @override
  void initState() {
    prepareRate();
    prepareFavorite();
    super.initState();
  }

  Future<void> prepareRate() async {
    double _rate = await personService.calculateRates(id);
    setState(() {
      stars = _rate;
      iconStar = stars >= 5.0
          ? Icons.star
          : stars >= 2.5 ? Icons.star_half : Icons.star_border;
    });
  }

  Future<void> prepareFavorite() async {
    var user = await serviceAuthenticated.getCurrentUser();

    if (user == null) return;

    var person = await personService.getPersonByUid(user.uid);

    if(person == null)
      return;

    var favorite =
        await favoriteService.getFavoriteByCollaborator(id, person.id);

    if (favorite == null) return;

    setState(() {
      isFavorite = true;
      idFavorite = favorite.id;
    });
  }

  Future<FirebaseUser> sendToLogin() async {
    var currentUser = await serviceAuthenticated.getCurrentUser();
    if (currentUser == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginApp()));
    }

    return currentUser;
  }

  Future<void> setFavorite() async {
    var currentUser = await sendToLogin();

    if (currentUser != null) {
      var person = await personService.getPersonByUid(currentUser.uid);

      var _idFavorite = await favoriteService.setFavorite(FavoriteModel(
          dateFavorite: Timestamp.now(), personId: id, loggedId: person.id));

      setState(() {
        idFavorite = _idFavorite;
        isFavorite = true;
      });
    }
  }

  Future<void> unsetFavorite() async {
    var currentUser = await sendToLogin();

    await favoriteService.unSetFavorite(idFavorite);

    setState(() {
      idFavorite = null;
      isFavorite = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(onTap: (){
        Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CollaboratorProfileServiceView(idCollaboratorService: serviceCollaboratorId)));
      }, child: Card(        
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: ClipOval(
                  child: Container(
                    //color: Colors.grey.shade300,
                    width: 50,
                    height: 50,
                    child: Image.network(
                      image,
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
                      child: Text(name),
                    ),
                    price != null
                        ? Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            height: 18,
                            child: Text(price.toString()),
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      //color: Colors.grey.shade300,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              iconStar,
                              color: Colors.yellowAccent[700],
                            ),
                            Text(stars.toString())
                          ]),
                      height: 20,
                    ),
                  ],
                ),
              ),
              IconButton(
                iconSize: 18.0,
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 30.0),
                color: Colors.red,
                onPressed: () {
                  isFavorite ? unsetFavorite() : setFavorite();
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
