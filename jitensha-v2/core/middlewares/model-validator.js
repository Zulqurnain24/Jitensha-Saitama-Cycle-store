/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const mongoose = require('mongoose');

module.exports = () => {
    const ModelValidator = () => {
        return {
            validate: function *validate(model) {
                try {
                    yield model.validate();
                    return null;
                } catch (err) {
                	const errors = []
            		for (const e in err.errors) {
            			errors.push(err.errors[e].message);
            		}
            		return errors;
                }
            }
        }
    };
    return function *(next) {
    	this.ModelValidator = ModelValidator.bind(this)();
    	yield next;
    };
}