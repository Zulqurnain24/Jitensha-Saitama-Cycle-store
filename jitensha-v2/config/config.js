/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const nconf = require('nconf');

nconf.argv()
     .env()
     .file({ file: './config/config.json' });

module.exports = nconf;