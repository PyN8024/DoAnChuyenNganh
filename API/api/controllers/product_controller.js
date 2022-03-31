var Product = require('../models/product');

exports.get_list = function (req, res){
    Product.get_all(function (data) {
        res.send({result: data});
    });
}

exports.details = function (req, res){
    Product.getByID(req.params.id, function (data) {
        res.send({result: data});
    });
}

exports.get_list_by_catalog_id = function (req, res){
    Product.getByCatalogId(req.params.catalogId, function(data){
        res.send({result: data});
    })
}

exports.add_product = function (req, res){
    var data = req.body;
    Product.create(data, function(response){
        res.send({result: response});
    });
}

exports.delete_product = function (req, res){
    var id = req.params.id;
    Product.remove(id, function(response){
        res.send({result: response});
    })
}

exports.update_product = function (req, res){
    var data = req.body;
    Product.update(data, function(response){
        res.send({result: response});
    })
}