import 'package:flutter/material.dart';
import 'package:apptiendafrom/models/producto_gigante.dart';
import 'package:apptiendafrom/pages/producto_gigante/productogi_item.dart';
import 'package:apptiendafrom/services/api_productogi.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../config.dart';

class ProductosgiList extends StatefulWidget {
  const ProductosgiList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductosgiListState createState() => _ProductosgiListState();
}

class _ProductosgiListState extends State<ProductosgiList> {
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
        child: loadProductosgi(),
      ),
    );
  }

  Widget loadProductosgi() {
    return FutureBuilder(
      future: APIProductogi.getProductosgi(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ProductogiModel>?> model,
      ) {
        if (model.hasData) {
          return productogiList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productogiList(productosgi) {
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
                            '/add-productogi',
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
                    '* RAZAS GIGANTES COMO:',
                    style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Boyero de Berna,  Leonberger,  Terrier ruso negro,  Pastor del Caúcaso,  Terranova,  '
                    'Gran danés (perro caballo),  Tosa inu,  Mastín napolitano,  Mastín español,  Mastín del pirineo,  Dogo español,  '
                    'Presa canario,  Alano español,  Mastín tibetano,  Mastín inglés,  Bullmastiff,  etc.',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )),
              //Navigator.pushNamed(context,'/add-product',);
              //Add Product
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: productosgi.length,
                itemBuilder: (context, index) {
                  return ProductogiItem(
                    model: productosgi[index],
                    onDelete: (ProductogiModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIProductogi.deleteProductogi(model.id).then(
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
