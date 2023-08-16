const Joi = require('joi');

const createRoleSchema = Joi.object({
  body: Joi.object({
    roleName: Joi.string().max(45).required(),
    roleCode: Joi.string().max(45).required(),
    permissions: Joi.array().items(Joi.number()).min(1).required(),
  }),
}).unknown(true);

const updateRoleSchema = Joi.object({
  body: Joi.object({
    // roleName: Joi.string().max(45),
    // roleCode: Joi.string().max(45),
    permissions: Joi.array().items(Joi.number()).min(1),
  }).or('roleName', 'roleCode', 'permissions'),
}).unknown(true);

module.exports = {
  createRoleSchema,
  updateRoleSchema,
};
