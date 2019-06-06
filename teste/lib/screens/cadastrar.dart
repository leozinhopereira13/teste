import 'package:flutter_app/models/user_models.dart';
import 'package:flutter_app/screens/admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';






class Cadastrar extends StatefulWidget {


  @override

  _CadastrarState createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {

  //Declaração dos Controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  //Key usado para Validação do formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastre-se"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[

        ],
      ),
      backgroundColor: Colors.white,
      body: ScopedModelDescendant<UserModel>(
        builder: (context,child,model){
          if(model.isLoading)
            return Center(child: CircularProgressIndicator());
          return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: Colors.lightBlue),
                            labelText: "Nome",
                            labelStyle: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),


                          ),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                          controller: _nameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira seu Nome";
                            }
                          }),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.lightBlue),
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
                          style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                          controller: _emailController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira seu E-mail";
                            } else {
                              if (!value.contains("@")) {
                                return "Insira um E-mail válido";
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
                          style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                          controller: _passController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira sua senha";
                            } else {
                              if (value.length < 6) {
                                return "Insira uma senha com mais de 6 caracteres";
                              }
                            }
                          }),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(

                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon:
                            Icon(Icons.streetview, color: Colors.lightBlue),
                            labelText: "Endereço",
                            labelStyle: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                          ),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                          controller:_addressController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira um Endereço Válido";
                            }
                          }),
                      SizedBox(
                        height: 16.0,
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 0),
                          child: Container(
                              height: 50.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    Map<String,dynamic> userData = {
                                      "name": _nameController.text,
                                      "email": _emailController.text,
                                      "address": _addressController.text,
                                    };
                                    model.signUp(
                                      userData: userData ,
                                      pass:_passController.text ,
                                      onSuccess: _onSuccess,
                                      onFail: _onFail,
                                    );

                                  }
                                },
                                child: Text(
                                  "Cadastrar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                color: Colors.lightBlue,
                              )
                          )
                      ),

                    ],
                  )
              )
          );
        },
      )
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(
          "Usuario Criado com Sucesso!\nRedirecionando para o Painel Administrativo...",
        ),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Admin()));
    });


  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(
          "Falha ao Criar Usuário!",
        ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }
}

