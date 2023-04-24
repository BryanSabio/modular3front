// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apptiendafrom/usuario.dart';
import 'package:apptiendafrom/menu.dart';
import 'package:apptiendafrom/config.dart';

import 'package:apptiendafrom/pages/producto/producto_add_edit.dart';
import 'package:apptiendafrom/pages/producto/producto_list.dart';

import 'package:apptiendafrom/pages/producto_mediano/productom_list.dart';
import 'package:apptiendafrom/pages/producto_mediano/productom_add.dart';

import 'package:apptiendafrom/pages/producto_grande/productog_list.dart';
import 'package:apptiendafrom/pages/producto_grande/productog_add.dart';

import 'package:apptiendafrom/pages/producto_gigante/productogi_list.dart';
import 'package:apptiendafrom/pages/producto_gigante/productogi_add.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MyPet",
        initialRoute: "/login",
        routes: {
          '/login': (context) => const MyStatefulWidget(),
          '/list-producto': (context) => const ProductosList(), //pequeño
          '/list-productom': (context) => const ProductosmList(), //mediano
          '/list-productog': (context) => const ProductosgList(), //grande
          '/list-productogi': (context) => const ProductosgiList(), //gigante
          '/add-producto': (context) => const ProductoAddEdit(), //pequeño
          '/edit-producto': (context) => const ProductoAddEdit(), //pequeño
          '/add-productom': (context) => const ProductomAddEdit(), //mediano
          '/edit-productom': (context) => const ProductomAddEdit(), //mediano
          '/add-productog': (context) => const ProductogAddEdit(), //grande
          '/edit-productog': (context) => const ProductogAddEdit(), //grande
          '/add-productogi': (context) => const ProductogiAddEdit(), //gigante
          '/edit-productogi': (context) => const ProductogiAddEdit(), //gigante

          '/home': (context) => Menu(),
        });
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //final urllogin = Uri.parse("http://192.168.1.108/api/login/");  PARA REGRESAR TOKENS DE ERROR DE USER
  final urllogin = Uri.https(Config.apiURL, Config.loginAPI);

  //final urlobtenertoken = Uri.parse("http://192.168.1.108/api/api-token-auth/");
  final urlobtenertoken = Uri.https(Config.apiURL, Config.obtenertokenAPI);
  final headers = {"Content-Type": "application/json;charset=UTF-8"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alimenta a tu mascota'),
        backgroundColor: Colors.deepPurpleAccent,
      ),

      //backgroundColor: Color.fromARGB(188, 156, 153, 150), //foto del fondo
      //backgroundImage: AssetImage('assets/images/huellas.jpeg'),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Administrador',
                    style: TextStyle(
                        color: Color.fromARGB(255, 13, 25, 159),
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent, // Background color
                    ),
                    child: const Text('Acceder',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                    onPressed: () {
                      login();
                    },
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'O',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent, // Background color
                    ),
                    child: const Text('Acceder como invitado',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                    onPressed: () {
                      login2();
                      //Esconder los botones de editar, borrar y Add producto//
                    },
                  )),
            ],
          )),
    );
  }

  void showSnackbar(String msg) {
    final snack = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Future<void> login() async {
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackbar(
          "${nameController.text.isEmpty ? "-User " : ""} ${passwordController.text.isEmpty ? "- Contraseña " : ""} requerido");
      return;
    }
    final datosdelposibleusuario = {
      "username": nameController.text,
      "password": passwordController.text
    };
    final res = await http.post(urllogin,
        headers: headers, body: jsonEncode(datosdelposibleusuario));
    //final data = Map.from(jsonDecode(res.body));
    if (res.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res.statusCode != 200) {
      showSnackbar("Hey!! usuario o contraseña incorrectos");
    }
    final res2 = await http.post(urlobtenertoken,
        headers: headers, body: jsonEncode(datosdelposibleusuario));
    final data2 = Map.from(jsonDecode(res2.body));
    if (res2.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res2.statusCode != 200) {
      showSnackbar("Ups ha habido un error al obtener el token ");
    }
    final token = data2["token"];
    final user = Usuario(
        username: nameController.text,
        password: passwordController.text,
        token: token);
    Config.isAnonymun = false;
    Navigator.pushNamed(
      context,
      '/home',
    );
  }

  Future<void> login2() async {
    Config.isAnonymun = true;
    Navigator.pushNamed(
      context,
      '/home',
    );
  }
}
