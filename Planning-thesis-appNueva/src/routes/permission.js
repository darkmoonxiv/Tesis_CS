const express = require('express');
const { findAll } = require('../controllers/permission');
const { ROLE_CODES } = require('../constants/constants');
const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');
const validateRole = require('../middlewares/validateRole');
const validatePermission = require('../middlewares/validatePermission');

const roleRouter = express.Router();

roleRouter.get(
  '/',
  validateAuthorizationToken,
  validatePermission(['permissions.list']),
  // validateRole([ROLE_CODES.ADMIN]),
  findAll
);

module.exports = roleRouter;
