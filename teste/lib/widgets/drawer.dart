import 'dart:io';

import 'package:flutter_app/models/user_models.dart';
import 'package:flutter_app/tiles/drawer_tiles.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_picker/image_picker.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;



  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(

              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  radius: 140.0,
                 backgroundImage: model.userData["picture"] != null ?
                 NetworkImage((model.userData["picture"])):
                 AssetImage("images/person.png"),
                ),
                onTap: (){
                  ImagePicker.pickImage(source:ImageSource.camera).then((file){
                    if(file == null) return;
                    else
                    model.savePicture(model.userData, file);

                  });
                },
              ),
              accountName:
                  Text("${!model.isLoggedIn() ? "" : model.userData["name"]} "),
              accountEmail: Text(
                  "${!model.isLoggedIn() ? "" : model.userData["email"]} "),
            ),
            SizedBox(
              width: 10.0,
            ),
            DrawerTile(Icons.home, "Inicio", pageController, 0),
            DrawerTile(Icons.list, "Histórico de Recarga", pageController, 1),
            DrawerTile( Icons.payment,"Formas de Pagamento" , pageController, 2),
            DrawerTile( Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            DrawerTile( Icons.data_usage, "Meus Dados", pageController, 4),
            Divider(height: 10.0,),
            DrawerTile( Icons.help, "Ajuda", pageController, 5),
            DrawerTile(Icons.exit_to_app, "Sair", pageController, 6),
          ],
        );
      }),
    );
  }
}
