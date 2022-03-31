const db = require('../database/mysql');

const Product = function(product){
    this.id = product.id;  
    this.catalog_id = product.catalog_id;
    this.name = product.name;
    this.price = product.price;
    this.discount = product.discount;
    this.image = product.image;

}

Product.get_all = function(result){
    db.query("SELECT * FROM product", function(err, products){
        if(err){
            result(null);
        } else {
            result(products);
        }
    });
}

Product.getByID = function(id, result){
    db.query("SELECT * FROM product WHERE id = ?", id, function(err, product){
        if(err || product.length == 0){
            result(null);
        }else{
            result(product[0]);
        }
    });
}

Product.getByCatalogId =function(catalog_id, result){
    db.query("SELECT * FROM `product` WHERE `catalog_id` = ?", catalog_id, function(err, products){
        if(err){
            result(null);
        } else {
            result(products)
        }
    });
}

Product.create = function(data, result){
    db.query("INSERT INTO `product` (`id`, `catalog_id`, `name`, `price`, `discount`, `image`) VALUES (NULL, ?, ?, ?, ?, NULL)", [ data.catalog_id, data.name, data.price, data.discount], function(err, product) {
        if(err){
            result(null);
        }else{
            result({id: product.insertID, ...data});
        }
    });
}

Product.remove = function(id, result){
    db.query("DELETE FROM `product` WHERE `id`= ?", id, function(err){
        if(err){
            result(null);
        }else{
            result("Xóa sản phẩm thành công!");
        }
    });
}

Product.update = function(data, result){
    db.query("UPDATE product SET catalog_id=?, name = ?, price = ?, discount = ?, image = ? WHERE id = ?", [data.catalog_id, data.name, data.price, data.discount, data.image, data.id], function(err) {
        if(err){
            result(null);
        }else{
            result("OK");
        }
    });
}

module.exports = Product;