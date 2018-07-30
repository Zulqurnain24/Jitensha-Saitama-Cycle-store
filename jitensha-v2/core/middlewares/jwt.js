/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const koaJwt = require('koa-jwt');
const config = require('../../config/config');

module.exports = koaJwt({ secret: config.get('secret') });
