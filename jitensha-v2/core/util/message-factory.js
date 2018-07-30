/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const ApiCodes = require('../../api-codes');

const MessageFactory = {
    message: (apiCode, detail = undefined) => {
        return {
            message: ApiCodes.getCodeDesc(apiCode),
            detail: detail,
            code: apiCode        	
        }
    }
};

module.exports = MessageFactory;
