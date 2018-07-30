/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const Jwt           = require('koa-jwt');
const config        = require('../../config/config');
const ApiCodes      = require('../../api-codes');
const UserModel     = require('../models').UserModel;
const HttpStatus    = require('http-status-codes');
const MesageFactory = require('../util/message-factory');

const UserController = {
    authenticate: function *() {
    	const body = this.request.body;
        const user = yield UserModel.findOne({ email: body.email });
        if ((user !== null) && (user.checkPassword(body.password))) {
            this.body = { token: Jwt.sign({ email: user.email }, config.get('secret')) };
        } else {
            this.status = HttpStatus.BAD_REQUEST;
            this.body = MesageFactory.message(ApiCodes.USER_NOT_FOUND);
        }
    },
    register: function *() {
        const body = this.request.body;
        const user = yield UserModel.findOne({ email: body.email });
        if (user === null) {
            const newUser = UserModel.create(body);
            const error = yield this.ModelValidator.validate(newUser);
            if (error) {
            	this.status = HttpStatus.BAD_REQUEST;
            	this.body = MesageFactory.message(ApiCodes.INVALID_JSON_REQ, error);
            } else {
                yield newUser.save();
                this.body = { token: Jwt.sign({ email: newUser.email }, config.get('secret')) };            	
            }
        } else {
            this.status = HttpStatus.BAD_REQUEST;
            this.body = MesageFactory.message(ApiCodes.EMAIL_TAKEN);
        }
    }
};

module.exports = UserController;
