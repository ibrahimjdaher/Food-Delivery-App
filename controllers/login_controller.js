const db = require('./../helpers/db_helpers');
const helper = require('./../helpers/helpers');

const msg_success = "Operation successful.";
const msg_fail = "Operation failed.";
const msg_invalidUserPassword = "Invalid username and password.";
const msg_invalidUser = "Invalid username.";
const msg_exist_email = "Email already in use.";
const msg_exist_user = "User does not exist.";
const msg_update_password = "User password updated successfully.";

module.exports.controller = (app, io, socket_list) => {

    app.post('/api/login', (req, res) => {
        helper.Dlog(req.body);
        const reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["email", "password"], () => {
            getUserWithPasswordData(reqObj.email, reqObj.password, (status, result) => {
                if (status) {
                    const auth_token = helper.createRequestToken();
                    db.query('UPDATE `users_details` SET `auth_token` = ? WHERE `user_id` = ? AND `status` = ?', [auth_token, result.user_id, "1"], (err, uResult) => {
                        if (err) {
                            helper.ThorwHtmlError(err, res);
                            return;
                        }
                        if (uResult.affectedRows > 0) {
                            result.auth_token = auth_token;
                            res.json({ "status": "1", "payload": result, "message": msg_success });
                        } else {
                            res.json({ "status": "0", "message": msg_invalidUserPassword });
                        }
                    });
                } else {
                    res.json({ "status": "0", "message": result });
                }
            });
        });
    });

    app.post('/api/sign_up', (req, res) => {
        console.log('Received sign-up request:', req.body);
        helper.Dlog(req.body);
        const reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["name", "mobile", "email", "address", "password", "push_token", "device_type"], () => {
            db.query("SELECT `user_id`, `email` FROM `users_details` WHERE `email` = ?", [reqObj.email], (err, result) => {
                if (err) {
                    console.error("Error checking email existence:", err);
                    helper.ThorwHtmlError(err, res);
                    return;
                }

                if (result.length === 0) {
                    // Email not found, proceed with signup
                    const authToken = helper.createRequestToken();
                    const resetCode = helper.createNumber();

                    db.query('INSERT INTO `users_details`(`name`, `email`, `password`, `mobile`, `address`, `device_type`, `auth_token`, `push_token`, `reset_code`, `created_date`, `update_date`, `status`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)', [
                        reqObj.name,
                        reqObj.email,
                        reqObj.password,
                        reqObj.mobile,
                        reqObj.address,
                        reqObj.device_type,
                        authToken,
                        reqObj.push_token,
                        resetCode,
                        "1" // Assuming 'status' should be set to '1' for active users
                    ], (err, iResult) => {
                        if (err) {
                            console.error("Error inserting user details:", err);
                            helper.ThorwHtmlError(err, res);
                            return;
                        }

                        if (iResult && iResult.insertId) {
                            getUserData(iResult.insertId, (userObj) => {
                                if (userObj) {
                                    res.json({ "status": "1", "payload": userObj, "message": msg_success });
                                } else {
                                    res.status(500).json({ "status": "0", "message": "Failed to retrieve user data after insertion." });
                                }
                            });
                        } else {
                            res.status(500).json({ "status": "0", "message": msg_fail });
                        }
                    });

                } else {
                    res.json({ "status": "0", "message": msg_exist_email });
                }
            });
        });
    });

    app.post('/api/forgot_password_request', (req, res) => {
        helper.Dlog(req.body);
        const reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["email"], () => {
            db.query("SELECT `user_id`, `email` FROM `users_details` WHERE `email` = ?", [reqObj.email], (err, result) => {
                if (err) {
                    helper.ThorwHtmlError(err, res);
                    return;
                }

                if (result.length > 0) {
                    // Email Found, proceed with generating reset code
                    const resetCode = helper.createNumber();
                    db.query('UPDATE `users_details` SET `reset_code`= ? WHERE `email` = ? AND `status` = ?', [resetCode, reqObj.email, "1"], (err, uResult) => {
                        if (err) {
                            helper.ThorwHtmlError(err, res);
                            return;
                        }
                        if (uResult.affectedRows > 0) {
                            res.json({ "status": "1", "message": msg_success });
                        } else {
                            res.json({ "status": "0", "message": msg_fail });
                        }
                    });

                } else {
                    res.json({ "status": "0", "message": msg_exist_user });
                }
            });
        });
    });

    app.post('/api/forgot_password_verify', (req, res) => {
        helper.Dlog(req.body);
        const reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["email", "reset_code"], () => {
            db.query("SELECT `user_id`, `email` FROM `users_details` WHERE `email` = ? AND `reset_code` = ?", [reqObj.email, reqObj.reset_code], (err, result) => {
                if (err) {
                    helper.ThorwHtmlError(err, res);
                    return;
                }

                if (result.length > 0) {
                    // User found, proceed with updating reset code
                    const newResetCode = helper.createNumber();
                    db.query('UPDATE `users_details` SET `reset_code`= ? WHERE `email` = ? AND `status` = ?', [newResetCode, reqObj.email, "1"], (err, uResult) => {
                        if (err) {
                            helper.ThorwHtmlError(err, res);
                            return;
                        }
                        if (uResult.affectedRows > 0) {
                            res.json({ "status": "1", "payload": { "user_id": result[0].user_id, "reset_code": newResetCode }, "message": msg_success });
                        } else {
                            res.json({ "status": "0", "message": msg_fail });
                        }
                    });
                } else {
                    res.json({ "status": "0", "message": msg_exist_user });
                }
            });
        });
    });

    app.post('/api/forgot_password_set_new', (req, res) => {
        helper.Dlog(req.body);
        const reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["user_id", "reset_code", "new_password"], () => {
            const newResetCode = helper.createNumber();
            db.query("UPDATE `users_details` SET `password` = ?, `reset_code` = ? WHERE `user_id` = ? AND `reset_code` = ? AND `status` = ?", [reqObj.new_password, newResetCode, reqObj.user_id, reqObj.reset_code, "1"], (err, result) => {
                if (err) {
                    helper.ThorwHtmlError(err, res);
                    return;
                }
                if (result.affectedRows > 0) {
                    // Password updated successfully
                    res.json({ "status": "1", "message": msg_update_password });
                } else {
                    res.json({ "status": "0", "message": msg_fail });
                }
            });
        });
    });

};

function getUserData(user_id, callback) {
    db.query('SELECT `user_id`, `name`, `email`, `password`, `mobile`, `address`, `image`, `device_type`, `auth_token` FROM `users_details` WHERE `user_id` = ? AND `status` = ?', [user_id, '1'], (err, result) => {
        if (err) {
            console.error("Error retrieving user data:", err);
            helper.ThorwHtmlError(err); // Assuming helper.ThorwHtmlError is a typo, it should be helper.ThrowHtmlError
            return;
        }

        if (result.length > 0) {
            callback(result[0]);
        } else {
            callback(null);
        }
    });
}

function getUserWithPasswordData(email, password, callback) {
    db.query('SELECT `user_id`, `name`, `email`, `password`, `mobile`, `address`, `image`, `device_type`, `auth_token`, `status` FROM `users_details` WHERE `email` = ? AND `password` = ? AND `status` = ?', [email, password, '1'], (err, result) => {
        if (err) {
            helper.ThorwHtmlError(err);
            return callback(false, msg_fail);
        }

        if (result.length > 0) {
            return callback(true, result[0]);
        } else {
            return callback(false, msg_invalidUserPassword);
        }
    });
}
