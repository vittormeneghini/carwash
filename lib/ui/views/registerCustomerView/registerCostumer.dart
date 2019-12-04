import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/servicesModels/personService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/widgets/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carwashapp/ui/shareds/inputs/inputDate.dart';

class RigisterCostumer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterCostumerState();  
}

class RegisterCostumerState extends State<RigisterCostumer> {

  String name = '', email = '', phone = '', password = '', confirmePassword = '' ;
  DateTime dateNow = DateTime.now();
  DateTime birthday = DateTime.now();
  var servicePerson = locator <PersonService>();
  bool isLoading = false;
  var test = '';
  
  void setDate (DateTime date) {
    setState(() {
      birthday = date;
    });
  }

  Future <void> sendRegister  () async {
    setState(() {
      isLoading = true;
    });

    var person = Person();  
    person.fullName = this.name;
    person.email = this.email;
    person.phone = this.phone;
    person.birthday = Timestamp.fromDate(this.birthday);
    person.type = 'costumer';

    var _usr = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: person.email, password: person.password);
    person.uid = _usr.user.uid;
    this.test = await servicePerson.addPerson(person);

    Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginApp()));
  }

  bool verifyPassword() {
    return this.password != '' && this.password == this.confirmePassword; 
  }

  @override
  Widget build(BuildContext context) {
    var header = AppBar(
      title: Text('Cliente'),
      backgroundColor: Colors.blue,
    );

    var inputName = TextFormField(
      decoration: InputDecoration(
        labelText: 'Nome',
      ),
      onChanged: (value) => name = value
    );

    var inputEmail = TextFormField(
      decoration: InputDecoration(
        labelText: 'Email'
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => email = value
    );

    var inputPhone = TextFormField(
      decoration: InputDecoration(
        labelText: 'Telefone'
      ),
      keyboardType: TextInputType.phone,
      onChanged: (value) => phone = value
    );

    var inputPassword = TextFormField(
      decoration: InputDecoration(
        labelText: 'Senha'
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      onChanged: (value) => password = value
    );

    var inputConfirmePassword = TextFormField(
      decoration: InputDecoration(
        labelText: 'Confirmar Senha'
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      onChanged: (value) => password = value
    );

    var btnBirthday = IpuntDate(setDate);

    var formatedBirthday = DateFormat("dd/MM/yyyy").format(birthday);

    var dateField = Container(
      child: Text(
        formatedBirthday.toString(),
        style: TextStyle(color: Colors.blue, fontSize: 18.0)
      ),
      margin: EdgeInsets.all(10.0),
    );

    var brithdayRow = Container(
      child: Column(
        children: [
          Text(
            'Data de nascimento:', 
            style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
          ),
          Row(
            children:[
              dateField,
              btnBirthday,
            ]
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      margin: EdgeInsets.symmetric(vertical: 20.0),
    );  
        
    var inputColumn = Column(
      children: [
        inputName,
        inputEmail,
        inputPhone,
        brithdayRow,
        inputPassword,
        inputConfirmePassword
      ],
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    );

    var btnRegister = Container(
      margin: EdgeInsets.all(20.0),
      height: 60.0,
      width: 150.0,
      child: isLoading ? CircularProgressIndicator() : RaisedButton(
        child: Text('Registar', style: TextStyle(fontSize: 20.0)),
        textColor: Colors.white,
        color: Colors.blue,
        splashColor: Colors.white,
        onPressed: () {
          sendRegister();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),
      )
    );

    var mainColumn = ListView(
      children: [
        inputColumn,
        Text(test.toString()),
        btnRegister
        ],
      padding: EdgeInsets.symmetric(horizontal: 20.0),
    );



    var scaffold = Scaffold(appBar: header, body: mainColumn);
    return scaffold;
  }
}