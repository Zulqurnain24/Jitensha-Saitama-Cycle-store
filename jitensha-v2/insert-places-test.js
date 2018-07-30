/*
 * Copyright (c) 2016, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const fs         = require('fs');
const Promise    = require('bluebird');
const database   = require('./core/db/mongoose');
const PlaceModel = require('./core/models').PlaceModel;

(Promise.coroutine(function *() {
    yield PlaceModel.remove({});
	const places = JSON.parse(fs.readFileSync('./config/places.json', 'utf8'));
    for (const place of places.results) {
    	const placeModel = new PlaceModel({
    		id: place.id,
    		name: place.name,
    		location: place.location
    	});
    	yield placeModel.save();
    }
    database.disconnect();
}))();