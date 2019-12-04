import 'dart:ffi';

import 'package:carwashapp/core/models/categoryModel.dart';
import 'package:carwashapp/core/models/collaboratorServiceViewModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/models/serviceCollaboratorModel.dart';
import 'package:carwashapp/core/models/serviceModel.dart';
import 'package:carwashapp/core/servicesModels/categoryService.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/core/servicesModels/serviceCollaboratorService.dart';
import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:carwashapp/core/servicesModels/userAuthenticatedService.dart';
import 'package:carwashapp/ui/shareds/currency/currencyInputFormatter.dart';
import 'package:carwashapp/ui/views/addServiceView/listServiceView.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../locator.dart';

class AddService extends StatefulWidget {
  String id;
  AddService(this.id);

  @override
  _AddServiceState createState() => _AddServiceState(id);
}

class _AddServiceState extends State<AddService> {
  String id;
  _AddServiceState(this.id);
  List<Category> categories;
  List<Service> services;
  TextEditingController _timeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _currencyController = TextEditingController();
  var categoryService = locator<CategoryService>();
  var serviceService = locator<ServiceService>();
  var serviceCollaboratorService = locator<ServiceCollaboratorService>();
  var personService = locator<PersonService>();
  var authenticatedService = UserAuthenticatedService();
  CollaboratorServiceViewModel colabServiceVw;
  Person loggedPerson;
  String idCategorySelected;
  String idServiceSelected;
  bool isBind = false;
  bool validateCategory = true;
  bool validateService = true;
  bool validateTime = true;
  bool validatePrice = true;
  bool validateDescription = true;
  String selectedService;
  String selectedCategory;
  bool loadScreen = false;

  @override
  void initState() {
    if (id != null) {
      getServiceCollaborator();
    }
    getUserLogged();
    getCategories();
    super.initState();
  }

  Future<void> getServiceCollaborator() async {
    setState(() {
      loadScreen = true;
    });
    var data =
        await serviceCollaboratorService.getServiceCollaboratorById(id.trim());
    var dataService =
        await serviceService.getServiceById(data.serviceId.trim());
    var dataCategory =
        await categoryService.getCategoryById(data.categoryId.trim());
    var vw = CollaboratorServiceViewModel(
        collaboratorServiceId: data.collaboratorId,
        time: data.time,
        price: data.price,
        serviceName: dataService.name,
        description: data.description,
        categoryId: data.categoryId,
        serviceId: data.serviceId);

    var category = categories.firstWhere((item) {
      return item.name == dataCategory.name;
    });

    var _services = await serviceService.fetchServicesByCategory(category.id);

    setState(() {
      colabServiceVw = vw;
      _timeController.text = vw.time;
      _currencyController.text = vw.price;
      _descriptionController.text = vw.description;
      selectedService = dataService.name;
      selectedCategory = dataCategory.name;
      idCategorySelected = category.id;
      idServiceSelected = dataService.id;
      services = _services;
      loadScreen = false;
    });
  }

  Future<void> getCategories() async {
    var data = await categoryService.fetchCategories();
    setState(() {
      categories = data;
    });
  }

  Future<void> getUserLogged() async {
    var currentUser = await authenticatedService.getCurrentUser();

    if (currentUser == null) return;

    var _person = await personService.getPersonByUid(currentUser.uid);

    if (_person == null) return;

    setState(() {
      loggedPerson = _person;
    });
  }

  bool isValidForm() {
    setState(() {
      validateTime = _timeController.text.length > 0;
      validatePrice = _currencyController.text.length > 0;
      validateDescription = _descriptionController.text.length > 0;
      validateCategory = idCategorySelected != null;
      validateService = idServiceSelected != null;
    });

    return validateTime &&
        validatePrice &&
        validateDescription &&
        validateCategory &&
        validateService;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Adicione um serviço a sua lista"),
          backgroundColor: Colors.blue,
        ),
        body: loadScreen
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Categoria"),
                              FindDropdown(
                                items: categories == null
                                    ? ['']
                                    : categories.map((item) {
                                        return item.name;
                                      }).toList(),
                                onChanged: (title) async {
                                  var category = categories.firstWhere((item) {
                                    return item.name == title;
                                  });
                                  var _services = await serviceService
                                      .fetchServicesByCategory(category.id);
                                  setState(() {
                                    idCategorySelected = category.id;
                                    services = _services;
                                  });
                                },
                                selectedItem: selectedCategory == null
                                    ? "Selecione..."
                                    : selectedCategory,
                              ),
                              !validateCategory
                                  ? Text(
                                      "É necessário selecionar uma categoria",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12.0))
                                  : Container()
                            ],
                          ),
                        )),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Serviço"),
                              FindDropdown(
                                items: services == null
                                    ? ['']
                                    : services
                                        .map((item) => item.name)
                                        .toList(),
                                onChanged: (title) {
                                  var _services = services.firstWhere((item) {
                                    return item.name == title;
                                  });

                                  setState(() {
                                    idServiceSelected = _services.id;
                                  });
                                },
                                selectedItem: selectedService == null
                                    ? "Selecione..."
                                    : selectedService,
                              ),
                              !validateService
                                  ? Text(
                                      "É necessário selecionar um serviço",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12.0),
                                    )
                                  : Container()
                            ],
                          ),
                        )),
                      ]),
                      Container(
                          margin: EdgeInsets.all(20.0),
                          child: Row(children: [
                            Expanded(
                                child: TextFormField(
                              controller: _timeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText:
                                      'Tempo médio de execução do serviço',
                                  errorText: !validateTime
                                      ? 'É necessário informar um tempo médio'
                                      : null),
                              textAlign: TextAlign.center,
                            )),
                            Text("minutos")
                          ])),
                      Container(
                          margin: EdgeInsets.all(20.0),
                          child: TextFormField(
                            controller: _currencyController,
                            decoration: InputDecoration(
                                hintText: "Digite o valor padrão.",
                                errorText: !validateTime
                                    ? 'É necessário informar um valor padrão'
                                    : null),
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              new CurrencyInputFormatter()
                            ],
                            keyboardType: TextInputType.number,
                          )),
                      Container(
                          margin: EdgeInsets.all(20.0),
                          child: TextFormField(
                            maxLines: null,
                            controller: _descriptionController,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                errorText: !validateTime
                                    ? 'É necessário informar uma descrição'
                                    : null,
                                hintText:
                                    'Digite uma descrição sobre o serviço'),
                          )),
                      Center(
                          child: isBind
                              ? Container(
                                  margin: EdgeInsets.only(top: 30.0),
                                  child: CircularProgressIndicator())
                              : Container(
                                  margin: EdgeInsets.all(20.0),
                                  height: 60.0,
                                  width: 150.0,
                                  child: RaisedButton(
                                    child: Text(colabServiceVw == null
                                        ? "Registrar"
                                        : "Atualizar"),
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    splashColor: Colors.white,
                                    onPressed: () async {
                                      bool success = isValidForm();

                                      setState(() {
                                        isBind = success;
                                      });

                                      if (success) {
                                        String _id = colabServiceVw != null
                                            ? colabServiceVw
                                                .collaboratorServiceId
                                            : null;

                                        colabServiceVw == null
                                            ? _id = await serviceCollaboratorService
                                                .addServiceCollaborator(ServiceCollaboratorModel(
                                                    collaboratorId: loggedPerson ==
                                                            null
                                                        ? ''
                                                        : loggedPerson.id,
                                                    serviceId: idServiceSelected
                                                        .trim(),
                                                    categoryId: idCategorySelected
                                                        .trim(),
                                                    price: _currencyController
                                                        .text,
                                                    description:
                                                        _descriptionController
                                                            .text,
                                                    time: _timeController.text))
                                            : await serviceCollaboratorService.updateServiceCollaborator(
                                                ServiceCollaboratorModel(
                                                    collaboratorId:
                                                        loggedPerson == null
                                                            ? ''
                                                            : loggedPerson.id,
                                                    serviceId: idServiceSelected
                                                        .trim(),
                                                    categoryId:
                                                        idCategorySelected.trim(),
                                                    price: _currencyController.text,
                                                    description: _descriptionController.text,
                                                    time: _timeController.text),
                                                id);

                                        if (_id != null) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListServiceView()));
                                        }
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                  )))
                    ],
                  ),
                ),
              ));
  }
}
