import 'package:carwashapp/core/models/favoriteModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/models/serviceModel.dart';
import 'package:carwashapp/core/servicesModels/favoriteService.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/serviceCollaboratorService.dart';
import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:carwashapp/core/servicesModels/userAuthenticatedService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/shareds/fades/fadeIn.dart';
import 'package:carwashapp/ui/widgets/collaboratorService/cardCollaborator.dart';
import 'package:carwashapp/ui/widgets/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoadCardCollaborator extends StatefulWidget {
  String serviceId;
  LoadCardCollaborator({this.serviceId});

  @override
  _LoadCardCollaboratorState createState() =>
      _LoadCardCollaboratorState(serviceId: serviceId);
}

class _LoadCardCollaboratorState extends State<LoadCardCollaborator> {
  String serviceId;
  _LoadCardCollaboratorState({this.serviceId});
  var _service = locator<ServiceService>();
  var _serviceCollaborator = locator<ServiceCollaboratorService>();
  var _colaboratorService = locator<PersonService>();
  var _favoriteService = locator<FavoriteService>();
  List<Person> collaborators = List<Person>();
  bool isFavorite = false;
  String favoriteId;
  var authenticatedService = UserAuthenticatedService();
  Service serviceModel;

  @override
  void initState() {
    _getService();
    prepareFavorite();
    super.initState();
  }

  Future<void> prepareFavorite() async {
    var user = await authenticatedService.getCurrentUser();

    if (user == null) return;

    var person = await _colaboratorService.getPersonByUid(user.uid);


    if(person == null) return;
    var favorite =
        await _favoriteService.getFavoriteByService(serviceId, person.id);

    if (favorite == null) return;

    setState(() {
      isFavorite = true;
      favoriteId = favorite.id;
    });
  }

  Future<FirebaseUser> sendToLogin() async {
    var currentUser = await authenticatedService.getCurrentUser();
    if (currentUser == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginApp()));
    }

    return currentUser;
  }

  Future<void> setFavorite() async {
    var currentUser = await sendToLogin();

    var person = await _colaboratorService.getPersonByUid(currentUser.uid);

    if(person == null)
      return;

    if(currentUser != null){
      var id = await _favoriteService.setFavorite(FavoriteModel(dateFavorite: Timestamp.now(), loggedId: person.id, serviceId: serviceId));
      setState(() {
        isFavorite = true;
        favoriteId = id;
      });
    }

  }

  Future<void> unsetFavorite() async {
    await _favoriteService.unSetFavorite(favoriteId);
    setState(() {
      isFavorite = false;
      favoriteId = null;
    });
  }

  Future<void> _getService() async {
    var _serviceModel = await _service.getServiceById(serviceId);

    var collaboratorsService = await _serviceCollaborator
        .fetchServicesCollaboratorsByService(serviceId);

    List<Person> auxCollaborator = List<Person>();
    for (var item in collaboratorsService) {
      var colaborator =
          await _colaboratorService.getPersonById(item.collaboratorId);
          colaborator.collaboratorService = item.id;
      auxCollaborator.add(colaborator);
    }

    setState(() {
      collaborators = auxCollaborator;
      serviceModel = _serviceModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: serviceModel == null
          ? Center(child: CircularProgressIndicator())
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                        onPressed: () {
                          isFavorite ? unsetFavorite() : setFavorite();
                        },
                      )
                    ],
                    backgroundColor: Colors.blue,
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(serviceModel.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                        background: Image.network(
                          serviceModel.image,
                          fit: BoxFit.cover,
                          color: Colors.blue.withOpacity(1.0),
                          colorBlendMode: BlendMode.softLight,
                        )),
                  ),
                ];
              },
              body: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                    children: collaborators
                        .map((item) => FadeIn(
                            4,
                            CardCollaborator(
                              serviceCollaboratorId: item.collaboratorService,
                              id: item.id,
                              image: item.image,
                              name: item.fullName,
                              serviceId: serviceModel.id,
                            )))
                        .toList()),
              ),
            ),
    );
  }
}
