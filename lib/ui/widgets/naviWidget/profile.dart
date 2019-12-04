import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/ui/widgets/profile/loggedProfile.dart';
import 'package:carwashapp/ui/widgets/profile/unloggedProfile.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget
{
  Person person;
  Profile(this.person);

  @override
  Widget build(BuildContext context) {    
    return person == null ? UnloggedProfile() : LoggedProfile(person);
  }
  
}