var mysql = require('mysql');
var config = require('config');
var dbConfig = config.get('dbConfig');
var helper = require('./helpers');

// Ensure helpers functions are properly imported
const { Dlog, serverYYYYMMDDHHmmss, ThorwHtmlError } = helper;

var db = mysql.createConnection(dbConfig);

function reconnect(connection, callback) {
    Dlog(`\n New connection tentative ... (${serverYYYYMMDDHHmmss()})`);
    connection = mysql.createConnection(dbConfig);
    connection.connect((err) => {
        if (err) {
            ThorwHtmlError(err);
            setTimeout(() => {
                Dlog(`------------- DB ReConnecting Error (${serverYYYYMMDDHHmmss()}) -------------`);
                reconnect(connection, callback);
            }, 5 * 1000);
        } else {
            Dlog('------------- New connection established with database -------------');
            db = connection;
            callback();
        }
    });

    connection.on('error', (err) => {
        Dlog(`------------- App is connection crash DB Helper (${serverYYYYMMDDHHmmss()}) -------------`);
        if ([
            "PROTOCOL_CONNECTION_LOST",
            "PROTOCOL_ENQUEUE_AFTER_QUIT",
            "PROTOCOL_ENQUEUE_AFTER_FATAL_ERROR",
            "PROTOCOL_ENQUEUE_HANDSHAKE_TWICE",
            "ECONNREFUSED",
            "PROTOCOL_PACKETS_OUT_OF_ORDER"
        ].includes(err.code)) {
            Dlog(`/!\\ ${err.code} cannot establish a connection with the database. /!\\ (${err.code})`);
            reconnect(db, callback);
        } else {
            throw err;
        }
    });
}

module.exports = {
    query: (sqlQuery, args, callback) => {
        if (db.state === 'authenticated' || db.state === 'connected') {
            db.query(sqlQuery, args, (error, result) => {
                callback(error, result);
            });
        } else if (db.state === 'protocol_error') {
            reconnect(db, () => {
                db.query(sqlQuery, args, (error, result) => {
                    callback(error, result);
                });
            });
        } else {
            reconnect(db, () => {
                db.query(sqlQuery, args, (error, result) => {
                    callback(error, result);
                });
            });
        }
    }
};

process.on('uncaughtException', (err) => {
    Dlog(`------------- App is Crash DB Helper (${serverYYYYMMDDHHmmss()}) -------------`);
    Dlog(err.code);
    ThorwHtmlError(err);
});
