import 'package:do_an/models/catalog.dart';
import 'package:do_an/pages/AddCatalog.dart';
import 'package:do_an/pages/CatalogDetail.dart';
import 'package:do_an/pages/ProductPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatalogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CatalogPageState();
  }
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh mục'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductPage(
                            catalogID: "ALL")))
                    .then((value) {
                  setState(() {});
                });
                ;
              },
              child: Text(
                "ALL",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: FutureBuilder(
        future: getAllCatalog(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            List<CatalogModel> catalogs = snapshot.data as List<CatalogModel>;
            return ListView.builder(
              itemCount: catalogs.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ListTile.divideTiles(
                        context: context,
                        tiles: [
                          ListTile(
                            title: Text(
                              catalogs[i].name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                            subtitle: Text("Số lượng: ${catalogs[i].soLuong}"),
                            trailing: Text(catalogs[i].catalog_id),
                          ),
                        ],
                      ).toList(),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPage(
                                    catalogID: catalogs[i].catalog_id)))
                        .then((value) {
                      setState(() {});
                    });
                    ;
                  },
                  onLongPress: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CatalogDetailPage(
                                    id: catalogs[i].catalog_id)))
                        .then((value) => this.setState(() {}));
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Text(
            "+",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCatalogPage()))
                .then((value) => setState(() {}));
          }),
    );
  }
}
