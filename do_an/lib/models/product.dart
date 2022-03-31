import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:do_an/utils/URL.dart';

class ProductModel {
  late int id;
  late String? catalog_id;
  late String name;
  late num price;
  late num discount;

  ProductModel();

  ProductModel.construct(
      this.id, this.catalog_id, this.name, this.price, this.discount);

  factory ProductModel.fromProduct(ProductModel product) {
    return ProductModel.construct(product.id, product.catalog_id, product.name,
        product.price, product.discount);
  }

  factory ProductModel.fromJSON(Map<String, dynamic> data) {
    return ProductModel.construct(data["id"], data["catalog_id"], data["name"],
        data["price"], data["discount"]);
  }

  num tinhGiaTien() {
    return price * ((100 - discount.toDouble()) / 100);
  }
}
Future<List<ProductModel>> getAllProduct(
    http.Client client) async {
  final response = await client.get(Uri.parse("${URL_PRODUCT}list"));
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    if (res['result'] != null) {
      final products = res["result"].cast<Map<String, dynamic>>();
      final listProduct = await products.map<ProductModel>((json) {
        return ProductModel.fromJSON(json);
      }).toList();
      return listProduct;
    } else {
      return [];
    }
  } else {
    throw Exception("Lấy dữ liệu lỗi!");
  }
}

Future<List<ProductModel>> getAllProductByCata(
    http.Client client, String catalog_id) async {
  final response = await client.get(Uri.parse(URL_GET_PRODUCTS + catalog_id));
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    if (res['result'] != null) {
      final products = res["result"].cast<Map<String, dynamic>>();
      final listProduct = await products.map<ProductModel>((json) {
        return ProductModel.fromJSON(json);
      }).toList();
      return listProduct;
    } else {
      return [];
    }
  } else {
    throw Exception("Lấy dữ liệu lỗi!");
  }
}

Future<ProductModel> getProductById(http.Client client, int id) async {
  final response = await client.get(Uri.parse("${URL_PRODUCT}detail/$id"));
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    if (res["result"] != null) {
      final product = ProductModel.fromJSON(res["result"]);
      return product;
    } else {
      return ProductModel();
    }
  } else {
    throw Exception("Không lấy được sản phẩm có id = $id");
  }
}

Future<bool> updateProduct(
    http.Client client, Map<String, dynamic> params) async {
  final response =
      await client.put(Uri.parse("${URL_PRODUCT}update"), body: params);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteProduct(http.Client client, int id) async {
  final response = await client.delete(Uri.parse("${URL_PRODUCT}delete/$id"));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> insertProduct(
    http.Client client, Map<String, dynamic> params) async {
  final response =
      await client.post(Uri.parse("${URL_PRODUCT}add"), body: params);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
