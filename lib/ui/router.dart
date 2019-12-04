import 'package:carwashapp/ui/views/collaboratorServiceView/collaboratorServiceView.dart';
import 'package:carwashapp/ui/views/naviView/navi.dart';
import 'package:carwashapp/ui/views/serviceView/chat.dart';
import 'package:carwashapp/ui/widgets/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './views//registerCustomerView/registerCostumer.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Navi());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginApp());
      case '/registerCostumer':
        return MaterialPageRoute(builder: (_) => RigisterCostumer());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Não foram encontrada rotas para ${settings.name}'),
                  ),
                ));
    }
  }
}
