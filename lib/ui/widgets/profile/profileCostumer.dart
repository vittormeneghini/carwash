import 'package:carwashapp/core/models/addressModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/servicesModels/addressService.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/shareds/inputs/inputDate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rounded_modal/rounded_modal.dart';

class ProfileCostumer extends StatefulWidget {
  Person person;
  ProfileCostumer(this.person);

  @override
  _ProfileCostumerState createState() => _ProfileCostumerState(person);
}

class _ProfileCostumerState extends State<ProfileCostumer> {
  Person person;
  TextEditingController _controllerName;
  TextEditingController _controllerEmail;
  TextEditingController _controllerPhone;
  TextEditingController _controllerZipCode = TextEditingController();
  TextEditingController _controllerStreet = TextEditingController();
  TextEditingController _controllerNumber = TextEditingController();
  TextEditingController _controllerNeigh = TextEditingController();
  TextEditingController _controllerCity = TextEditingController();
  DateTime birthday = DateTime.now();
  double defaultMargin = 20.0;
  var personService = locator<PersonService>();
  var addressService = locator<AddressService>();
  bool isLoading = true;
  bool isLoadingAddress = false;
  List<Address> address = List<Address>();
  _ProfileCostumerState(this.person) {
    getAddress();
    _controllerName = TextEditingController(text: person.fullName);
    _controllerEmail = TextEditingController(text: person.email);
    _controllerPhone = TextEditingController(text: person.phone);
    birthday = person.birthday.toDate();
    isLoading = false;
  }

  void setDate(DateTime date) {
    setState(() {
      birthday = date;
    });
  }

  Future<void> getAddress() async {
    var _address = await addressService.fetchAddresses(person.id);
    setState(() {
      address = _address;
    });
  }

  Future<void> updatePerson() async {
    setState(() {
      person.birthday = Timestamp.fromDate(birthday);
      person.fullName = _controllerName.text;
      person.phone = _controllerPhone.text;
      isLoading = true;
    });

    await personService.updatePerson(person, person.id);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> saveAddress() async {
    setState(() {
      isLoadingAddress = true;
    });

    var _address = Address(
        zipCode: _controllerZipCode.text,
        street: _controllerStreet.text,
        number: int.parse(_controllerNumber.text),
        neighborhood: _controllerNeigh.text,
        city: _controllerCity.text,
        country: 'Brazil',
        selected: true);

    await addressService.addAddress(person.id, _address);

    setState(() {
      address.add(_address);
      _controllerZipCode.clear();
      _controllerStreet.clear();
      _controllerNumber.clear();
      _controllerNeigh.clear();
      _controllerCity.clear();
      isLoadingAddress = false;
    });
  }

  Future<void> deleteAddress(String id) async {
    await addressService.removeAddress(person.id, id);

    setState(() {
      address.removeWhere((item) => item.id == id);
    });
  }

  Future<void> takePicture() async {
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );    
  }

  @override
  Widget build(BuildContext context) {
    void _showModal() {
      showRoundedModalBottomSheet(
        context: context,
        radius: 10.0,
        color: Colors.white,
        builder: (context) => Container(
            margin: EdgeInsets.all(20.0),
            child: isLoadingAddress
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Cep'),
                        controller: _controllerZipCode,
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Rua'),
                        controller: _controllerStreet,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Número'),
                        controller: _controllerNumber,
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Bairro'),
                        controller: _controllerNeigh,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Cidade'),
                        controller: _controllerCity,
                      ),
                      IconButton(
                        onPressed: saveAddress,
                        icon: Icon(Icons.control_point),
                        color: Colors.green,
                        iconSize: 50.0,
                      )
                    ],
                  )),
      );
    }

    var rowPhoto = Container(
      margin: EdgeInsets.all(30.0),
      child: Row(
        children: [
          Container(
              child: ClipOval(
            child: Container(
              width: 150,
              height: 150,
              child: Image.network(
                person.image,
                fit: BoxFit.cover,
              ),
            ),
          )),
          Container(
            child: IconButton(
              icon: Icon(
                Icons.camera_alt,
                size: 50.0,
              ),
              onPressed: () => takePicture(),
            ),
          )
        ],
      ),
    );

    var separator = Divider(
      color: Colors.grey,
    );

    var btnBirthday = IpuntDate(setDate);

    var formatedBirthday = DateFormat("dd/MM/yyyy").format(birthday);

    var dateField = Container(
      child: Text(formatedBirthday.toString(),
          style: TextStyle(color: Colors.blue, fontSize: 18.0)),
      margin: EdgeInsets.all(10.0),
    );

    var brithdayRow = Container(
      child: Column(
        children: [
          Text(
            'Data de nascimento:',
            style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
          ),
          Row(children: [
            dateField,
            btnBirthday,
          ])
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      margin: EdgeInsets.symmetric(vertical: 20.0),
    );

    var btnUpdate = Container(
        margin: EdgeInsets.all(20.0),
        height: 60.0,
        width: 150.0,
        child: RaisedButton(
          child: Text('Atualizar', style: TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.blue,
          splashColor: Colors.white,
          onPressed: updatePerson,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ));

    var forms = Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: defaultMargin),
                child: Column(children: [
                  Text(
                    'Email:',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    controller: _controllerEmail,
                    enabled: false,
                  )
                ])),
            Container(
                padding: EdgeInsets.only(top: defaultMargin),
                child: Column(children: [
                  Text(
                    'Nome:',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Nome'),
                    controller: _controllerName,
                  )
                ])),
            Container(
                padding: EdgeInsets.only(top: defaultMargin),
                child: Column(children: [
                  Text(
                    'Telefone:',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Telefone'),
                    controller: _controllerPhone,
                    keyboardType: TextInputType.number,
                  )
                ])),
            Container(
                padding: EdgeInsets.only(top: defaultMargin),
                child: brithdayRow)
          ],
        ));

    var columnAddress = Container(
        child: Column(
      children: address.map((item) {
        return Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                    child: Icon(
                  Icons.map,
                  size: 40.0,
                )),
                Container(
                    child: Expanded(
                        child: Text(
                  item.street + ", " + item.number.toString(),
                  style: TextStyle(fontSize: 15.0),
                ))),
                Container(
                    child: IconButton(
                  icon: Icon(
                    Icons.restore_from_trash,
                    color: Colors.red,
                    size: 40.0,
                  ),
                  onPressed: () => deleteAddress(item.id),
                )),
              ],
            ));
      }).toList(),
    ));

    var rowAddress = Column(children: [
      separator,
      Container(
          margin: EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Text(
                "Endereços",
                style: TextStyle(fontSize: 20.0),
              ),
              Container(
                  child: IconButton(
                icon: Icon(
                  Icons.control_point,
                  color: Colors.green,
                  size: 40.0,
                ),
                onPressed: _showModal,
              )),
            ],
          )),
      separator,
      columnAddress
    ]);

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            children: <Widget>[
              rowPhoto,
              separator,
              forms,
              rowAddress,
              Container(
                  padding: EdgeInsets.only(top: defaultMargin),
                  child: btnUpdate),
            ],
          );
  }
}
