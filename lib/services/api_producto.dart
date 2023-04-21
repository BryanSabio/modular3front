import 'package:flutter/foundation.dart';
import 'package:apptiendafrom/models/producto_model.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APIProducto {
  static var client = http.Client();

  static Future<List<ProductoModel>?> getProductos() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.productosAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(productosFromJson, response.body);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveProducto(
    ProductoModel model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var productURL = "${Config.productosAPI}/";

    if (isEditMode) {
      productURL = "$productURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, productURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["nombre"] = model.nombre!;
    request.fields["precio"] = double.parse(model.precio!).toStringAsFixed(2);
    request.fields["marca"] = model.marca!;
    request.fields["adquirir"] = model.adquirir!;
    request.fields["descripcion"] = model.descripcion!;

    ///check
    //checarrrr
    //request.headers["Authorization"] = "token 6c7e9f684c68adf057008ce8a0f4dc11fae3c0d4";

    if (model.imagen != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'imagen',
        model.imagen!,
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

  static Future<bool> deleteProducto(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.productosAPI}/$productId/");

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