import 'dart:convert';

List<ProductomModel> productosmFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<ProductomModel>((json) => ProductomModel.fromJson(json))
      .toList();
}

class ProductomModel {
  late int? id;
  late String? nombre;
  late String? precio;
  late String? marca;
  late String? adquirir;
  late String? descripcion;
  late String? imagen;

  ProductomModel({
    this.id,
    this.nombre,
    this.precio,
    this.marca,
    this.adquirir,
    this.descripcion,
    this.imagen,
  });

  factory ProductomModel.fromJson(Map<String, dynamic> json) {
    return ProductomModel(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      precio: json['precio'],
      marca: json['marca'],
      adquirir: json['adquirir'],
      descripcion: json['descripcion'],
      imagen: json['imagen'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['precio'] = precio;
    data['marca'] = marca;
    data['adquirir'] = adquirir;
    data['descripcion'] = descripcion;
    data['imagen'] = imagen;
    return data;
  }
}
