const helper = require('../helpers/helpers');
const db = require('../helpers/db_helpers');

module.exports.controller = (app, io, socket_list) => {
    const msg_success = "successfully";
    const msg_fail = "fail";
    const msg_invalidUser = "invalid username and password";

    io.on('connection', (client) => {
        client.on('UpdateSocket', (data) => {
            helper.Dlog('UpdateSocket :- ' + data);
            let jsonObj;
            
            try {
                jsonObj = JSON.parse(data);
            } catch (e) {
                helper.ThorwSocketError(new Error("Invalid JSON format"), client, "UpdateSocket");
                return;
            }

            helper.CheckParameterValidSocket(client, "UpdateSocket", jsonObj, ['user_id'], () => {
                db.query("SELECT `user_id`, `email` FROM `users_details` WHERE `user_id` = ?;", [jsonObj.user_id], (err, result) => {
                    if (err) {
                        helper.ThorwSocketError(err, client, "UpdateSocket");
                        return;
                    }

                    if (result.length > 0) {
                        socket_list['us_' + jsonObj.user_id] = { 'socket_id': client.id };
                        helper.Dlog(socket_list);
                        const response = { "success": "true", "status": "1", "message": msg_success };
                        client.emit('UpdateSocket', response);
                    } else {
                        const response = { "success": "false", "status": "0", "message": msg_invalidUser };
                        client.emit('UpdateSocket', response);
                    }
                });
            });
        });
    });
}
