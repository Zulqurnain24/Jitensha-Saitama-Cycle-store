/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const Router         = require('koa-router')({ prefix: '/api/v2.0/users' });
const UserController = require('../controllers').UserController;

/**
 * @api {post} /users/ User authentication end point
 * @apiName PostUser
 * @apiGroup User
 * 
 * @apiParam  {String} email email of the User.
 * @apiParam  {String} password password of the User.
 * 
 * @apiSuccess {String} generated token.
 * 
 * @apiExample Body-Request:
 * {
 *     "email": "crossover@crossover.com",
 *     "password": "crossover"
 * }
 * 
 * @apiSuccessExample Success-Response:
 * HTTP/1.1 200 OK
 * {
 *     "token": "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2p3dC1pZHAuZXhhbXBsZS5jb20iLCJzdWIiOiJtYWlsdG86bWlrZUBleGFtcGxlLmNvbSIsIm5iZiI6MTQ4MzQwOTk5NywiZXhwIjoxNDgzNDEzNTk3LCJpYXQiOjE0ODM0MDk5OTcsImp0aSI6ImlkMTIzNDU2IiwidHlwIjoiaHR0cHM6Ly9leGFtcGxlLmNvbS9yZWdpc3RlciJ9"
 * }
 * 
 * @apiError UserNotFound user not found.
 *
 * @apiErrorExample Error-Response:
 * HTTP/1.1 400 Bad Request
 * {
 *     "message": "UserNotFound",
 *     "code": 1001
 * }
 * 
 * @apiUse InvalidJson
 * 
 */
Router.post('/', UserController.authenticate);

/**
 * @api {put} /users/ User register end point
 * @apiName PutUser
 * @apiGroup User
 * 
 * @apiParam  {String} email email of the User.
 * @apiParam  {String} password password of the User.
 * 
 * @apiSuccess {String} generated token.
 * 
 * @apiExample Body-Request:
 * {
 *     "email": "crossover@crossover.com",
 *     "password": "crossover"
 * }
 * 
 * @apiSuccessExample Success-Response:
 * HTTP/1.1 200 OK
 * {
 *     "token": "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2p3dC1pZHAuZXhhbXBsZS5jb20iLCJzdWIiOiJtYWlsdG86bWlrZUBleGFtcGxlLmNvbSIsIm5iZiI6MTQ4MzQwOTk5NywiZXhwIjoxNDgzNDEzNTk3LCJpYXQiOjE0ODM0MDk5OTcsImp0aSI6ImlkMTIzNDU2IiwidHlwIjoiaHR0cHM6Ly9leGFtcGxlLmNvbS9yZWdpc3RlciJ9"
 * }
 * 
 * @apiError EmailAlreadyTaken email already taken.
 *
 * @apiErrorExample Error-Response:
 * HTTP/1.1 400 Bad Request
 * {
 *     "message": "EmailAlreadyTaken",
 *     "code": 1000
 * }
 * 
 * @apiUse InvalidJson
 * 
 */
Router.put('/',  UserController.register);

module.exports = Router;
