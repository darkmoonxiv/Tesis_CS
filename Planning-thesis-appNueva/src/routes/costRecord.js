const express = require('express');

const {
  findAll,
  create,
  update,
  destroy,
  findById,
} = require('../controllers/costRecord');

const validateRequest = require('../middlewares/validateRequest');
const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');
const validatePermission = require('../middlewares/validatePermission');
const {
  findAllCostRecordSchema,
  createCostRecordSchema,
  updateCostRecordSchema,
} = require('../validators/costRecord');

const costRecordRouter = express.Router();

costRecordRouter.get(
  '/',
  validateAuthorizationToken,
  validatePermission(['costs.list']),
  validateRequest(findAllCostRecordSchema),
  findAll
);

costRecordRouter.get(
  '/:costRecordId',
  validateAuthorizationToken,
  validatePermission(['costs.get']),
  findById
);

costRecordRouter.post(
  '/',
  validateAuthorizationToken,
  validatePermission(['costs.record']),
  validateRequest(createCostRecordSchema),
  create
);

costRecordRouter.put(
  '/:costRecordId',
  validateAuthorizationToken,
  validatePermission(['costs.edit']),
  validateRequest(updateCostRecordSchema),
  update
);

costRecordRouter.delete(
  '/:costRecordId',
  validateAuthorizationToken,
  validatePermission(['costs.edit']),
  destroy
);

module.exports = costRecordRouter;
