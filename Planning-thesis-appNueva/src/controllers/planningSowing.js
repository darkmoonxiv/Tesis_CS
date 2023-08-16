const { sendSuccess } = require('../utils/formatResponse');
const logger = require('../utils/logger');

const { PlanningSowing1, PlanningSowing2, sequelize } = require('../models');
const { NotFound } = require('../utils/httpErrors');

const findAll = async (req, res, next) => {
  try {
    const { operationalUserId } = req.query;

    const queryCondition = {
      where: { ...(operationalUserId ? { operationalUserId } : {}) },
      include: [{ model: PlanningSowing2, as: 'planningSowing2' }],
    };

    const plannings = await PlanningSowing1.findAll(queryCondition);

    const response = plannings.map((planningSowing) => {
      const { planningSowing2, ...planningSowing1 } = planningSowing.get({
        plain: true,
      });

      return { planningSowing1, planningSowing2 };
    });

    return res.json(sendSuccess('Plannings retrieved successfully', response));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const findById = async (req, res, next) => {
  try {
    const { planningSowingId } = req.params;

    const planningSowing = await PlanningSowing1.findOne({
      where: { id: planningSowingId },
      include: [{ model: PlanningSowing2, as: 'planningSowing2' }],
    });

    if (!planningSowing) {
      throw new NotFound('PlanningSowing1 not found');
    }

    const { planningSowing2, ...planningSowing1 } = planningSowing.get({
      plain: true,
    });

    const response = { planningSowing1, planningSowing2 };

    return res.json(
      sendSuccess('PlanningSowing1 retrieved successfully', response)
    );
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const create = async (req, res, next) => {
  try {
    const data = req.body;
    logger.info(`Body: ${JSON.stringify(data)}`);

    const planningSowing1Keys = [
      'climaticCondition',
      'seedName',
      'bananaVariety',
      'fertilizerQuantityKG',
      'pesticideQuantityKG',
      'fumigationDate',
      'irrigation',
    ];

    const planningSowing2Keys = [
      'sowingDate',
      'sowingDateEnd',
      'estimatedSowingTime',
      'numberOfBunches',
      'rejectedBunches',
      'averageBunchWeight',
      'batchNumber',
    ];

    const planningSowing1Fields = Object.fromEntries(
      Object.entries(data).filter(([key]) => planningSowing1Keys.includes(key))
    );

    const planningSowing2Fields = Object.fromEntries(
      Object.entries(data).filter(([key]) => planningSowing2Keys.includes(key))
    );

    await sequelize.transaction(async (t) => {
      let planningSowing1;

      if (Object.keys(planningSowing1Fields).length > 0) {
        planningSowing1 = await PlanningSowing1.create(
          {
            ...planningSowing1Fields,
            operationalUserId: req.user.id,
            ...(planningSowing1Fields.fumigationDate
              ? {
                  fumigationDate: new Date(
                    planningSowing1Fields.fumigationDate
                  ),
                }
              : {}),
          },
          {
            transaction: t,
          }
        );
      }

      if (Object.keys(planningSowing2Fields).length > 0) {
        await PlanningSowing2.create(
          {
            ...planningSowing2Fields,
            planningSowing1Id: planningSowing1.id,
            ...(planningSowing2Fields.sowingDate
              ? {
                  sowingDate: new Date(planningSowing2Fields.sowingDate),
                }
              : {}),

            ...(planningSowing2Fields.sowingDateEnd
              ? {
                  sowingDateEnd: new Date(planningSowing2Fields.sowingDateEnd),
                }
              : {}),
          },
          { transaction: t }
        );
      }
    });

    return res
      .status(200)
      .json(sendSuccess('Parametrization created successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const update = async (req, res, next) => {
  try {
    const { planningSowingId } = req.params;
    const data = req.body;

    const planning = await PlanningSowing1.findOne({
      where: { id: planningSowingId },
      include: [{ model: PlanningSowing2, as: 'planningSowing2' }],
    });

    if (!planning) {
      throw new NotFound('Planning not found');
    }

    const planningSowing1Keys = [
      'climaticCondition',
      'seedName',
      'bananaVariety',
      'fertilizerQuantityKG',
      'pesticideQuantityKG',
      'fumigationDate',
      'irrigation',
    ];

    const planningSowing2Keys = [
      'sowingDate',
      'sowingDateEnd',
      'estimatedSowingTime',
      'numberOfBunches',
      'rejectedBunches',
      'averageBunchWeight',
      'batchNumber',
    ];

    const planningSowing1Fields = Object.fromEntries(
      Object.entries(data).filter(([key]) => planningSowing1Keys.includes(key))
    );

    const planningSowing2Fields = Object.fromEntries(
      Object.entries(data).filter(([key]) => planningSowing2Keys.includes(key))
    );

    await sequelize.transaction(async (t) => {
      if (Object.keys(planningSowing1Fields).length > 0) {
        await PlanningSowing1.update(
          {
            ...planningSowing1Fields,
            ...(planningSowing1Fields.fumigationDate
              ? {
                  fumigationDate: new Date(
                    planningSowing1Fields.fumigationDate
                  ),
                }
              : {}),
          },
          {
            transaction: t,
            where: { id: planning.id },
          }
        );
      }

      if (Object.keys(planningSowing2Fields).length > 0) {
        await PlanningSowing2.update(
          {
            ...planningSowing2Fields,
            ...(planningSowing2Fields.sowingDate
              ? { sowingDate: new Date(planningSowing2Fields.sowingDate) }
              : {}),
            ...(planningSowing2Fields.sowingDateEnd
              ? { sowingDateEnd: new Date(planningSowing2Fields.sowingDateEnd) }
              : {}),
          },
          {
            where: { id: planning.planningSowing2.id },
            transaction: t,
          }
        );
      }
    });

    return res
      .status(200)
      .json(sendSuccess('Parametrization updated successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const destroy = async (req, res, next) => {
  try {
    const { planningSowingId } = req.params;

    const planning = await PlanningSowing1.findOne({
      where: { id: planningSowingId },
      include: [{ model: PlanningSowing2, as: 'planningSowing2' }],
    });

    await sequelize.transaction(async (t) => {
      await PlanningSowing2.destroy({
        where: { id: planning.planningSowing2.id },
        transaction: t,
      });
      await PlanningSowing1.destroy({
        where: { id: planning.id },
        transaction: t,
      });
    });

    return res
      .status(200)
      .json(sendSuccess('PlanningSowing1 deleted successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

module.exports = {
  create,
  update,
  findAll,
  findById,
  destroy,
};
