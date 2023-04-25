import 'package:apptiendafrom/models/producto_mediano.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APIProductom {
  static var client = http.Client();

  static Future<List<ProductomModel>?> getProductosm() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(
      Config.apiURL,
      Config.productosmAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(productosmFromJson, response.body);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveProductom(
    ProductomModel modelm,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var productURL = "${Config.productosmAPI}/";

    if (isEditMode) {
      productURL = "$productURL${modelm.id.toString()}/";
    }

    var url = Uri.https(Config.apiURL, productURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["nombre"] = modelm.nombre!;
    request.fields["precio"] = double.parse(modelm.precio!).toStringAsFixed(2);
    request.fields["marca"] = modelm.marca!;
    request.fields["adquirir"] = modelm.adquirir!;
    request.fields["descripcion"] = modelm.descripcion!;


    if (modelm.imagen != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'imagen',
        modelm.imagen!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProductom(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiURL, "${Config.productosmAPI}/$productId/");

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
