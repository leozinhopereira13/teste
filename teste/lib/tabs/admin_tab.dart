import 'package:flutter/material.dart';
//import 'package:qrcode_reader/QRCode_Reader.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future<String> _barcodeString;



  Future<String> _api() async {
    setState(() {
       _barcodeString = new QRCodeReader()
          .setAutoFocusIntervalInMs(200)
          .setForceAutoFocus(true)
          .setTorchEnabled(true)
          .setHandlePermissions(true)
          .setExecuteAfterPermissionGranted(true)
          .scan();
    });
}

  Future<String> _api2(String url) async {
    http.Response response = await http.get(url);
    var jsonResponse = json.decode(response.body);

    return jsonResponse["data"];



  }

  Future<String> _empty() async {
    return 'Você ainda não tem viagens!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<String>(
              future: _barcodeString,
              builder: (BuildContext context, AsyncSnapshot<String> snap) {

                return FutureBuilder<String>(
                  future: snap.data != null ? _api2(snap.data) : _empty(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                    return new Text(snapshot.data != null ? snapshot.data : '');
                  },
                );
              })),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
            _api();
        },
        tooltip: 'Reader the QRCode',
        child: new Icon(Icons.attach_money),
      ),
    );
  }
}

