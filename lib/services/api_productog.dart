import 'package:apptiendafrom/models/producto_grande.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APIProductog {
  static var client = http.Client();

  static Future<List<ProductogModel>?> getProductosg() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(
      Config.apiURL,
      Config.productosgAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(productosgFromJson, response.body);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveProductog(
    ProductogModel modelg,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var productURL = "${Config.productosgAPI}/";

    if (isEditMode) {
      productURL = "$productURL${modelg.id.toString()}/";
    }

    var url = Uri.https(Config.apiURL, productURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["nombre"] = modelg.nombre!;
    request.fields["precio"] = double.parse(modelg.precio!).toStringAsFixed(2);
    request.fields["marca"] = modelg.marca!;
    request.fields["adquirir"] = modelg.adquirir!;
    request.fields["descripcion"] = modelg.descripcion!;


    if (modelg.imagen != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'imagen',
        modelg.imagen!,
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

  static Future<bool> deleteProductog(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiURL, "${Config.productosgAPI}/$productId/");

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
