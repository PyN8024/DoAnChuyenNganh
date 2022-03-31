const db = require('../database/mysql');

const Catalog = function (catalog){
    this.catalog_id = catalog.catalog_id;
    this.name = catalog.name;
    this.soluong = catalog.soluong;
}

Catalog.get_all = function(result){
    db.query("SELECT c.catalog_id, c.name, COUNT(p.id) AS soluong FROM catalog as c LEFT JOIN product as p on c.catalog_id = p.catalog_id GROUP BY c.catalog_id ", function(err, catalog){
        if(err){
            result(err);
        }else{
            result(catalog);
        }
    });
}

Catalog.get_details_by_id = function(id, result){
    db.query("SELECT c.catalog_id, c.name, COUNT(p.id) AS soluong FROM catalog as c JOIN product as p on c.catalog_id = p.catalog_id WHERE c.catalog_id = ?", id, function(err, catalog){
        if(err || catalog.length == 0){
            result(null);
        } else {
            result(catalog[0]);
        }
    });
}

Catalog.get_details_by_name = function(id, result){
    db.query("SELECT c.catalog_id, c.name, COUNT(p.id) AS soluong FROM catalog as c JOIN product as p on c.catalog_id = p.catalog_id WHERE c.name = ?", id, function(err, catalog){
        if(err || catalog.length == 0){
            result(null);
        } else {
            result(catalog[0]);
        }
    });
}
Catalog.create_catalog = function(data, result){
    db.query("INSERT INTO `catalog`(`catalog_id`, `name`) VALUES (?, ?)", [data.catalog_id, data.name], function(err, catalog){
        if(err) {
            result(null);
        } else {
            result(catalog);
        }
    });
}

Catalog.remove = function(id, result){
    db.query("DELETE FROM catalog WHERE catalog_id = ? ", id, function(err){
        if(err){
            result(null);
        } else {
            result("Xóa danh mục thành công!");
        }
    });
}

Catalog.update = function(data, result){
    db.query("UPDATE `catalog` SET name = ? WHERE catalog_id = ?", [data.name, data.catalog_id], function(err, catalog){
        if(err){
            result(null);
        } else {
            result(catalog);
        }
    });
}

module.exports = Catalog;