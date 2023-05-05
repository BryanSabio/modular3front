import 'dart:io';
import 'package:apptiendafrom/main.dart';
import 'package:apptiendafrom/pages/producto_mediano/productom_list.dart';
import 'package:apptiendafrom/pages/producto_grande/productog_list.dart';
import 'package:apptiendafrom/pages/producto_gigante/productogi_list.dart';
import 'package:flutter/material.dart';
import 'package:apptiendafrom/pages/producto/producto_list.dart';
import 'package:apptiendafrom/pages/inicio/inicio.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

class Menu extends StatefulWidget {
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  int _selectDrawerItem = 0;
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const inicio();
      case 1:
        return const ProductosList();
      case 2:
        return const ProductosmList();
      case 3:
        return const ProductosgList();
      case 4:
        return const ProductosgiList();
    }
  }

  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Icon(Icons.pets),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Tienes alguna duda contactanos!!'),
              accountEmail: Text('micomidacanina01@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/huellas.jpeg'),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              leading: const Icon(Icons.home),
              selected: (0 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(0);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Razas pequeñas'),
              leading: const Icon(Icons.pets),
              selected: (1 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: const Text('Razas medianas'),
              leading: const Icon(Icons.pets),
              selected: (2 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(2);
              },
            ),
            ListTile(
              title: const Text('Razas grandes'),
              leading: const Icon(Icons.pets),
              selected: (3 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(3);
              },
            ),
            ListTile(
              title: const Text('Razas gigantes'),
              leading: const Icon(Icons.pets),
              selected: (4 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(4);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Cerrar Sessión'),
              leading: const Icon(Icons.arrow_back),
              selected: (5 == _selectDrawerItem),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Vuelve pronto  (-_-)",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: getDrawerItemWidget(_selectDrawerItem),
    );
  }
}
