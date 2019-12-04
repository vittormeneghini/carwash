import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/favoriteModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/models/serviceCollaboratorModel.dart';
import 'package:carwashapp/core/models/serviceModel.dart';
import 'package:carwashapp/core/servicesModels/contractService.dart';
import 'package:carwashapp/core/servicesModels/favoriteService.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/serviceCollaboratorService.dart';
import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:carwashapp/core/servicesModels/userAuthenticatedService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/views/serviceView/chat.dart';
import 'package:carwashapp/ui/widgets/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CollaboratorProfileServiceView extends StatefulWidget {
  String idCollaboratorService;
  CollaboratorProfileServiceView({this.idCollaboratorService});

  @override
  _CollaboratorProfileServiceViewState createState() =>
      _CollaboratorProfileServiceViewState(idCollaboratorService);
}

class _CollaboratorProfileServiceViewState
    extends State<CollaboratorProfileServiceView> {
  String idCollaboradorService;
  bool isLoading = true;
  bool isLogged = false;
  _CollaboratorProfileServiceViewState(this.idCollaboradorService);
  var personService = locator<PersonService>();
  var service = locator<ServiceService>();
  var collaboratorService = locator<ServiceCollaboratorService>();
  var favoriteService = locator<FavoriteService>();
  var serviceAuthenticated = UserAuthenticatedService();
  var contractService = locator<ContractService>();

  Person person;
  Service serviceModel;
  ServiceCollaboratorModel modelServiceCollaborator;
  int qtdLikes = 0;
  int qtdWash = 0;
  double rateStar = 0;
  String idFavorite;
  bool isFavorite;
  IconData iconStar;
  Person loggedPerson;

  @override
  void initState() {
    sendToLogin();
    getData();
    prepareRate();
    super.initState();
  }

  Future<FirebaseUser> sendToLogin() async {
    var currentUser = await serviceAuthenticated.getCurrentUser();

    bool _isLogged = currentUser != null;

    if (_isLogged) {
      var _personLogged = await personService.getPersonByUid(currentUser.uid);
      setState(() {
        loggedPerson = _personLogged;
      });
    }

    setState(() {
      isLogged = _isLogged;
    });

    return currentUser;
  }

  Future<void> setFavorite() async {
    var currentUser = await sendToLogin();

    if (currentUser != null) {
      var person = await personService.getPersonByUid(currentUser.uid);

      var _idFavorite = await favoriteService.setFavorite(FavoriteModel(
          dateFavorite: Timestamp.now(),
          personId: person.id,
          loggedId: person.id));

      setState(() {
        idFavorite = _idFavorite;
        isFavorite = true;
      });
    }
  }

  Future<void> prepareRate() async {
    double _rate = await personService.calculateRates(person.id);
    setState(() {
      rateStar = _rate;
      iconStar = rateStar >= 5.0
          ? Icons.star
          : rateStar >= 2.5 ? Icons.star_half : Icons.star_border;
    });
  }

  Future<void> unsetFavorite() async {
    await favoriteService.unSetFavorite(idFavorite);

    setState(() {
      idFavorite = null;
      isFavorite = false;
    });
  }

  Future<void> getData() async {
    var _colaboratorService = await collaboratorService
        .getServiceCollaboratorById(idCollaboradorService);
    var _person =
        await personService.getPersonById(_colaboratorService.collaboratorId);
    var _service = await service.getServiceById(_colaboratorService.serviceId);

    var _qtdFavorites = await favoriteService
        .getQtdFavoritesByCollaborator(_colaboratorService.collaboratorId);

    setState(() {
      person = _person;
      serviceModel = _service;
      modelServiceCollaborator = _colaboratorService;
      qtdLikes = _qtdFavorites;
      isLoading = false;
    });
  }

  Future<void> createContract() async {
    String id;
    var existContract =
        await contractService.existContract(person.id, loggedPerson.id);

    if (existContract == null) {
      var _contract = Contract(
          collaboratorId: person.id,
          serviceId: serviceModel.id,
          costumerId: loggedPerson.id,
          finalPrice: 0,          
          status: 'talking');
      id = await contractService.addContract(_contract);
    }
    else
    {
      id = existContract;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(id)));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Center(child: Text(person.fullName)),
              backgroundColor: Colors.blue,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    if (isLogged) {
                      isFavorite ? unsetFavorite() : setFavorite();
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginApp()));
                    }
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.all(50),
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () {},
                              iconSize: 50.0,
                              color: Colors.green,
                            ),
                          ),
                          Container(
                              child: ClipOval(
                            child: Container(
                              width: 150,
                              height: 150,
                              child: Image.network(
                                person.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {
                                if (isLogged) {
                                  createContract();
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginApp()));
                                }
                              },
                              color: Colors.yellowAccent[400],
                              iconSize: 50.0,
                            ),
                          ),
                        ],
                      )),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.attach_money,
                            size: 50.0, color: Colors.green),
                        Text(
                          modelServiceCollaborator.price,
                          style: TextStyle(fontSize: 25.0),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                      margin: EdgeInsets.all(50),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(13.0),
                            child: Column(children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.star_border),
                                onPressed: () {},
                                iconSize: 50.0,
                                color: Colors.yellowAccent[400],
                              ),
                              Text(
                                rateStar.toString(),
                                style: TextStyle(fontSize: 18.0),
                              )
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.all(13.0),
                            child: Column(children: [
                              IconButton(
                                icon: Icon(Icons.local_car_wash),
                                onPressed: () {},
                                iconSize: 50.0,
                                color: Colors.blue,
                              ),
                              Text(
                                qtdWash.toString(),
                                style: TextStyle(fontSize: 18.0),
                              )
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.all(13.0),
                            child: Column(children: [
                              IconButton(
                                icon: Icon(Icons.favorite),
                                onPressed: () {},
                                color: Colors.red,
                                iconSize: 50.0,
                              ),
                              Text(
                                qtdLikes.toString(),
                                style: TextStyle(fontSize: 18.0),
                              )
                            ]),
                          ),
                        ],
                      )),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ));
  }
}
