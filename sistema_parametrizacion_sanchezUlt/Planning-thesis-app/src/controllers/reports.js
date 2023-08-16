const { sendSuccess } = require('../utils/formatResponse');
const logger = require('../utils/logger');
const { Report, ReportType, Sequelize } = require('../models');
const { NotFound, BadRequest } = require('../utils/httpErrors');

const findAll = async (req, res, next) => {
  try {
    const { userId, reportTypeId, startDate, endDate } = req.query;

    const queryCondition = {
      where: {
        ...(userId ? { userId } : {}),
        ...(reportTypeId ? { reportTypeId } : {}),
        ...(startDate || endDate
          ? {
              creationDate: {
                ...(endDate ? { [Sequelize.Op.lte]: new Date(endDate) } : {}),
                ...(startDate
                  ? { [Sequelize.Op.gte]: new Date(startDate) }
                  : {}),
              },
            }
          : {}),
      },
    };

    const report = await Report.findAll(queryCondition);
    return res.json(sendSuccess('Reports retrieved successfully', report));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const findById = async (req, res, next) => {
  try {
    const { reportId } = req.params;

    const report = await Report.findOne({ where: { id: reportId } });

    if (!report) {
      throw new NotFound('Report not found');
    }

    return res.json(sendSuccess('Report retrieved successfully', report));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const create = async (req, res, next) => {
  try {
    const data = req.body;

    const reportTypeExists = await ReportType.findOne({
      where: { id: data.reportTypeId },
    });

    if (!reportTypeExists) {
      throw new BadRequest('ReportType does not exist!');
    }

    await Report.create({
      userId: req.user.id,
      reportTypeId: data.reportTypeId,
      content: data.content,
      creationDate: new Date(),
    });

    return res.status(200).json(sendSuccess('Report created successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const update = async (req, res, next) => {
  try {
    const { reportId } = req.params;

    const { reportTypeId, content } = req.body;

    const reportExists = await Report.findOne({ where: { id: reportId } });

    if (!reportExists) {
      throw new NotFound('Report does not exist!');
    }

    if (reportTypeId) {
      const reportTypeExists = await ReportType.findOne({
        where: { id: reportTypeId },
      });

      if (!reportTypeExists) {
        throw new BadRequest('ReportType does not exist!');
      }
    }

    await Report.update(
      {
        ...(reportTypeId ? { reportTypeId } : {}),
        ...(content ? { content } : {}),
      },
      { where: { id: reportId } }
    );

    return res.status(200).json(sendSuccess('Report updated successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const destroy = async (req, res, next) => {
  try {
    const { reportId } = req.params;

    await Report.destroy({ where: { id: reportId } });

    return res.status(200).json(sendSuccess('Report deleted successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

module.exports = {
  create,
  findAll,
  findById,
  update,
  destroy,
};
