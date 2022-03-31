import 'package:do_an/models/catalog.dart';
import 'package:do_an/models/product.dart';
import 'package:do_an/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductPage extends StatefulWidget {
  @override
  State<AddProductPage> createState() {
    // TODO: implement createState
    return _ProductAddState();
  }
}

class _ProductAddState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết sản phẩm"),
        ),
        body: _Detail());
  }
}

class _Detail extends StatefulWidget {
  String name = "", catalog_id = "", price = "", discount = "";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailState();
  }
}

class _DetailState extends State<_Detail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final _txtProductID = Text(
      "",
      style: TextStyle(fontSize: 16.0),
    );

    final _txtProductName = new TextField(
      decoration: InputDecoration(
          hintText: "Nhập tên sản phẩm",
          contentPadding: EdgeInsets.all(10.0),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
          labelText: "Tên sản phẩm"),
      autocorrect: false,
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
      onChanged: (text) {
        widget.price = text;
      },
      keyboardType: TextInputType.number,
    );

    CatalogModel _selected =new CatalogModel();

    final _dropCatalog = FutureBuilder(
        future: getAllCatalog(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          List<DropdownMenuItem<CatalogModel>> catalogDrop = [];
          List<CatalogModel> list = snapshot.data as List<CatalogModel>;
          list.forEach((element) {
            catalogDrop.add(DropdownMenuItem(
              child: Text(element.name),
              value: element,
            ));
          });
          return DropdownButton(
            items: catalogDrop,
            hint: Text("Chọn phòng ban"),
            onChanged: (value) {
              _selected = value as CatalogModel;
              widget.catalog_id =_selected.catalog_id;
              showToast("Bạn vừa chọn danh mục ${_selected.name}");
              setState(() {});
            },
          );
        });

    final _txtProductDiscount = new TextField(
      decoration: InputDecoration(
          hintText: "Nhập mức giảm giá",
          contentPadding: EdgeInsets.all(10.0),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
          labelText: "Giảm giá (%)"),
      autocorrect: false,
      onChanged: (text) {
        widget.discount = text;
      },
      keyboardType: TextInputType.number,
    );

    _insert() async {
      Map<String, dynamic> params = Map<String, dynamic>();
      params['catalog_id'] = widget.catalog_id;
      params['name'] = widget.name;
      params['price'] = widget.price.toString();
      params['discount'] = widget.discount.toString();
      await insertProduct(http.Client(), params);
    }

    final _btnSave = ElevatedButton(
      onPressed: () async {
        if (widget.catalog_id.isEmpty ||
            widget.name.isEmpty ||
            widget.price.isEmpty ||
            widget.discount.isEmpty) {
          showToast("Cần nhập đầy đủ thông tin");
        } else {
          await _insert();
          Navigator.of(context).pop();
        }
      },
      child: Text("Lưu"),
      style: ElevatedButton.styleFrom(primary: Colors.orangeAccent),
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
          child: _dropCatalog,
        ),
        Row(
          children: <Widget>[
            Expanded(child: _btnSave),
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
