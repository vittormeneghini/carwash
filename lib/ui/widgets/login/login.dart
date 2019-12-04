import 'dart:io';

import 'package:carwashapp/ui/shareds/buttons/buttons.dart';
import 'package:carwashapp/ui/views/naviView/navi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'CarWash',
        theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.white), fontFamily: 'Nunito'),
        home: LoginPage(),
      );    
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String messageClient;
  Color messageClientColor = Colors.red;
  bool isHandling = false;

  void setMessageClient(text, {bool error = true}) {
    setState(() {
      messageClientColor = error ? Colors.red : Colors.green;
      messageClient = text;
    });
  }

  void setHandling() {
    setState(() {
      isHandling = true;
    });
  }

  void unsetHandling() {
    setState(() {
      isHandling = false;
    });
  }

  bool validateEmail() {
    if (_emailController.text.isEmpty || _emailController.text == null) {
      setMessageClient("Por favor preencha seu email");
      return false;
    }

    return true;
  }

  bool validatePassword() {
    if (_passwordController.text.isEmpty || _passwordController.text == null) {
      setMessageClient("Por favor preencha sua senha");
      return false;
    }

    if (_passwordController.text.length < 6) {
      setMessageClient("Por favor insira uma senha de 6 dígitos");
      return false;
    }

    return true;
  }

  Future<bool> _singIn() async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      if (result.user == null) {
        setMessageClient("Usuário não encontrado");
        return false;
      }

      return true;
    } catch (e) {                  
      setMessageClient("Usuário não encontrado");
      return false;
    }
  }

  Future<void> _authenticarUsuario() async {
    if (!validateEmail()) return;

    if (!validatePassword()) return;

    bool successAux = await _singIn();

    if (!successAux) return;

    Navigator.push(context, MaterialPageRoute(builder: (context) => Navi()));
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,              
              child: Image.network('https://i.pinimg.com/originals/03/78/b0/0378b0c1b8271c783d1da918d2daa760.gif'),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: _emailController,
                      onChanged: (text) {
                        setState(() {
                          if (text.length > 0) {
                            messageClient = null;
                          }
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          if (text.length > 0) {
                            messageClient = null;
                          }
                        });
                      },
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.grey,
                        ),
                        hintText: 'Senha',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 32),
                      child: Text(
                        'Esqueceu sua senha ?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 32),
                      child: Text(
                        messageClient == null ? "" : messageClient,
                        style: TextStyle(
                            color: messageClientColor, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: isHandling
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : RaisedGradientButton(
                            child: Text(
                              'Login'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setHandling();
                              _authenticarUsuario();
                              unsetHandling();
                            },
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
