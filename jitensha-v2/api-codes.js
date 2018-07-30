/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const HttpStatus = require('http-status-codes');

const ApiCodes = {};

ApiCodes[exports.EMAIL_TAKEN         = 1000] = 'EmailAlreadyTaken';
ApiCodes[exports.USER_NOT_FOUND      = 1001] = 'UserNotFound';
ApiCodes[exports.PLACE_NOT_FOUND     = 1002] = 'PlaceNotFound';
ApiCodes[exports.INVALID_CRED_CARD   = 1003] = 'InvalidCreditCard';
ApiCodes[exports.PAYMENT_SUCCESS     = 1004] = 'PaymentSuccess';
ApiCodes[exports.REQUIRED_FIELD      = 1005] = 'MissingRequiredField';
ApiCodes[exports.INVALID_JSON_REQ    = 1006] = 'InvalidJsonRequest';
ApiCodes[exports.RESOURCE_NOT_FOUND  = HttpStatus.NOT_FOUND] = 'ResourceNotFound';
ApiCodes[exports.UNAUTHORIZED        = HttpStatus.UNAUTHORIZED] = 'Unauthorized';
ApiCodes[exports.SERVER_ERROR        = HttpStatus.INTERNAL_SERVER_ERROR] = 'InternalServerError';
ApiCodes[exports.METHOD_NOT_ALLOWED  = HttpStatus.METHOD_NOT_ALLOWED] = 'MethodNotAllow';
ApiCodes[exports.INVALID_ENTITY      = HttpStatus.UNPROCESSABLE_ENTITY] = 'InvalidJsonFormat';

exports.getCodeDesc = (apiCode) => {
    if (ApiCodes.hasOwnProperty(apiCode)) {
	    return ApiCodes[apiCode];
	} else {
	    throw new Error('Status code does not exist: ' + statusCode);
	}
};
