var mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'dbsanpham'
});

connection.connect(function(err, result) {
    if(err) throw err;
    else console.log("Ket Noi thanh cong!");
    
});

module.exports = connection;