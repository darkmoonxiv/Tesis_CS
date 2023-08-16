const express = require('express');
const {
  findAll,
  create,
  update,
  destroy,
  findOne,
  getProfile,
  updateProfile,
} = require('../controllers/user');

const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');
const validateRequest = require('../middlewares/validateRequest');
const validateRole = require('../middlewares/validateRole');
const validatePermission = require('../middlewares/validatePermission');

const {
  createUserSchema,
  updateUserSchema,
  updateProfileSchema,
} = require('../validators/user');
const { ROLE_CODES } = require('../constants/constants');

const userRouter = express.Router();

userRouter.get('/me', validateAuthorizationToken, getProfile);

// userRouter.put(
//   '/me',
//   validateAuthorizationToken,
//   validateRequest(updateProfileSchema),
//   updateProfile
// );

userRouter.get(
  '/',
  validateAuthorizationToken,
  // validateRole([ROLE_CODES.ADMIN]),
  validatePermission(['user.list']),
  findAll
);

userRouter.get(
  '/:userId',
  validateAuthorizationToken,
  // validateRole([ROLE_CODES.ADMIN]),
  validatePermission(['user.get']),
  findOne
);

userRouter.post(
  '/',
  validateAuthorizationToken,
  // validateRole([ROLE_CODES.ADMIN]),
  validatePermission(['user.create']),
  validateRequest(createUserSchema),
  create
);

userRouter.put(
  '/:userId',
  validateAuthorizationToken,
  // validateRole([ROLE_CODES.ADMIN]),
  validatePermission(['user.edit']),
  validateRequest(updateUserSchema),
  update
);

userRouter.delete(
  '/:userId',
  validateAuthorizationToken,
  validatePermission(['user.delete']),
  // validateRole([ROLE_CODES.ADMIN]),
  destroy
);

module.exports = userRouter;
