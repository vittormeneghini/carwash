import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/ui/views/addServiceView/listServiceView.dart';
import 'package:carwashapp/ui/widgets/login/login.dart';
import 'package:carwashapp/ui/widgets/profile/cardProfile.dart';
import 'package:carwashapp/ui/widgets/profile/editProfile.dart';
import 'package:carwashapp/ui/widgets/serviceComming/serviceComming.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedProfile extends StatelessWidget {
  Person person;
  LoggedProfile(this.person);

  Future<void> _singOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var collaboratorProfile = Expanded(
      child: ListView(
        padding: EdgeInsets.all(0),
        reverse: false,
        children: <Widget>[
          CardProfile(
            icon: Icons.edit,
            title: 'Editar Perfil',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));
            },
          ),
          CardProfile(
            icon: Icons.chat,
            title: 'Serviços em Andamento',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ServiceComming()));
            },
          ),
          CardProfile(
            icon: Icons.local_car_wash,
            title: 'Adicionar Serviços',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListServiceView()));
            },
          ),
          CardProfile(
            icon: Icons.add_alert,
            title: 'Avisos',
            onPressed: () {},
          ),
          CardProfile(
            icon: Icons.build,
            title: 'Configurações',
            onPressed: () {},
          ),
          CardProfile(
            icon: Icons.help_outline,
            title: 'Fale Conosco',
            onPressed: () {},
          ),
          CardProfile(
            icon: Icons.call_missed_outgoing,
            title: 'Sair',
            onPressed: () {
              _singOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginApp()));
            },
          ),
        ],
      ),
    );

    var costumerProfile = Expanded(
      child: ListView(
        padding: EdgeInsets.all(0),
        reverse: false,
        children: <Widget>[
          CardProfile(
            icon: Icons.edit,
            title: 'Editar Perfil',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));
            },
          ),
          CardProfile(
            icon: Icons.chat,
            title: 'Serviços em Andamento',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ServiceComming()));
            },
          ),
          CardProfile(
            icon: Icons.help_outline,
            title: 'Fale Conosco',
            onPressed: () {},
          ),
          CardProfile(
            icon: Icons.call_missed_outgoing,
            title: 'Sair',
            onPressed: () {
              _singOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginApp()));
            },
          ),
        ],
      ),
    );

    return person.type == "collaborator"
        ? collaboratorProfile
        : costumerProfile;
  }
}
