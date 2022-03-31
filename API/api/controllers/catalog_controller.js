var Catalog = require('../models/catalog');

exports.get_list = function(req, res){
    Catalog.get_all(function(data){
        res.send({result: data});
    });
}

exports.details = function(req, res){
    Catalog.get_details_by_id(req.params.id, function(data){
        res.send({result: data});
    })
}

exports.detailsByName = function(req, res){
    Catalog.get_details_by_name(req.params.id, function(data){
        res.send({result: data});
    })
}

exports.add_catalog = function(req, res){
    var data = req.body;
    Catalog.create_catalog(data,function(response){
        res.send({result: response});
    })
}

exports.delete_catalog = function(req, res){
    var id = req.params.id;
    Catalog.remove(id,function(response){
        res.send({result: response});
    })
}

exports.update_catalog = function(req, res){
    var data = req.body;
    Catalog.update(data, function(response){
        res.send(response);
    })
}

