import 'package:do_an/models/product.dart';
import 'package:do_an/pages/AddProduct.dart';
import 'package:do_an/pages/ProductDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  final String catalogID;


  ProductPage({Key? key ,required this.catalogID}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductState();
  }
}

class _ProductState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sản phẩm"),
      ),
      body: FutureBuilder(
        future: widget.catalogID=="ALL" ?  getAllProduct(http.Client()): getAllProductByCata(http.Client(), widget.catalogID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            List<ProductModel> products = snapshot.data as List<ProductModel>;
            return ListView.builder(
              itemCount: products.length,
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
                              products[i].name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                            subtitle: Text("Giá: ${products[i].tinhGiaTien()}"),
                          ),
                        ],
                      ).toList(),
                    ),
                  ),
                  onTap: () {
                    int? id = products[i].id;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(id: id))).then((value) {
                      setState(() {});
                    });
                    ;
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProductPage()))
                .then((value) {setState(() {

                });});
          }),
    );
  }
}
