const express = require('express');
const {
  findAll,
  create,
  update,
  findById,
  destroy,
} = require('../controllers/planningSowing');
const validateRequest = require('../middlewares/validateRequest');
const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');
const validatePermission = require('../middlewares/validatePermission');

const {
  createPlanningSowingSchema,
  updatePlanningSowingSchema,
  getAllPlanningSowingSchema,
} = require('../validators/planningSowing');

const planningSowingRouter = express.Router();

planningSowingRouter.get(
  '/',
  validateAuthorizationToken,
  validatePermission(['seeding.list']),
  validateRequest(getAllPlanningSowingSchema),
  findAll
);

planningSowingRouter.get(
  '/:planningSowingId',
  validateAuthorizationToken,
  validatePermission(['seeding.get']),
  findById
);

planningSowingRouter.post(
  '/',
  validateAuthorizationToken,
  validatePermission(['seeding.plan']),
  validateRequest(createPlanningSowingSchema),
  create
);

planningSowingRouter.put(
  '/:planningSowingId',
  validateAuthorizationToken,
  validatePermission(['seeding.edit']),
  validateRequest(updatePlanningSowingSchema),
  update
);

planningSowingRouter.delete(
  '/:planningSowingId',
  validateAuthorizationToken,
  validatePermission(['seeding.edit']),
  destroy
);

module.exports = planningSowingRouter;
