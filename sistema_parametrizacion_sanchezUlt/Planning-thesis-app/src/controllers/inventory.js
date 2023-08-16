const { sendSuccess } = require('../utils/formatResponse');
const logger = require('../utils/logger');

const { Inventory } = require('../models');
const { NotFound } = require('../utils/httpErrors');

const findAll = async (req, res, next) => {
  try {
    const inventory = await Inventory.findAll();

    return res.json(sendSuccess('Inventory retrieved successfully', inventory));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const findById = async (req, res, next) => {
  try {
    const { inventoryId } = req.params;

    const inventory = await Inventory.findOne({ where: { id: inventoryId } });

    if (!inventory) {
      throw new NotFound('Inventory record not found');
    }

    return res.json(sendSuccess('Inventory retrieved successfully', inventory));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const create = async (req, res, next) => {
  try {
    const data = req.body;

    await Inventory.create({
      purchaseDate: data.purchaseDate,
      product: data.product,
      quantity: data.quantity,
      unitPrice: data.unitPrice,
    });

    return res.status(200).json(sendSuccess('Inventory created successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const update = async (req, res, next) => {
  try {
    const { inventoryId } = req.params;
    const { purchaseDate, product, quantity, unitPrice } = req.body;

    await Inventory.update(
      {
        ...(purchaseDate ? { purchaseDate } : {}),
        ...(product ? { product } : {}),
        ...(quantity ? { quantity } : {}),
        ...(unitPrice ? { unitPrice } : {}),
      },
      {
        where: { id: inventoryId },
      }
    );

    return res.status(200).json(sendSuccess('Inventory updated successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const destroy = async (req, res, next) => {
  try {
    const { inventoryId } = req.params;

    await Inventory.destroy({
      where: { id: inventoryId },
    });

    return res.status(200).json(sendSuccess('Inventory deleted successfully'));
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
