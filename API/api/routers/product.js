
module.exports = function (router){
    var controller = require("../controllers/product_controller");

    router.get('/product/list', controller.get_list);
    
    router.get('/product/detail/:id', controller.details);

    router.get('/product/listInCatalog/:catalogId', controller.get_list_by_catalog_id);

    router.post('/product/add', controller.add_product);

    router.delete('/product/delete/:id', controller.delete_product);

    router.put('/product/update', controller.update_product);
};