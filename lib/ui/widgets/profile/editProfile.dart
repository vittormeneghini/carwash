import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/userAuthenticatedService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/widgets/profile/profileCollaborator.dart';
import 'package:carwashapp/ui/widgets/profile/profileCostumer.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Person loggedPerson;
  bool isLoading = true;
  var personService = locator<PersonService>();
  var authService = UserAuthenticatedService();

  @override
  void initState() {
    _getLoggedPerson();
    super.initState();
  }

  Future<void> _getLoggedPerson() async {
    var _user = await authService.getCurrentUser();

    if (_user != null) {
      var _person = await personService.getPersonByUid(_user.uid);
      setState(() {
        loggedPerson = _person;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var returned = isLoading
        ? Center(child: CircularProgressIndicator())
        : loggedPerson != null
            ? loggedPerson.type == 'costumer'
                ? ProfileCostumer(loggedPerson)
                : ProfileCollaborator(loggedPerson)
            : Container();

    var scaffold = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: isLoading ? Text("") : Center(child: Text(loggedPerson.fullName)),
      ),
      body: returned,
    );

    return scaffold;
  }
}
