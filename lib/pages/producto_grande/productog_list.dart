import 'package:flutter/material.dart';
import 'package:apptiendafrom/models/producto_grande.dart';
import 'package:apptiendafrom/pages/producto_grande/productog_item.dart';
import 'package:apptiendafrom/services/api_productog.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../config.dart';

class ProductosgList extends StatefulWidget {
  const ProductosgList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductosgListState createState() => _ProductosgListState();
}

class _ProductosgListState extends State<ProductosgList> {
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
        child: loadProductosg(),
      ),
    );
  }

  Widget loadProductosg() {
    return FutureBuilder(
      future: APIProductog.getProductosg(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ProductogModel>?> model,
      ) {
        if (model.hasData) {
          return productogList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productogList(productosg) {
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
                            '/add-productog',
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
                    '* RAZAS GRANDES COMO:',
                    style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Rottweiler,  Bull terrier,  American bully,  Dóberman,  Dogo burdeos,  Golden retriever,  Fila brasileño,  '
                    'Alaskan malamute,  Akita inu,  American pit bull terrier,  American staffordshire,  Airedale terrier,  Basset hound,  '
                    'Boyero de berna,  Bobtail,  Braco alemán,  Bullmastiff,  Dogo alemán,  Dogo argentino,  Husky siberiano,  Gran boyero suizo,  '
                    'Labrador retriever,  Lobero irlandés,  Mastín español,  Mastín del pirineo,  Mastín napolitano,  Mastín tibetano,  '
                    'Pastor alemán,  Pointer inglés,  Pastor belga,  San bernardo,  Setter inglés,  Setter irlandés,  Springer spaniel inglés,  '
                    'Staffordshire bull terrier,  Terranova,  Tosa inu,  etc.',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )),
              //Navigator.pushNamed(context,'/add-product',);
              //Add Product
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: productosg.length,
                itemBuilder: (context, index) {
                  return ProductogItem(
                    model: productosg[index],
                    onDelete: (ProductogModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIProductog.deleteProductog(model.id).then(
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
