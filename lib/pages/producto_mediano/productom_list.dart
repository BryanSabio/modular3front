import 'package:flutter/material.dart';
import 'package:apptiendafrom/models/producto_mediano.dart';
import 'package:apptiendafrom/pages/producto_mediano/productom_item.dart';
import 'package:apptiendafrom/services/api_productom.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../config.dart';

class ProductosmList extends StatefulWidget {
  const ProductosmList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductosmListState createState() => _ProductosmListState();
}

class _ProductosmListState extends State<ProductosmList> {
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
        child: loadProductosm(),
      ),
    );
  }

  Widget loadProductosm() {
    return FutureBuilder(
      future: APIProductom.getProductosm(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ProductomModel>?> model,
      ) {
        if (model.hasData) {
          return productomList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productomList(productosm) {
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
                            '/add-productom',
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
                    '* RAZAS MEDIANAS COMO:',
                    style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Labrador Retriever,  Bóxer,  Husky Siberiano,  Pitbull,  Bulldog inglés,  Chow Chow,  Samoyedo, '
                    'Border Collie,  Dálmata,  Basset Hound,  Pastor australiano,  Pastor ganadero australiano,  Seltie o pastor de las islas Shetland, '
                    'Vizsla o Braco húngaro,  Weimaraner o Braco de Weimar,  etc.',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )),
              //Navigator.pushNamed(context,'/add-product',);
              //Add Product
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: productosm.length,
                itemBuilder: (context, index) {
                  return ProductomItem(
                    model: productosm[index],
                    onDelete: (ProductomModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIProductom.deleteProductom(model.id).then(
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
