import 'package:buspay/models/user_models.dart';
import 'package:buspay/screens/admin.dart';
import 'package:buspay/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            centerTitle: true,
          ),
          body: ScopedModelDescendant<UserModel>(
              builder: (context,child,model){
                return Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Image.asset("images/buspay.jpeg",

                          ),
                        ),

                      ],

                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(

                          "BEM VINDO\n ${!model.isLoggedIn() ? "" :model.userData["name"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,


                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 44.0,
                          width: 300.0
                          ,
                          child:  RaisedButton(
                            child: Text("${!model.isLoggedIn() ? "Logar/Cadastre-se" :"Ir para Área Restrita"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.0,


                              ),
                            ),
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            onPressed: (){
                              if(model.isLoggedIn()){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Admin()));
                              }
                              else{
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                              }



                            },
                          ),
                        )
                      ],
                    )
                  ],
                );


              }),
        );

  }
}
