import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:carwashapp/core/servicesModels/userAuthenticatedService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/widgets/headers/headers.dart';
import 'package:carwashapp/ui/widgets/mainWidget/mainScaffold.dart';
import 'package:carwashapp/ui/widgets/naviWidget/favorite.dart';
import 'package:carwashapp/ui/widgets/naviWidget/home.dart';
import 'package:carwashapp/ui/widgets/naviWidget/profile.dart';
import 'package:carwashapp/ui/widgets/naviWidget/search.dart';
import 'package:flutter/material.dart';
import '../../../core/models/serviceModel.dart';

class Navi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NaviState();
}

class NaviState extends State<Navi> {
  int selectedIndex = 0;
  List<Service> services = List<Service>();
  var serviceService = locator<ServiceService>();
  var personService = locator<PersonService>();
  var authenticatedService = UserAuthenticatedService();
  Person loggedPerson;

  Future<void> onchangedSearch(String text) async {
    List<Service> _services = List<Service>();
    if (text.length > 0)
      _services = await serviceService.fetchServicesByName(text);
    else
      _services = await serviceService.fetchServices();

    setState(() {
      services = _services;
    });
  }

  void changeSelect(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> getAllServices() async {
    var _services = await serviceService.fetchServices();
    setState(() {
      services = _services;
    });
  }

  Future<void> getUserLogged() async {
    var currentUser = await authenticatedService.getCurrentUser();

    if (currentUser == null) return;

    var _person = await personService.getPersonByUid(currentUser.uid);
    setState(() {
      loggedPerson = _person;
    });
  }

  @override
  void initState() {
    getUserLogged();
    getAllServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var naviOptions = [
      Home(),
      Favorite(),
      Search(services),
      Profile(loggedPerson)
    ];

    var homeIcon =
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home'));

    var favoriteIcon = BottomNavigationBarItem(
        icon: Icon(Icons.favorite), title: Text('Favoritos'));

    var searchIcon = BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
        ),
        title: Text('Pesquisa'));

    var perfilIcon = BottomNavigationBarItem(
        icon: Icon(Icons.person), title: Text('Perfil'));

    var menuNavi = BottomNavigationBar(
      items: [homeIcon, favoriteIcon, searchIcon, perfilIcon],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: changeSelect,
    );
    var headers = getHeaders(selectedIndex, onchangedSearch, loggedPerson);

    if (loggedPerson == null) {
      menuNavi.items.removeAt(1);
      naviOptions.removeAt(1);
      headers.removeAt(1);
    } else {
      if (loggedPerson != null && loggedPerson.type == "collaborator") {
        menuNavi.items.removeAt(1);
        naviOptions.removeAt(1);
        headers.removeAt(1);
        menuNavi.items.removeAt(1);
        naviOptions.removeAt(1);
        headers.removeAt(1);
      }
    }

    var mainScaffold = MainScaffold(
        personalizedAppBar: headers[selectedIndex],
        body: naviOptions[selectedIndex],
        bottomMenuNavigation: menuNavi);

    return mainScaffold;
  }
}
