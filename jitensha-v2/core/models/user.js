/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const crypto   = require('crypto');
const mongoose = require('mongoose');
const validate = require('mongoose-validate');

const UserSchema = new mongoose.Schema({
    email: { type: String, unique: true, required: true, validate: [ validate.email ] },
    hashedPass: { type: String, required: true },
    salt: { type: String, required: true }
}, 
{ 
    timestamps: true 
});

UserSchema.methods.encryptPassword = function (password) {
	return crypto.createHmac('sha1', this.salt)
	             .update(password)
	             .digest('hex');
};

UserSchema.methods.checkPassword = function (password) {
	return this.hashedPass === this.encryptPassword(password);
};

UserSchema.virtual('password')
          .set(function (password) {
              this._password = password;
              this.salt = crypto.randomBytes(32).toString('hex');
              this.hashedPass = this.encryptPassword(password);
		  })
		  .get(function () {
              return this._password;
		  });

UserSchema.statics.create = function(body) {
    const UserModel = mongoose.model('User');
    const user = new UserModel({ 
        email: body.email, 
        password: body.password
    });
    return user;
};

module.exports = mongoose.model('User', UserSchema);
