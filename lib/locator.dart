import 'package:carwashapp/core/services/addressApi.dart';
import 'package:carwashapp/core/services/categoryApi.dart';
import 'package:carwashapp/core/services/chatApi.dart';
import 'package:carwashapp/core/services/collaboratorServiceApi.dart';
import 'package:carwashapp/core/services/contractApi.dart';
import 'package:carwashapp/core/services/favoriteApi.dart';
import 'package:carwashapp/core/services/personApi.dart';
import 'package:carwashapp/core/services/serviceApi.dart';
import 'package:carwashapp/core/servicesModels/addressService.dart';
import 'package:carwashapp/core/servicesModels/categoryService.dart';
import 'package:carwashapp/core/servicesModels/chatService.dart';
import 'package:carwashapp/core/servicesModels/favoriteService.dart';
import 'package:carwashapp/core/servicesModels/serviceCollaboratorService.dart';
import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:get_it/get_it.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'core/servicesModels/contractService.dart';

GetIt locator = GetIt();

void setupLocator () {
  locator.registerSingleton(PersonApi('persons'));
  locator.registerSingleton(PersonService());
  locator.registerSingleton(ContractApi('contracts'));
  locator.registerSingleton(ContractService());
  locator.registerSingleton(ChatApi());
  locator.registerSingleton(ChatService());
  locator.registerSingleton(CategoryApi('categories'));
  locator.registerSingleton(CategoryService());
  locator.registerSingleton(ServiceApi('services'));
  locator.registerSingleton(ServiceService());
  locator.registerSingleton(FavoriteApi('favorites'));
  locator.registerSingleton(FavoriteService());
  locator.registerSingleton(CollaboratorServiceApi('service_collaborator'));
  locator.registerSingleton(ServiceCollaboratorService());
  locator.registerSingleton(AddressApi('persons'));
  locator.registerSingleton(AddressService());
}