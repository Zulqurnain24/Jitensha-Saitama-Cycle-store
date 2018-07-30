/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

/**
 * @apiDefine UserAuthentication
 *
 * @apiHeader {String} Authorization Bearer token
 */

/**
 * @apiDefine Unauthorized
 * 
 * @apiError Unauthorized Invalid or missing required authentication token
 * 
 * @apiErrorExample Error-Response:
 * HTTP/1.1 401 Unauthorized
 * {
 *     "message": "Unauthorized",
 *     "code": 401
 * }
 * 
 */

/**
 * @apiDefine InvalidJson
 * 
 * @apiError InvalidJson Invalid json format
 * 
 * @apiErrorExample Error-Response:
 * HTTP/1.1 422 Unprocessable Entity
 * {
 *     "message": "InvalidJson",
 *     "code": 422
 * }
 * 
 */
module.exports = {
    UserRouter: require('./user'),
    PlaceRouter: require('./place'),
    PaymentRouter: require('./payment')
};
