/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const Router          = require('koa-router')({ prefix: '/api/v2.0/places' });
const PlaceController = require('../controllers').PlaceController;

/**
 * @api {get} /places/ Place list end point
 * @apiName GetPlace
 * @apiGroup Place
 *  
 * @apiSuccess {Place[]} places list of places
 *  
 * @apiSuccessExample Success-Response:
 * HTTP/1.1 200 OK
 * {
 *     "places": [
 *       {
 *         "updatedAt": "2016-12-23T19:31:10.340Z",
 *         "createdAt": "2016-12-23T19:31:10.340Z",
 *         "id": "45c0b5209973fcec652817e16e20f1d0b4ecb602",
 *         "name": "Tokyo",
 *         "location": {
 *           "lat": "35.7090259",
 *           "lng": "139.7319925"
 *         }
 *       }, 
 *       {
 *         "updatedAt": "2016-12-23T19:31:10.354Z",
 *         "createdAt": "2016-12-23T19:31:10.354Z",
 *         "id": "83489d15abb8214530f554d5731b902bf4de9d08",
 *         "name": "Hotel Mid In Akabane Ekimae",
 *         "location": {
 *           "lat": "35.776904",
 *           "lng": "139.7222837"
 *    
 *         }
 *       }]
 *  }
 * 
 */
Router.get('/', PlaceController.list);

module.exports = Router;
