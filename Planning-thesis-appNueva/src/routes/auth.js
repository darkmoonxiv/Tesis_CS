const express = require('express');
const {
  signin,
  resetPasswordRequest,
  resetPassword,
} = require('../controllers/auth');
const validateRequest = require('../middlewares/validateRequest');
const {
  signinSchema,
  resetPasswordRequestSchema,
  resetPasswordSchema,
} = require('../validators/auth');

const authRouter = express.Router();

authRouter.post('/signin', validateRequest(signinSchema), signin);

authRouter.post(
  '/reset-password',
  validateRequest(resetPasswordRequestSchema),
  resetPasswordRequest
);

authRouter.put(
  '/reset-password/:token',
  validateRequest(resetPasswordSchema),
  resetPassword
);

module.exports = authRouter;
