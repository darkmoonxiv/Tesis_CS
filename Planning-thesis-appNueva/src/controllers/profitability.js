const { sendSuccess } = require('../utils/formatResponse');
const logger = require('../utils/logger');

const { Profitability, PlanningSowing2, CostRecord } = require('../models');
const { BadRequest } = require('../utils/httpErrors');

const findAll = async (req, res, next) => {
  try {
    const queryCondition = {
      include: [
        { model: PlanningSowing2, as: 'planningSowing2' },
        { model: CostRecord, as: 'costRecord' },
      ],
    };

    const profitability = await Profitability.findAll(queryCondition);

    return res.json(
      sendSuccess('Profitability retrieved successfully', profitability)
    );
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const create = async (req, res, next) => {
  try {
    const data = req.body;

    const planningSowing2 = await PlanningSowing2.findOne({
      where: { id: data.planningSowing2Id },
    });

    if (!planningSowing2) {
      throw new BadRequest('Planning sowing not exist');
    }

    const costRecord = await CostRecord.findOne({
      where: { id: data.costRecordId },
    });

    if (!costRecord) {
      throw new BadRequest('Cost record not exist');
    }

    await Profitability.create({
      planningSowing2Id: data.planningSowing2Id,
      costRecordId: data.costRecordId,
    });

    return res
      .status(200)
      .json(sendSuccess('Profitability created successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const destroy = async (req, res, next) => {
  try {
    const { profitabilityId } = req.params;

    await Profitability.destroy({ where: { id: profitabilityId } });

    return res
      .status(200)
      .json(sendSuccess('Profitability deleted successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

module.exports = {
  create,
  findAll,
  destroy,
};
