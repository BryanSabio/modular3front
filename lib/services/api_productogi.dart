import 'package:apptiendafrom/models/producto_gigante.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APIProductogi {
  static var client = http.Client();

  static Future<List<ProductogiModel>?> getProductosgi() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(
      Config.apiURL,
      Config.productosgiAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(productosgiFromJson, response.body);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveProductogi(
    ProductogiModel modelgi,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var productURL = "${Config.productosgiAPI}/";

    if (isEditMode) {
      productURL = "$productURL${modelgi.id.toString()}/";
    }

    var url = Uri.https(Config.apiURL, productURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["nombre"] = modelgi.nombre!;
    request.fields["precio"] = double.parse(modelgi.precio!).toStringAsFixed(2);
    request.fields["marca"] = modelgi.marca!;
    request.fields["adquirir"] = modelgi.adquirir!;
    request.fields["descripcion"] = modelgi.descripcion!;

    if (modelgi.imagen != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'imagen',
        modelgi.imagen!,
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

  static Future<bool> deleteProductogi(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiURL, "${Config.productosgiAPI}/$productId/");

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
