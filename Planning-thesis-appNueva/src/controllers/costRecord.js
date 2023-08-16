const { sendSuccess } = require('../utils/formatResponse');
const logger = require('../utils/logger');

const {
  CostRecord,
  Inventory,
  PlanningSowing,
  Sequelize,
} = require('../models');

const { NotFound, BadRequest } = require('../utils/httpErrors');

const findAll = async (req, res, next) => {
  try {
    const { inventoryId, operationalUserId, startDate, endDate } = req.query;

    const queryCondition = {
      where: {
        ...(inventoryId ? { inventoryId } : {}),
        ...(operationalUserId ? { operationalUserId } : {}),
        ...(startDate || endDate
          ? {
              registerDate: {
                ...(endDate ? { [Sequelize.Op.lte]: new Date(endDate) } : {}),
                ...(startDate
                  ? { [Sequelize.Op.gte]: new Date(startDate) }
                  : {}),
              },
            }
          : {}),
      },
    };

    const costRecords = await CostRecord.findAll(queryCondition);
    return res.json(
      sendSuccess('Cost records retrieved successfully', costRecords)
    );
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const findById = async (req, res, next) => {
  try {
    const { costRecordId } = req.params;

    const costRecord = await CostRecord.findOne({
      where: { id: costRecordId },
    });

    if (!costRecord) {
      throw new NotFound('Cost record not found');
    }

    return res.json(
      sendSuccess('Cost record retrieved successfully', costRecord)
    );
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const create = async (req, res, next) => {
  try {
    const data = req.body;

    const inventoryExists = await Inventory.findOne({
      where: { id: data.inventoryId },
    });

    if (!inventoryExists) {
      throw new BadRequest('Inventory does not exist!');
    }

    await CostRecord.create({
      registerDate: new Date(),
      description: data.description,
      input: data.input,
      labor: data.labor,
      fuel: data.fuel,
      totalCosts: data.totalCosts,
      inventoryId: data.inventoryId,
      operationalUserId: req.user.id,
    });

    return res
      .status(200)
      .json(sendSuccess('Cost record created successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const update = async (req, res, next) => {
  try {
    const { costRecordId } = req.params;

    const { description, input, labor, fuel, totalCosts, inventoryId } =
      req.body;

    const costRecord = await CostRecord.findOne({
      where: { id: costRecordId },
    });

    if (!costRecord) {
      throw new NotFound('Cost record not found');
    }

    if (inventoryId) {
      const inventoryExists = await Inventory.findOne({
        where: { id: inventoryId },
      });

      if (!inventoryExists) {
        throw new BadRequest('Inventory does not exist!');
      }
    }

    await CostRecord.update(
      {
        ...(description ? { description } : {}),
        ...(input ? { input } : {}),
        ...(labor ? { labor } : {}),
        ...(fuel ? { fuel } : {}),
        ...(totalCosts ? { totalCosts } : {}),
        ...(inventoryId ? { inventoryId } : {}),
      },
      { where: { id: costRecordId } }
    );

    return res.status(200).json(sendSuccess('CostRecord updated successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const destroy = async (req, res, next) => {
  try {
    const { costRecordId } = req.params;

    await CostRecord.destroy({ where: { id: costRecordId } });

    return res
      .status(200)
      .json(sendSuccess('Cost record deleted successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

module.exports = {
  findAll,
  findById,
  create,
  update,
  destroy,
};
