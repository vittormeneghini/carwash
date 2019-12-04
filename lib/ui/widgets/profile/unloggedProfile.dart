import 'package:carwashapp/ui/views/registerCollaboratorView/registerCollaboratorView.dart';
import 'package:carwashapp/ui/views/registerCustomerView/registerCostumer.dart';
import 'package:carwashapp/ui/widgets/login/login.dart';
import 'package:carwashapp/ui/widgets/profile/cardProfile.dart';
import 'package:flutter/material.dart';

class UnloggedProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(0),
        reverse: false,
        children: <Widget>[
          CardProfile(icon: Icons.assignment, title: 'Termos e Condições', onPressed: (){},),          
          CardProfile(icon: Icons.help_outline, title: 'Fale Conosco', onPressed: (){},),
          CardProfile(icon: Icons.add_to_home_screen, title: 'Entrar', onPressed: (){
                          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginApp()));
          },),
          CardProfile(icon: Icons.person_add, title: 'Seja um colaborador', onPressed: (){
                                      Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RigisterCollaborator()));
          },),
          CardProfile(icon: Icons.person_add, title: 'Seja um cliente', onPressed: (){
            Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RigisterCostumer()));
          },),
        ],
      ),
    );
  }
}