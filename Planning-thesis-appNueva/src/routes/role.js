const express = require('express');
const {
  findAll,
  getRolePermissions,
  update,
  // create,
  // destroy,
} = require('../controllers/role');
const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');

const validateRole = require('../middlewares/validateRole');
const validatePermission = require('../middlewares/validatePermission');

const validateRequest = require('../middlewares/validateRequest');
const { updateRoleSchema } = require('../validators/role');
const { ROLE_CODES } = require('../constants/constants');

const roleRouter = express.Router();

roleRouter.get(
  '/',
  validateAuthorizationToken,
  // validateRole([ROLE_CODES.ADMIN]),
  validatePermission(['roles.list']),
  findAll
);

roleRouter.get(
  '/:roleId/permissions',
  validateAuthorizationToken,
  // validateRole([ROLE_CODES.ADMIN]),
  validatePermission(['roles.get_permissions']),
  getRolePermissions
);

roleRouter.put(
  '/:roleId',
  validateAuthorizationToken,
  // validateRole([ROLE_CODES.ADMIN]),
  validatePermission(['roles.set_permissions']),
  validateRequest(updateRoleSchema),
  update
);

// roleRouter.post('/', validateRequest(createRoleSchema), create);
// roleRouter.delete('/:roleId', destroy);

module.exports = roleRouter;
