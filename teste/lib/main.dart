
import 'package:buspay/screens/home.dart';
import 'package:buspay/screens/login.dart';
import 'package:flutter/material.dart';

import 'package:buspay/models/user_models.dart';
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
