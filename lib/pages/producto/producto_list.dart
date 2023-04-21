import 'package:flutter/material.dart';
import 'package:apptiendafrom/models/producto_model.dart';
import 'package:apptiendafrom/pages/producto/producto_item.dart';
import 'package:apptiendafrom/services/api_producto.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../config.dart';

class ProductosList extends StatefulWidget {
  const ProductosList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductosListState createState() => _ProductosListState();
}

class _ProductosListState extends State<ProductosList> {
  // List<ProductModel> products = List<ProductModel>.empty(growable: true);
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadProductos(),
      ),
    );
  }

  Widget loadProductos() {
    return FutureBuilder(
      future: APIProducto.getProductos(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ProductoModel>?> model,
      ) {
        if (model.hasData) {
          return productoList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productoList(productos) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                // ignore: sort_child_properties_last
                children: [
                  if (!Config.isAnonymun)
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/add-producto',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Add Producto',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/home',
                        );
                        //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Menu',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    '* RAZAS PEQUEÑAS COMO:',
                    style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Chihuahua,  Pomerania,  Cavalier king charles spaniel,  Caniche,  Carlino,  Yorkshire terrier,  '
                    'Papillón,  Bichón maltés,  Dachshund,  Bulldog francés,  Schnauzer,  Jack russell terrier,  Bulldog inglés,  Pinscher miniatura,  '
                    'Galgo italiano,  Corgi,  Ratonero valenciano,  Cockapoo,  Shih tzu,  Beagle,  etc.',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )),
              //Navigator.pushNamed(context,'/add-product',);
              //Add Product
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  return ProductoItem(
                    model: productos[index],
                    onDelete: (ProductoModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIProducto.deleteProducto(model.id).then(
                        (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
                  );
                },
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    '* Aplican restricciones. Precios sujetos a cambios sin previo aviso.',
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
