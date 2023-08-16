const Joi = require('joi');

const createProfitabilitySchema = Joi.object({
  body: Joi.object({
    costRecordId: Joi.number().integer().positive().required(),
    planningSowing2Id: Joi.number().integer().positive().required(),
  }),
}).unknown(true);

module.exports = {
  createProfitabilitySchema,
};
