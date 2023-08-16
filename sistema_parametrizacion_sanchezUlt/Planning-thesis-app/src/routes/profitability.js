const express = require('express');
const { findAll, create, destroy } = require('../controllers/profitability');
const validateRequestMiddleware = require('../middlewares/validateRequest');
const { createProfitabilitySchema } = require('../validators/profitability');
const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');
const validatePermission = require('../middlewares/validatePermission');

const profitabilityRouter = express.Router();

profitabilityRouter.get(
  '/',
  validateAuthorizationToken,
  validatePermission(['profitability.list']),
  findAll
);

profitabilityRouter.delete(
  '/:profitabilityId',
  validateAuthorizationToken,
  destroy
);

profitabilityRouter.post(
  '/',
  validateAuthorizationToken,
  validatePermission(['profitability.calculate']),
  validateRequestMiddleware(createProfitabilitySchema),
  create
);

module.exports = profitabilityRouter;
