/*
 * Copyright (c) 2017, Crossover and/or its affiliates. All rights reserved.
 * CROSSOVER PROPRIETARY/CONFIDENTIAL.
 *
 *     https://www.crossover.com/
 */
'use strict';

const fs             = require('fs');
const Koa            = require('koa');
const http           = require('http');
const https          = require('https');
const morgan         = require('koa-morgan');
const config         = require('./config/config');
const Router         = require('koa-router')({ prefix: '/api/v2.0' });
const logger         = require('winston');
const bodyParser     = require('koa-bodyparser');
const error          = require('./core/middlewares/error');
const ApiCodes       = require('./api-codes');
const HttpStatus     = require('http-status-codes');
const UserRouter     = require('./core/routes').UserRouter;
const PlaceRouter    = require('./core/routes').PlaceRouter;
const PaymentRouter  = require('./core/routes').PaymentRouter;
const ModelValidator = require('./core/middlewares/model-validator');

const app = Koa();

Router.get('/', function *() { 
	yield this.body = {
        service: 'じてんしゃ - Saitama Rent a bike v2.0'
    }
});

app.use(morgan.middleware('dev', {}));
app.use(error(HttpStatus.NOT_FOUND, ApiCodes.RESOURCE_NOT_FOUND));
app.use(bodyParser({ onerror: (err, ctx) => ctx.throw('body parse error', HttpStatus.UNPROCESSABLE_ENTITY) }));
app.use(error(HttpStatus.UNAUTHORIZED, ApiCodes.UNAUTHORIZED));
app.use(error(HttpStatus.METHOD_NOT_ALLOWED, ApiCodes.METHOD_NOT_ALLOWED));
app.use(error(HttpStatus.UNPROCESSABLE_ENTITY, ApiCodes.INVALID_ENTITY));
app.use(error(HttpStatus.INTERNAL_SERVER_ERROR, ApiCodes.SERVER_ERROR));
app.use(ModelValidator());
app.use(Router.routes());
app.use(Router.allowedMethods());
app.use(UserRouter.routes());
app.use(UserRouter.allowedMethods());
app.use(PlaceRouter.routes());
app.use(PlaceRouter.allowedMethods());
app.use(PaymentRouter.routes());
app.use(PaymentRouter.allowedMethods());

process.on('uncaughtException', (err) => {
    logger.error('uncaughtException::' + err);
    process.exit(1);
});

const nodeEnv = process.env.NODE_ENV;

if ((nodeEnv !== undefined) && (nodeEnv.trim() === 'dev')) {
	const server = http.createServer(app.callback());
	const port = process.env.PORT || config.get('dev-port');
	server.listen(config.get('dev-port'), () => logger.info('http server ' + port));
} else {
    const options = {
        key: fs.readFileSync(config.get('https:key')),
        cert: fs.readFileSync(config.get('https:cert'))
    };
    const port = process.env.PORT || config.get('port');
    https.createServer(options, app.callback())
         .listen(port, () => logger.info('https server ' + port));	
}