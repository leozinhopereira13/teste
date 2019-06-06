import 'package:flutter_app/models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon,this.text, this.controller,this.page);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (context,child,model) {
          return Material( //para dar um efeito visual ao clicar no icone
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (text != "Sair") {
                  Navigator.of(context).pop();
                  controller.jumpToPage(page);
                }
                else {
                  model.signOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                height: 50.0,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10.0,),
                    Icon(
                      icon,
                      size: 32.0,
                      color: controller.page.round() == page
                          ? //deixando o texto selecionado de acordado com a pagina atual
                      Theme
                          .of(context)
                          .primaryColor
                          : Colors.grey[700],
                    ),
                    SizedBox(width: 32.0,),
                    Text(
                        text,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: controller.page.round() == page ?
                          Theme
                              .of(context)
                              .primaryColor : Colors.grey[700],
                        )
                    )
                  ],
                ),
              ),
            ),
          );

        });
  }
}