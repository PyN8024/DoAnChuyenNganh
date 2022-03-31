import 'package:do_an/utils/URL.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatalogModel {
  late String catalog_id;
  late String name;
  late int soLuong;

  CatalogModel();

  CatalogModel.name(this.catalog_id, this.name, this.soLuong);

  factory CatalogModel.fromJSON(Map<String, dynamic> data) {
    return CatalogModel.name(data['catalog_id'], data['name'], data['soluong']);
  }

  factory CatalogModel.fromCatalog(CatalogModel catalog) {
    return CatalogModel.name(catalog.catalog_id, catalog.name, catalog.soLuong);
  }

}

Future<List<CatalogModel>> getAllCatalog(http.Client client) async {
  final response = await client.get(Uri.parse(URL_GET_CATALOGS));
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    if (res['result'] != null) {
      final catalogs = res["result"].cast<Map<String, dynamic>>();
      final listCatalog = await catalogs.map<CatalogModel>((json) {
        return CatalogModel.fromJSON(json);
      }).toList();
      return listCatalog;
    } else {
      return [];
    }
  } else {
    throw Exception("Lấy dữ liệu lỗi!");
  }
}

Future<CatalogModel> getCatalogById(http.Client client, String id) async {
  final response = await client.get(Uri.parse("${URL_CATALOG}detail/$id"));
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    if (res["result"] != null) {
      final data = CatalogModel.fromJSON(res["result"]);
      return data;
    } else {
      return CatalogModel();
    }
  } else {
    throw Exception("Không lấy được danh mục có id = $id");
  }
}

Future<bool> updateCatalog(http.Client client, Map<String, dynamic> params) async {
  final response = await client.put(Uri.parse("${URL_CATALOG}update"), body: params);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteCatalog(http.Client client, String id) async {
  final response = await client.delete(Uri.parse("${URL_CATALOG}delete/$id"));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> insertCatalog(http.Client client, Map<String, dynamic> params) async {
  final response = await client.post(Uri.parse("${URL_CATALOG}add"), body: params);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}