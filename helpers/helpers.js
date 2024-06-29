var moment = require('moment-timezone');
var fs = require('fs');

const app_debug_mode = true;
const timezone_name = "Asia/Kolkata";
const msg_server_internal_error = "Server Internal Error";

function Dlog(log) {
    if (app_debug_mode) {
        console.log(log);
    }
}

function serverDateTime(format) {
    return moment().tz(timezone_name).format(format);
}

function serverYYYYMMDDHHmmss() {
    return moment().tz(timezone_name).format('YYYY-MM-DD HH:mm:ss');
}

function ThorwHtmlError(err, res) {
    Dlog(`----------------- App Helpers Throw Crash (${serverYYYYMMDDHHmmss()}) -----------------`);
    Dlog(err.stack);

    fs.appendFile(`./crash_log/Crash${serverDateTime('YYYY-MM-DD_HH-mm-ss-SSS')}.txt`, err.stack, (fileErr) => {
        if (fileErr) {
            Dlog(fileErr);
        }
    });

    if (res) {
        res.json({ 'status': '0', "message": msg_server_internal_error });
    }
}

function ThorwSocketError(err, client, eventName) {
    Dlog(`----------------- App Helpers Throw Crash (${serverYYYYMMDDHHmmss()}) -----------------`);
    Dlog(err.stack);

    fs.appendFile(`./crash_log/Crash${serverDateTime('YYYY-MM-DD_HH-mm-ss-SSS')}.txt`, err.stack, (fileErr) => {
        if (fileErr) {
            Dlog(fileErr);
        }
    });

    if (client) {
        client.emit(eventName, { 'status': '0', "message": msg_server_internal_error });
    }
}

function CheckParameterValid(res, jsonObj, checkKeys, callback) {
    var isValid = true;
    var missingParameter = "";

    checkKeys.forEach((key) => {
        if (!Object.prototype.hasOwnProperty.call(jsonObj, key)) {
            isValid = false;
            missingParameter += `${key} `;
        }
    });

    if (!isValid) {
        if (!app_debug_mode) {
            missingParameter = "";
        }
        res.json({ 'status': '0', "message": `Missing parameter (${missingParameter})` });
    } else {
        callback();
    }
}

function CheckParameterValidSocket(client, eventName, jsonObj, checkKeys, callback) {
    var isValid = true;
    var missingParameter = "";

    checkKeys.forEach((key) => {
        if (!Object.prototype.hasOwnProperty.call(jsonObj, key)) {
            isValid = false;
            missingParameter += `${key} `;
        }
    });

    if (!isValid) {
        if (!app_debug_mode) {
            missingParameter = "";
        }
        client.emit(eventName, { 'status': '0', "message": `Missing parameter (${missingParameter})` });
    } else {
        callback();
    }
}

function createRequestToken() {
    var chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var result = '';
    for (let i = 20; i > 0; i--) {
        result += chars[Math.floor(Math.random() * chars.length)];
    }
    return result;
}

function createNumber(length = 6) {
    var chars = "0123456789";
    var result = '';
    for (let i = length; i > 0; i--) {
        result += chars[Math.floor(Math.random() * chars.length)];
    }
    return result;
}

module.exports = {
    Dlog,
    serverDateTime,
    serverYYYYMMDDHHmmss,
    ThorwHtmlError,
    ThorwSocketError,
    CheckParameterValid,
    CheckParameterValidSocket,
    createRequestToken,
    createNumber
};
