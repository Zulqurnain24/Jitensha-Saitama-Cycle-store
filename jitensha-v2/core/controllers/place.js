/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const PlaceModel = require('../models').PlaceModel;

const PlaceController = {
    list: function *() {
        const query = PlaceModel.find({});
        this.body = { places: yield query.select('-__v -_id').exec() };
    }
}

module.exports = PlaceController;
