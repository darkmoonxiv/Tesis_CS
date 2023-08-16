const Joi = require('joi');

const getAllReportSchema = Joi.object({
  query: Joi.object({
    userId: Joi.number().integer().optional(),
    reportTypeId: Joi.number().integer().optional(),
    startDate: Joi.date().optional(),
    endDate: Joi.date().optional(),
  }),
}).unknown(true);

const createReportSchema = Joi.object({
  body: Joi.object({
    reportTypeId: Joi.number().integer().required(),
    content: Joi.string().max(200).required(),
  }),
}).unknown(true);

const updateReportSchema = Joi.object({
  body: Joi.object({
    reportTypeId: Joi.number().integer(),
    content: Joi.string().max(200),
  }).or('reportTypeId', 'content'),
}).unknown(true);

const createUpdateReportTypeSchema = Joi.object({
  body: Joi.object({
    reportName: Joi.string().max(45).required(),
  }),
}).unknown(true);

module.exports = {
  getAllReportSchema,
  createReportSchema,
  createUpdateReportTypeSchema,
  updateReportSchema,
};
