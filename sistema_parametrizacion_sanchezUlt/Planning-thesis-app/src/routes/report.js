const express = require('express');
const {
  create: createReportType,
  destroy: destroyReportType,
  findAll: findAllReportType,
  update: updateReportType,
} = require('../controllers/reportType');

const {
  create: createReports,
  destroy: destroyReports,
  findAll: findAllReports,
  update: updateReports,
  findById: findReportById,
} = require('../controllers/reports');

const validateRequest = require('../middlewares/validateRequest');
const {
  createUpdateReportTypeSchema,
  createReportSchema,
  updateReportSchema,
  getAllReportSchema,
} = require('../validators/reports');
const validateAuthorizationToken = require('../middlewares/validateAuthorizationToken');
const validatePermission = require('../middlewares/validatePermission');

const reportTypesRouter = express.Router();

reportTypesRouter.get(
  '/',
  validateAuthorizationToken,
  validatePermission(['reports.list']),
  findAllReportType
);

reportTypesRouter.post(
  '/',
  validateAuthorizationToken,
  validatePermission(['reports.create']),
  validateRequest(createUpdateReportTypeSchema),
  createReportType
);

// reportTypesRouter.put(
//   '/:reportTypeId',
//   validateAuthorizationToken,
//   validateRequest(createUpdateReportTypeSchema),
//   updateReportType
// );

reportTypesRouter.delete(
  '/:reportTypeId',
  validateAuthorizationToken,
  destroyReportType
);

// Reports router
const reportsRouter = express.Router();

// for using reportTypes routes
reportsRouter.use('/types', reportTypesRouter);

// Reports
reportsRouter.get(
  '/',
  validateAuthorizationToken,
  validatePermission(['reports.list']),
  validateRequest(getAllReportSchema),
  findAllReports
);

reportsRouter.get(
  '/:reportId',
  validateAuthorizationToken,
  validatePermission(['reports.get']),
  findReportById
);

reportsRouter.post(
  '/',
  validateAuthorizationToken,
  validatePermission(['reports.create']),
  validateRequest(createReportSchema),
  createReports
);

// reportsRouter.put(
//   '/:reportId',
//   validateAuthorizationToken,
//   validateRequest(updateReportSchema),
//   updateReports
// );

reportsRouter.delete('/:reportId', validateAuthorizationToken, destroyReports);

module.exports = reportsRouter;
