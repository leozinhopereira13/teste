import 'package:flutter_app/models/user_models.dart';
import 'package:flutter_app/screens/admin.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flare_flutter/flare_actor.dart';
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
		   Container( height: 400,width:500, color: Colors.blue,
		    	child:Column(children: <Widget>[
				Container(height: 50),
				Container(height: 100,width:100,
				child: FlareActor("animacao/bus.flr",animation:"bus",),
				),
			Container(height: 20),
			Container(height: 5),
			Text("BUS PAY",style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold, fontFamily:"Times",color: Colors.white,)),
			Container(height: 10),
			Text("Pague facil. Pague com o celular",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,fontFamily:"Times", color: Colors.white,)),
			],
			
			),
			),
                    /*Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Image.asset("images/buspay.jpeg",

                          ),
                        ),
			Container(width:100 , height: 100,
			child: FlareActor("animacao/bus.flr",animation:"bus",) ,			
			),
			
                      ],

                    ),*/
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
