const Joi = require('joi');

const getAllPlanningSowingSchema = Joi.object({
  query: Joi.object({
    operationalUserId: Joi.number().integer().optional(),
    // startDate: Joi.date().optional(),
    // endDate: Joi.date().optional(),
  }),
}).unknown(true);

const createPlanningSowingSchema = Joi.object({
  body: Joi.object({
    climaticCondition: Joi.string().required(),
    seedName: Joi.string().required(),
    bananaVariety: Joi.string().required(),
    fertilizerQuantityKG: Joi.number().required(),
    pesticideQuantityKG: Joi.number().required(),
    sowingDate: Joi.date().required(),
    fumigationDate: Joi.date(),
    irrigation: Joi.string()
      .valid('Motores/Bombas', 'Electrico/Diesel')
      .required(),

    sowingDateEnd: Joi.date(),
    estimatedSowingTime: Joi.number().integer(),
    numberOfBunches: Joi.number().integer(),
    rejectedBunches: Joi.number().integer(),
    averageBunchWeight: Joi.number(),
    batchNumber: Joi.number().integer(),
    // planningSowing1Id: Joi.number().integer(),
    // operationalUserId: Joi.number().integer().required(),
  }),
}).unknown(true);

const updatePlanningSowingSchema = Joi.object({
  body: Joi.object({
    climaticCondition: Joi.string(),
    seedName: Joi.string(),
    bananaVariety: Joi.string(),
    fertilizerQuantityKG: Joi.number(),
    pesticideQuantityKG: Joi.number(),
    fumigationDate: Joi.date(),
    irrigation: Joi.string().valid('Motores/Bombas', 'Electrico/Diesel'),
    sowingDate: Joi.date(),
    sowingDateEnd: Joi.date(),
    estimatedSowingTime: Joi.number().integer(),
    numberOfBunches: Joi.number().integer(),
    rejectedBunches: Joi.number().integer(),
    averageBunchWeight: Joi.number(),
    batchNumber: Joi.number().integer(),

    // planningSowing1Id: Joi.number().integer(),
    // operationalUserId: Joi.number().integer().required(),
  }).or(
    'climaticCondition',
    'seedName',
    'bananaVariety',
    'fertilizerQuantityKG',
    'pesticideQuantityKG',
    'fumigationDate',
    'irrigation',
    'sowingDate',
    'sowingDateEnd',
    'estimatedSowingTime',
    'numberOfBunches',
    'rejectedBunches',
    'averageBunchWeight',
    'batchNumber'
  ),
}).unknown(true);

module.exports = {
  createPlanningSowingSchema,
  updatePlanningSowingSchema,
  getAllPlanningSowingSchema,
};
