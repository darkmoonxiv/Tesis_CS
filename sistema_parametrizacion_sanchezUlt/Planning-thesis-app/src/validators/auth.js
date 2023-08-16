const Joi = require('joi');

const signinSchema = Joi.object({
  body: Joi.object({
    email: Joi.string().email().min(3).max(75).required(),
    password: Joi.string().min(3).max(45).required(),
  }),
}).unknown(true);

const resetPasswordRequestSchema = Joi.object({
  body: Joi.object({
    email: Joi.string().email().min(3).max(75).required(),
  }),
}).unknown(true);

const resetPasswordSchema = Joi.object({
  body: Joi.object({
    password: Joi.string().min(3).max(75).required(),
  }),
  params: Joi.object({
    token: Joi.string().required(),
  }),
}).unknown(true);

module.exports = {
  signinSchema,
  resetPasswordRequestSchema,
  resetPasswordSchema,
};
