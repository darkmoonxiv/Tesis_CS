const express = require('express');
const {
  findAll,
  create,
  update,
  destroy,
  findById,
} = require('../controllers/inventory');
const validateRequest = require('../middlewares/validateRequest');
const validatePermission = require('../middlewares/validatePermission');
const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');

const {
  createInventorySchema,
  updateInventorySchema,
} = require('../validators/inventory');

const inventoryRouter = express.Router();

inventoryRouter.get(
  '/',
  validateAuthorizationToken,
  validatePermission(['inventory.list']),
  findAll
);

inventoryRouter.get(
  '/:inventoryId',
  validateAuthorizationToken,
  validatePermission(['inventory.get_product']),
  findById
);

inventoryRouter.post(
  '/',
  validateAuthorizationToken,
  validatePermission(['inventory.register']),
  validateRequest(createInventorySchema),
  create
);

inventoryRouter.put(
  '/:inventoryId',
  validateAuthorizationToken,
  validatePermission(['inventory.edit']),
  validateRequest(updateInventorySchema),
  update
);

inventoryRouter.delete(
  '/:inventoryId',
  validateAuthorizationToken,
  validatePermission(['inventory.edit']),
  destroy
);

module.exports = inventoryRouter;
