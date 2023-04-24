import 'package:flutter/material.dart';
import 'package:apptiendafrom/menu.dart';
import 'package:apptiendafrom/pages/producto/producto_list.dart';
import '../../menu.dart';
import 'dart:io';
import 'package:apptiendafrom/main.dart';

// ignore: camel_case_types
class inicio extends StatelessWidget {
  const inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  '¿Que come mi mascota?',
                  style: TextStyle(
                      color: Color.fromARGB(255, 15, 15, 172),
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            // ignore: avoid_unnecessary_containers
            Container(
              // ignore: prefer_const_constructors
              child: Image.asset('assets/images/pequenos.png'),
              height: 550,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Razas de perros pequeños: peso entre 3 y 10 kilos.',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent, // Background color
                      shape: CircleBorder()),
                  child: Icon(
                    Icons.card_giftcard_sharp,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/list-producto', (route) => false);
                  },
                )),
            Container(
              // ignore: prefer_const_constructors
              child: Image.asset('assets/images/medianos.png'),
              height: 550,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Razas de perros medianos: peso desde 10 a 25 kilos.',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent, // Background color
                      shape: CircleBorder()),
                  child: Icon(Icons.card_giftcard_sharp),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/list-productom', (route) => false);
                  },
                )),
            Container(
              // ignore: prefer_const_constructors
              child: Image.asset('assets/images/grande.png'),
              height: 550,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Razas de perros grandes: 25 a 50 kilos.',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent, // Background color
                      shape: CircleBorder()),
                  child: Icon(Icons.card_giftcard_sharp),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/list-productog', (route) => false);
                  },
                )),
            Container(
              // ignore: prefer_const_constructors
              child: Image.asset('assets/images/gigantes.png'),
              height: 550,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Perros gigantes: más de 50 kilos.',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent, // Background color
                      shape: CircleBorder()),
                  child: Icon(Icons.card_giftcard_sharp),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/list-productogi', (route) => false);
                  },
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  '* Aplican restricciones. Precios sujetos a cambios sin previo aviso.',
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ));
  }
}
