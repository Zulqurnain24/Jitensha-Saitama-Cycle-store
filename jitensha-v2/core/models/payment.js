/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const crypto     = require('crypto');
const config     = require('../../config/config');
const mongoose   = require('mongoose');
const CreditCard = require('creditcard');
const validate   = require('mongoose-validate');
const algorithm  = config.get('algorithm');

const CreditCardSchema = new mongoose.Schema({
    number: { type: String, required: true },
    name: { type: String, required: true },
    cvv: { type: String, required: true },
    expiryMonth: { type: String, required: true },
    expiryYear: { type: String, required: true }
});

const PaymentSchema = new mongoose.Schema({
    creditCard: { type: CreditCardSchema, required: true },
    email: { type: String, required: true, validate:[ validate.email ] },
    placeId: { type: String, required: true },
    salt: { type: String }
}, 
{ 
    timestamps: true 
});

PaymentSchema.statics.create = function(email, body) {
    const PaymentModel = mongoose.model('Payment');
    const payment = new PaymentModel({
        creditCard: { 
            number: body.number,
            name: body.name,
            cvv: body.cvv,
            expiryMonth: body.expiryMonth,
            expiryYear: body.expiryYear
        },
        email: email,
        placeId: body.placeId
    });
    return payment;
};

PaymentSchema.methods.encrypt = function (text) {
    const cipher = crypto.createCipher(algorithm, this.salt);
    const value = cipher.update(text, 'utf8', 'hex'); 
    return value + cipher.final('hex');
};
	 
PaymentSchema.methods.decrypt = function (text) {
    const decipher = crypto.createDecipher(algorithm, this.salt);
    const value = decipher.update(text, 'hex', 'utf8');
    return value + decipher.final('utf8');
}

PaymentSchema.methods.encryptCreditCard = function () {
	this.creditCard.number = this.encrypt(this.creditCard.number);
	this.creditCard.name = this.encrypt(this.creditCard.name);
	this.creditCard.cvv = this.encrypt(this.creditCard.cvv);
	this.creditCard.expiryMonth = this.encrypt(this.creditCard.expiryMonth);
	this.creditCard.expiryYear = this.encrypt(this.creditCard.expiryYear);	
}

PaymentSchema.methods.decryptCreditCard = function () {
	this.creditCard.number = this.decrypt(this.creditCard.number);
	this.creditCard.name = this.decrypt(this.creditCard.name);
	this.creditCard.cvv = this.decrypt(this.creditCard.cvv);
	this.creditCard.expiryMonth = this.decrypt(this.creditCard.expiryMonth);
	this.creditCard.expiryYear = this.decrypt(this.creditCard.expiryYear);
}

PaymentSchema.methods.isCreditCardValid = function () {
    return CreditCard.validate(this.creditCard.number) &&
           CreditCard.expiry(this.creditCard.expiryMonth, this.creditCard.expiryYear);
}

PaymentSchema.pre('save', function (next) {
	this.salt = crypto.randomBytes(32).toString('hex');
	this.encryptCreditCard();
    next();
});

PaymentSchema.post('find', function (docs) {
    for (const doc of docs) {
        doc.decryptCreditCard();
	}
});

module.exports = mongoose.model('Payment', PaymentSchema);
