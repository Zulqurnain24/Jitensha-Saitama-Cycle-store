/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const UserModel     = require('../models').UserModel;
const PlaceModel    = require('../models').PlaceModel;
const PaymentModel  = require('../models').PaymentModel;
const ApiCodes      = require('../../api-codes');
const HttpStatus    = require('http-status-codes');
const MesageFactory = require('../util/message-factory');

const PaymentController = {
    getPayments: function *() {
        const query = PaymentModel.find({ email: this.state.user.email });
        this.body = { payments: yield query.select('-__v -_id -creditCard._id').exec() };      
    },
    pay: function *() {
    	const body = this.request.body;
        const place = yield PlaceModel.findOne({ id: body.placeId });
        if (place === null) {
            this.status = HttpStatus.BAD_REQUEST;
            this.body = MesageFactory.message(ApiCodes.PLACE_NOT_FOUND);
        } else {
        	const payment = PaymentModel.create(this.state.user.email, body);
            const error = yield this.ModelValidator.validate(payment);
            if (error) {
            	this.status = HttpStatus.BAD_REQUEST;
                this.body = MesageFactory.message(ApiCodes.INVALID_JSON_REQ, error);
            } else if (payment.isCreditCardValid()) {
        		yield payment.save();
                this.body = MesageFactory.message(ApiCodes.PAYMENT_SUCCESS);
            } else {
            	this.status = HttpStatus.BAD_REQUEST;
                this.body = MesageFactory.message(ApiCodes.INVALID_CRED_CARD);
            }    	
        }
    }
}

module.exports = PaymentController;
