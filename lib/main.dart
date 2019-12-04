import 'package:carwashapp/core/servicesModels/addressService.dart';
import 'package:carwashapp/core/servicesModels/favoriteService.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/serviceCollaboratorService.dart';
import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import './ui/router.dart';
import './locator.dart';
import 'core/servicesModels/categoryService.dart';
import 'core/servicesModels/chatService.dart';
import 'core/servicesModels/contractService.dart';

void main() {
  setupLocator();    
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent, animate: true);     
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<PersonService>()),
        ChangeNotifierProvider(builder: (_) => locator<ContractService>()),
        ChangeNotifierProvider(builder: (_) => locator<ChatService>()),
        ChangeNotifierProvider(builder: (_) => locator<CategoryService>()),
        ChangeNotifierProvider(builder: (_) => locator<ServiceService>()),
        ChangeNotifierProvider(builder: (_) => locator<FavoriteService>()),
        ChangeNotifierProvider(builder: (_) => locator<ServiceCollaboratorService>()),
        ChangeNotifierProvider(builder: (_) => locator<AddressService>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/registerCostumer',
        title: 'CarWash',
        theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.white), fontFamily: 'Nunito'),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}