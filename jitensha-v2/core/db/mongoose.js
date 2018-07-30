/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const config   = require('../../config/config');
const logger   = require('winston');
const mongoose = require('mongoose');

mongoose.Promise = require('bluebird'); 
mongoose.connect(config.get('database:uri'));

mongoose.connection.on('error', (err) => logger.error(err.message));
mongoose.connection.once('open', () => logger.info('mongo connection opened'));

module.exports = mongoose;
