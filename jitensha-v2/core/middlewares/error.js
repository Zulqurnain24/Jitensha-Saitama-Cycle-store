/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const ApiCodes       = require('../../api-codes');
const HttpStatus     = require('http-status-codes');
const MessageFactory = require('../util/message-factory');

function error(statusCode, apiCode) {
    return function *(next) {
    	try {
    		yield next;
        	if (this.status === statusCode) {
                this.status = statusCode;
                this.body = MessageFactory.message(apiCode);    		
        	}
        } catch (err) {
            this.status = err.status || HttpStatus.INTERNAL_SERVER_ERROR;
            this.body = MessageFactory.message(this.status);
            this.app.emit('error', err, this);        		
    	}
    }
};

module.exports = error;
