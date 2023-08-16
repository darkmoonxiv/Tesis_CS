const { sendSuccess } = require('../utils/formatResponse');
const logger = require('../utils/logger');
const { ReportType } = require('../models');
const { NotFound } = require('../utils/httpErrors');

const findAll = async (req, res, next) => {
  try {
    const reportType = await ReportType.findAll();

    return res.json(
      sendSuccess('ReportTypes retrieved successfully', reportType)
    );
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const create = async (req, res, next) => {
  try {
    const data = req.body;
    await ReportType.create({ reportName: data.reportName });
    return res.status(200).json(sendSuccess('ReportType created successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const update = async (req, res, next) => {
  try {
    const { reportTypeId } = req.params;
    const { reportName } = req.body;

    const reportTypeExists = await ReportType.findOne({
      where: {
        id: reportTypeId,
      },
    });

    if (!reportTypeExists) {
      throw new NotFound('ReportType not found');
    }

    await ReportType.update(
      { ...(reportName ? { reportName } : {}) },
      { where: { id: reportTypeId } }
    );

    return res.status(200).json(sendSuccess('ReportType updated successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const destroy = async (req, res, next) => {
  try {
    const { reportTypeId } = req.params;

    await ReportType.destroy({ where: { id: reportTypeId } });

    return res.status(200).json(sendSuccess('ReportType deleted successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

module.exports = {
  create,
  findAll,
  update,
  destroy,
};
