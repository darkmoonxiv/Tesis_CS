const { sendSuccess } = require('../utils/formatResponse');
const logger = require('../utils/logger');

const { Permission } = require('../models');

const findAll = async (req, res, next) => {
  try {
    const permissions = await Permission.findAll();
    return res.json(
      sendSuccess('Permission retrieved successfully', permissions)
    );
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

module.exports = {
  findAll,
};
