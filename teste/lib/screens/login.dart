import 'package:flutter_app/screens/admin.dart';
import 'package:flutter_app/screens/cadastrar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';
import 'file_utils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // variavel da checkbox
  bool valeuCheckbox = false;
  String teste = "";

  //Declaração dos Controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// mudando o estado do checkbox

  bool onChanged(bool value) {
    setState(() {
      valeuCheckbox = !value;
    });
    return null;
  }

//aqui vai colocar o nome ja salvo no login
  void initState() {
    FileUtils().readCounter().then((value) {
      setState(() {
        teste = value;
        _emailController = TextEditingController(text: value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("ENTRAR"),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Criar Conta",
                style: TextStyle(fontSize: 15.0),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cadastrar()));
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.directions_bus,
                        size: 100.0,
                        color: Colors.lightBlue,
                      ),
                      Text(
                        "Bus Pay",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.email, color: Colors.lightBlue),
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.lightBlue, fontSize: 20.0),
                          controller: _emailController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira seu E-mail";
                            } else {
                              if (!value.contains("@")) {
                                return "Digite um E-mail válido";
                              }
                            }
                          }),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.vpn_key, color: Colors.lightBlue),
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.lightBlue, fontSize: 20.0),
                          controller: _passController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira sua senha";
                            } else {
                              if (value.length < 6) {
                                return "Digita uma senha com mais de 6 caracteres";
                              }
                            }
                          }),
                      Row(children: <Widget>[
                        Checkbox(
                            value: valeuCheckbox,
                            onChanged: (bool value) {
                              onChanged(valeuCheckbox);
                            }),
                        Text("Salvar E-mail",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 70.0,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () {
                              if (_emailController.text.isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                    "Insira seu email para recuperação!",
                                  ),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                model.recoverPass(_emailController.text);
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                    "Confira seu e-mail!",
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: Text(
                              "Esqueci minha senha",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ]),
                      Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 0),
                          child: Container(
                              height: 50.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    model.signIn(
                                      email: _emailController.text,
                                      pass: _passController.text,
                                      onFail: _onFail,
                                      onSuccess: _onSuccess,
                                    );
                                  }
                                },
                                child: Text(
                                  "Entrar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                color: Colors.lightBlue,
                              ))),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("OU",textAlign: TextAlign.center,),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 0),
                          child: Container(
                              height: 50.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                onPressed: () {
                                  model.signInGoogle(
                                    onSuccess: _onSuccess,
                                    onFail: _onFail,
                                  );
                                },
                                child: Text(
                                  "Entrar com o Google",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                color: Colors.deepOrange,
                              ))),
                    ],
                  )));
        }));
  }

  void _onSuccess() {
    if (valeuCheckbox) {
      FileUtils().writeCounter(_emailController.text);
    }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Admin()));
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Falha ao Entrar!",
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
