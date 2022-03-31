import 'package:do_an/models/catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatalogDetailPage extends StatefulWidget {
  final String id;

  CatalogDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CatalogDetailPage> createState() {
    // TODO: implement createState
    return _CatalogDetailState();
  }
}

class _CatalogDetailState extends State<CatalogDetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
      ),
      body: FutureBuilder(
          future: getCatalogById(http.Client(), widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              CatalogModel cata = snapshot.data as CatalogModel;
              return _Detail(cata: cata);
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
  final CatalogModel cata;

  _Detail({Key? key, required this.cata}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailState();
  }
}

class _DetailState extends State<_Detail> {
  CatalogModel catalog = CatalogModel();
  bool kTraLoad = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (kTraLoad == false) {
      setState(() {
        this.catalog = CatalogModel.fromCatalog(widget.cata);
        this.kTraLoad = true;
      });
    }

    final _txtCatalogQty = Text(
      "${this.catalog.soLuong}",
      style: TextStyle(fontSize: 16.0),
    );

    final _txtCatalogName = TextField(
      decoration: InputDecoration(
          hintText: "Nhập tên sản phẩm",
          contentPadding: EdgeInsets.all(10.0),
          border:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white12)),
          labelText: "Tên sản phẩm"),
      autocorrect: false,
      controller: TextEditingController(
          text: this.catalog.name != null ? "${this.catalog.name}" : ""),
      onChanged: (text) {
        this.catalog.name = text;
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
      controller: TextEditingController(
          text: this.catalog.catalog_id != null
              ? "${this.catalog.catalog_id}"
              : ""),
      onChanged: (text) {
        this.catalog.catalog_id = text;
      },
      textCapitalization: TextCapitalization.characters,
    );

    _update() async {
      Map<String, dynamic> params = Map<String, dynamic>();
      params['catalog_id'] = this.catalog.catalog_id;
      params['name'] = this.catalog.name;
      await updateCatalog(http.Client(), params);
    }

    final _btnSave = ElevatedButton(
      onPressed: () async {
        await _update();
        Navigator.of(context).pop();
      },
      child: Text("Lưu"),
      style: ElevatedButton.styleFrom(primary: Colors.orangeAccent),
    );

    final _btnDelete = ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) =>
                AlertDialog(
                  title: Text("Xác nhận xóa danh mục"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text("Bạn có muốn xóa danh mục ${this.catalog.name} hay không?")
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () async {
                          await deleteCatalog(
                              http.Client(), this.catalog.catalog_id);
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
              child: _txtCatalogID,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: _txtCatalogName,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Text("Số lượng: ", style: TextStyle(fontSize: 16.0),),
                  _txtCatalogQty,
                ],
              )
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
