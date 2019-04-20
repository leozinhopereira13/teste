import 'package:buspay/models/user_models.dart';
import 'package:buspay/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context,child,model){
        return Scaffold(
          appBar: AppBar(
            title: Text("Área do Usuário"),
            centerTitle: true,
            backgroundColor: Colors.lightBlue,
            actions: <Widget>[

            ],

          ),
          drawer: Drawer(

              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.grey[500],
                      radius: 30.0,
                      child: Icon(
                        Icons.person,
                        size: 60.0,
                        color: Colors.white,
                      ),
                    ) ,
                    accountName:  Text("${!model.isLoggedIn() ? "" : model.userData["name"]} "),
                    accountEmail: Text("${!model.isLoggedIn() ? "" : model.userData["email"]} "),

                  ),
                  InkWell(
                    onTap: () async{

                      model.signOut();

                        Navigator.of(context).pop();
                        Navigator.of(context).pop();


                    },
                    child: Container(
                      height: 60.0,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.exit_to_app,
                            size: 32.0,

                          ),
                          SizedBox(width: 32.0,),
                          Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 16.0,

                              )
                          )
                        ],
                      ),
                    ),
                  )

                ],
              ),

          ),
          body: Container(),
        );
      },
    );
  }

}


