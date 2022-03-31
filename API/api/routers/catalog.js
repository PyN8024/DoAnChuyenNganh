module.exports = function (router){
    var controller = require("../controllers/catalog_controller");

    router.get('/catalog/list', controller.get_list);
    
    router.get('/catalog/detail/:id', controller.details);

    router.get('/catalog/detail/:name', controller.detailsByName);

    router.post('/catalog/add', controller.add_catalog);

    router.delete('/catalog/delete/:id', controller.delete_catalog);

    router.put('/catalog/update', controller.update_catalog);
};