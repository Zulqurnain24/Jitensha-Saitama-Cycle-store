/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const mongoose = require('mongoose');

const PlaceSchema = new mongoose.Schema({
    id: { type: String, unique: true, required: true },
    name: { type: String, required: true },
    location: {
        lat: { type: String, required: true },
        lng: { type: String, required: true }
    }
}, 
{ 
    timestamps: true 
});

module.exports = mongoose.model('Place', PlaceSchema);
