import 'package:do_an/models/product.dart';
import 'package:do_an/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatefulWidget {
  final int id;

  ProductDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetailPage> createState() {
    // TODO: implement createState
    return _ProductDetailState();
  }
}

class _ProductDetailState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
      ),
      body: FutureBuilder(
          future: getProductById(http.Client(), widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              ProductModel pro = snapshot.data as ProductModel;
              return _Detail(product: pro);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class _Detail extends StatefulWidget {
  final ProductModel product;
  String name = "", catalog_id = "", price = "", discount = "";
  late int id;

  _Detail({Key? key, required this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailState();
  }
}

class _DetailState extends State<_Detail> {
  ProductModel prodduct = new ProductModel();
  bool kTraLoad = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (kTraLoad == false) {
      setState(() {
        this.prodduct = ProductModel.fromProduct(widget.product);
        widget.id = this.prodduct.id;
        this.kTraLoad = true;
      });
    }
    final _txtProductID = Text(
      this.prodduct.id != null ? "${this.prodduct.id}" : "",
      style: TextStyle(fontSize: 16.0),
    );

    final _txtProductName = TextField(
      decoration: InputDecoration(
          hintText: "Nhập tên sản phẩm",
          contentPadding: EdgeInsets.all(10.0),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
          labelText: "Tên sản phẩm"),
      autocorrect: false,
      controller: TextEditingController(
          text: this.prodduct.name != null ? "${this.prodduct.name}" : ""),
      textAlign: TextAlign.left,
      onChanged: (text) {
        widget.name = text;
      },
    );

    final _txtProductPrice = new TextField(
      decoration: InputDecoration(
          hintText: "Nhập giá",
          contentPadding: EdgeInsets.all(10.0),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
          labelText: "Giá"),
      autocorrect: false,
      controller: TextEditingController(
          text: this.prodduct.price != null ? "${this.prodduct.price}" : "0"),
      textAlign: TextAlign.left,
      onChanged: (text) {
        widget.price = text;
      },
      keyboardType: TextInputType.number,
    );

    final _txtCatalogID = new TextField(
      decoration: InputDecoration(
          hintText: "Nhập mã danh mục",
          contentPadding: EdgeInsets.all(10.0),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
          labelText: "Danh mục"),
      autocorrect: false,
      controller: TextEditingController(
          text: this.prodduct.catalog_id != null
              ? "${this.prodduct.catalog_id}"
              : ""),
      // textAlign: TextAlign.left,
      onChanged: (text) {
        widget.catalog_id = text;
      },
      textCapitalization: TextCapitalization.characters,
    );

    final _txtProductDiscount = new TextField(
      decoration: InputDecoration(
          hintText: "Nhập mức giảm giá",
          contentPadding: EdgeInsets.all(10.0),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
          labelText: "Giảm giá (%)"),
      autocorrect: false,
      controller: TextEditingController(
          text: this.prodduct.discount != null
              ? "${this.prodduct.discount}"
              : "0"),
      onChanged: (text) {
        widget.discount = text;
      },
      keyboardType: TextInputType.number,
    );

    _update() async {
      Map<String, dynamic> params = Map<String, dynamic>();
      params['id'] = widget.id.toString();
      params['catalog_id'] = widget.catalog_id;
      params['name'] = widget.name;
      params['price'] = widget.price;
      params['discount'] = widget.discount;
      await updateProduct(http.Client(), params);
    }

    final _btnSave = ElevatedButton(
      onPressed: () async {
        if (widget.catalog_id.isEmpty ||
            widget.name.isEmpty ||
            widget.price.isEmpty ||
            widget.discount.isEmpty) {
          showToast("Cần nhập đầy đủ thông tin");
        } else {
          await _update();
          Navigator.of(context).pop();
        }
      },
      child: Text("Lưu"),
      style: ElevatedButton.styleFrom(primary: Colors.orangeAccent),
    );

    final _btnDelete = ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => AlertDialog(
                  title: Text("Xác nhận xóa"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text("Bạn có muốn xóa sản phẩm ${this.prodduct.name} hay không?")
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () async {
                          await deleteProduct(http.Client(), this.prodduct.id);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text("Xóa")),
                    TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        child: Text("Hủy")),
                  ],
                ));
      },
      child: Text("Xóa"),
      style: ElevatedButton.styleFrom(primary: Colors.redAccent),
    );

    final _column = SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Mã sản phẩm: ",
                style: TextStyle(fontSize: 16.0),
              ),
              _txtProductID,
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: _txtProductName,
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: _txtProductPrice,
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: _txtProductDiscount,
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: _txtCatalogID,
        ),
        Row(
          children: <Widget>[
            Expanded(child: _btnSave),
            Expanded(child: _btnDelete),
          ],
        )
      ],
    ));

    return Container(
      margin: EdgeInsets.all(10.0),
      child: _column,
    );
  }
}
