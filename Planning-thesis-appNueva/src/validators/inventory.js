const Joi = require('joi');

const createInventorySchema = Joi.object({
  body: Joi.object({
    purchaseDate: Joi.date().required(),
    product: Joi.string().required(),
    quantity: Joi.number().integer().positive().required(),
    unitPrice: Joi.number().required(),
  }),
}).unknown(true);

const updateInventorySchema = Joi.object({
  body: Joi.object({
    purchaseDate: Joi.date(),
    product: Joi.string(),
    quantity: Joi.number().integer().positive(),
    unitPrice: Joi.number(),
  }).or('purchaseDate', 'product', 'quantity', 'unitPrice'),
}).unknown(true);

module.exports = {
  createInventorySchema,
  updateInventorySchema,
};
