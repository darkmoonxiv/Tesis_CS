const Joi = require('joi');

const createUserSchema = Joi.object({
  body: Joi.object({
    firstName: Joi.string().required(),
    lastName: Joi.string().required(),
    email: Joi.string().email().required(),
    password: Joi.string().min(3).required(),
    state: Joi.string().valid('activo', 'inactivo'),
    roles: Joi.array().items(Joi.number()).min(1).required(),
  }),
}).unknown(true);

const updateUserSchema = Joi.object({
  body: Joi.object({
    firstName: Joi.string(),
    lastName: Joi.string(),
    email: Joi.string().email(),
    password: Joi.string().min(3),
    state: Joi.string().valid('activo', 'inactivo'),
    roles: Joi.array().items(Joi.number()).min(1),
  }).or('firstName', 'lastName', 'email', 'password', 'state', 'roles'),
}).unknown(true);

const updateProfileSchema = Joi.object({
  body: Joi.object({
    // firstName: Joi.string(),
    // lastName: Joi.string(),
    password: Joi.string().min(3),
  }).or('firstName', 'lastName', 'password'),
}).unknown(true);

module.exports = {
  createUserSchema,
  updateUserSchema,
  updateProfileSchema,
};
