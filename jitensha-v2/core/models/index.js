/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

require('../db/mongoose');

module.exports = {
    UserModel: require('./user'),
    PlaceModel: require('./place'),
    PaymentModel: require('./payment')
};
