/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const Jwt               = require('../middlewares/jwt');
const Router            = require('koa-router')({ prefix: '/api/v2.0/payments' });
const PaymentController = require('../controllers').PaymentController;

/**
 * @api {get} /payments/ Payment list end point
 * @apiName GetPayment
 * @apiGroup Payment
 * 
 * @apiUse UserAuthentication
 * 
 * @apiSuccess {Payment[]} payments user's payment list.
 * 
 * @apiSuccessExample Success-Response:
 * HTTP/1.1 200 OK
 * {
 *     "payments": [{
 *       "updatedAt": "2016-12-23T19:32:59.144Z",
 *       "createdAt": "2016-12-23T19:32:59.144Z",
 *       "creditCard": {
 *         "number": "4111111111111111",
 *         "name": "adrianobragaalencar",
 *         "cvv": "123",
 *         "expiryMonth": "03",
 *         "expiryYear": "2100"
 *       },
 *       "email": "adrianobragaalencar@gmail.com",
 *       "placeId": "45c0b5209973fcec652817e16e20f1d0b4ecb602"
 *     }, 
 *     {
 *       "updatedAt": "2016-12-23T19:33:25.497Z",
 *       "createdAt": "2016-12-23T19:33:25.497Z",
 *       "creditCard": {
 *         "number": "4111111111111111",
 *         "name": "adrianobragaalencar",
 *         "cvv": "123",
 *         "expiryMonth": "12",
 *         "expiryYear": "2020"
 *       },
 *       "email": "adrianobragaalencar@gmail.com",
 *       "placeId": "45c0b5209973fcec652817e16e20f1d0b4ecb602"
 *     }]
 * }
 * 
 * @apiUse Unauthorized
 * 
 */
Router.get('/', Jwt, PaymentController.getPayments);

/**
 * @api {put} /payments/ Payment creation end point
 * @apiName PutPayment
 * @apiGroup Payment
 * 
 * @apiUse UserAuthentication
 * 
 * @apiParam  {String} placeId place identification.
 * @apiParam  {String} number credit card number.
 * @apiParam  {String} name credit card holder name.
 * @apiParam  {String} cvv cvv.
 * @apiParam  {String} expiryMonth credit card expiration month.
 * @apiParam  {String} expiryYear credit card expiration year.
 * 
 * @apiSuccess {String} message operation description.
 * @apiSuccess {String} code operation code identification.
 * 
 * @apiSuccessExample Success-Response:
 * HTTP/1.1 200 OK
 * {
 *     "message": "PaymentSuccess",
 *     "code": 1004
 * }
 * 
 * @apiError PlaceNotFound place not found.
 *
 * @apiErrorExample Error-Response:
 * HTTP/1.1 400 Bad Request
 * {
 *     "message": "PlaceNotFound",
 *     "code": 1002
 * }
 * 
 * 
 * @apiError InvalidCreditCard invalid credit card, e.g invalid number, expiration month and/or year.
 *
 * @apiErrorExample Error-Response:
 * HTTP/1.1 400 Bad Request
 * {
 *     "message": "InvalidCreditCard",
 *     "code": 1003
 * } 
 * 
 * @apiUse Unauthorized
 * @apiUse InvalidJson
 * 
 */
Router.put('/', Jwt, PaymentController.pay);

module.exports = Router;
