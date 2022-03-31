import 'package:do_an/models/catalog.dart';
import 'package:do_an/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCatalogPage extends StatefulWidget {
  @override
  State<AddCatalogPage> createState() {
    // TODO: implement createState
    return _ProductAddState();
  }
}

class _ProductAddState extends State<AddCatalogPage> {
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
  String catalog_id = "", name = "";

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

    final _txtCatalogName = TextField(
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

    final _txtCatalogID = new TextField(
      decoration: InputDecoration(
          hintText: "Nhập mã danh mục",
          contentPadding: EdgeInsets.all(10.0),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
          labelText: "Danh mục"),
      autocorrect: false,
      onChanged: (text) {
        widget.catalog_id = text;
      },
      textCapitalization: TextCapitalization.characters,
    );

    _insert() async {
      Map<String, dynamic> params = Map<String, dynamic>();
      params['catalog_id'] = widget.catalog_id;
      params['name'] = widget.name;
      await insertCatalog(http.Client(), params);
    }

    final _btnSave = ElevatedButton(
      onPressed: () async {
        if (widget.name.isNotEmpty || widget.catalog_id.isNotEmpty) {
          await _insert();
          Navigator.of(context).pop();
        } else {
          showToast("Cần nhập đủ thông tin!");
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
          child: _txtCatalogID,
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: _txtCatalogName,
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
