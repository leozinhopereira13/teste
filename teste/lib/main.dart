
import 'package:flutter_app/screens/home.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BusPay',
          theme: ThemeData(
            dividerColor: Colors.grey[500],
          ),

          home: Home(),

      ),
    );
  }
}
