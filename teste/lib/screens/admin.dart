import 'package:flutter_app/tabs/admin_tab.dart';
import 'package:flutter_app/widgets/drawer.dart';
import 'package:flutter/material.dart';


class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
     return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        //Home
        Scaffold(
          appBar: AppBar(

            title: Text("Admin"),
            centerTitle: true,
          ),
          body:HomeTab(),

          drawer: CustomDrawer(_pageController),

        ),
        //Categorias


        Scaffold(
            appBar: AppBar(

              title: Text("Histórico"),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),




        ),


        Scaffold(
          appBar: AppBar(
            title: Text("Formas de Pagamento"),
            centerTitle: true,
          ),

          drawer: CustomDrawer(_pageController),
        ),



        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),

          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text("Meus Dados"),
            centerTitle: true,
          ),

          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text("Ajuda"),
            centerTitle: true,
          ),

          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text("Sair"),
            centerTitle: true,
          ),

          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }

}


