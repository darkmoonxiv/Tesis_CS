const { sendSuccess } = require('../utils/formatResponse');
const logger = require('../utils/logger');

const { User, Role, UserRole, Sequelize, sequelize } = require('../models');
const { encryptPassword } = require('../utils/encryption');
const { BadRequest, NotFound } = require('../utils/httpErrors');

const findAll = async (req, res, next) => {
  try {
    const requestorUserId = req.user.id;

    const users = await User.findAll({
      where: { id: { [Sequelize.Op.ne]: requestorUserId } },
      include: [
        {
          model: UserRole,
          as: 'UserRoles',
          attributes: ['id'],
          include: [{ model: Role, as: 'Role' }],
        },
      ],
      attributes: { exclude: ['password'] },
    });

    const userData = users.map((user) => {
      const { UserRoles, ...userData } = user.get({ plain: true });
      const roles = UserRoles.map((userRole) => userRole.Role);

      return {
        ...userData,
        roles,
      };
    });

    return res.json(sendSuccess('Users retrieved successfully', userData));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const findOne = async (req, res, next) => {
  try {
    const requestorUserId = req.user.id;
    const { userId } = req.params;

    const user = await User.findOne({
      where: {
        id: {
          [Sequelize.Op.ne]: requestorUserId,
          [Sequelize.Op.eq]: userId,
        },
      },
      include: [
        {
          model: UserRole,
          as: 'UserRoles',
          attributes: ['id'],
          include: [{ model: Role, as: 'Role' }],
        },
      ],
      attributes: { exclude: ['password'] },
    });

    if (!user) {
      throw new NotFound('User not found');
    }

    const { UserRoles, ...userData } = user.get({ plain: true });
    const roles = UserRoles.map((userRole) => userRole.Role);

    return res.json(
      sendSuccess('User retrieved successfully', { ...userData, roles })
    );
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const create = async (req, res, next) => {
  const t = await sequelize.transaction();

  try {
    const { firstName, lastName, email, password, state, roles } = req.body;

    const userWithEmailExists = await User.findOne({ where: { email } });

    if (userWithEmailExists) {
      throw new BadRequest(`User with email already exists`);
    }

    const retrievedRoles = await Role.findAll({ where: { id: roles } });

    if (roles.length !== retrievedRoles.length) {
      throw new BadRequest('One or more roles are invalid.');
    }

    const hashedPassword = await encryptPassword(password);

    const newUser = await User.create(
      {
        firstName,
        lastName,
        email,
        password: hashedPassword,
        state,
      },
      { transaction: t }
    );

    const userRolesCreation = roles.map(async (role) => {
      await UserRole.create(
        { roleId: role, userId: newUser.id },
        { transaction: t }
      );
    });

    await Promise.all(userRolesCreation);

    await t.commit();

    return res.status(200).json(sendSuccess('User created successfully'));
  } catch (error) {
    await t.rollback();
    logger.info(error.message);
    return next(error);
  }
};

const update = async (req, res, next) => {
  const t = await sequelize.transaction();

  try {
    const requestorUserId = req.user.id;
    const { userId } = req.params;

    let { firstName, lastName, email, password, state, roles } = req.body;

    const user = await User.findOne({
      where: {
        id: {
          [Sequelize.Op.ne]: requestorUserId,
          [Sequelize.Op.eq]: userId,
        },
      },
      include: [{ model: UserRole, as: 'UserRoles' }],
    });

    if (!user) {
      throw new NotFound('User not found');
    }

    if (email) {
      const userWithEmailExists = await User.findOne({ where: { email } });

      if (userWithEmailExists) {
        throw new BadRequest(`User with email already exists`);
      }
    }

    if (roles) {
      const retrievedRoles = await Role.findAll({ where: { id: roles } });

      if (roles.length !== retrievedRoles.length) {
        throw new BadRequest('One or more roles are invalid.');
      }
    }

    if (password) {
      password = await encryptPassword(password);
    }

    const dataToUpdate = {
      ...(email ? { email } : {}),
      ...(password ? { password } : {}),
      ...(firstName ? { firstName } : {}),
      ...(lastName ? { lastName } : {}),
      ...(state ? { state } : {}),
    };

    if (Object.keys(dataToUpdate).length > 0) {
      await User.update(dataToUpdate, {
        where: { id: userId },
        transaction: t,
      });
    }

    if (roles) {
      const userRoles = user.UserRoles.map((userRole) => userRole.roleId);

      const rolesIdsToDelete = userRoles.filter(
        (userRole) => !roles.includes(userRole)
      );

      const rolesIdsToCreate = roles.filter(
        (role) => !userRoles.includes(role)
      );

      if (rolesIdsToDelete.length > 0) {
        const deleteUsersRoles = rolesIdsToDelete.map(
          async (userRoleToDelete) => {
            const userRole = user.UserRoles.find(
              (userRole) => userRole.roleId === userRoleToDelete
            );

            await UserRole.destroy({
              where: { id: userRole.id },
              transaction: t,
            });
          }
        );
        await Promise.all(deleteUsersRoles);
      }

      if (rolesIdsToCreate.length > 0) {
        const createUsersRoles = rolesIdsToCreate.map(
          async (userRoleToCreate) => {
            await UserRole.create(
              {
                userId: user.id,
                roleId: userRoleToCreate,
              },
              { transaction: t }
            );
          }
        );
        await Promise.all(createUsersRoles);
      }
    }

    await t.commit();

    return res.status(200).json(sendSuccess('User updated successfully'));
  } catch (error) {
    await t.rollback();
    logger.info(error.message);
    return next(error);
  }
};

const destroy = async (req, res, next) => {
  const t = await sequelize.transaction();

  try {
    const { userId } = req.params;
    const requestorUserId = req.user.id;

    const user = await User.findOne({
      where: {
        id: {
          [Sequelize.Op.ne]: requestorUserId,
          [Sequelize.Op.eq]: userId,
        },
      },
      include: [{ model: UserRole, as: 'UserRoles' }],
    });

    if (!user) {
      throw new NotFound('User not found');
    }

    if (user.UserRoles.length > 0) {
      const deleteUsersRoles = user.UserRoles.map(async (userRole) => {
        await UserRole.destroy({
          where: { id: userRole.id },
          transaction: t,
        });
      });

      await Promise.all(deleteUsersRoles);
    }

    await User.destroy({ where: { id: userId }, transaction: t });

    await t.commit();

    return res.status(200).json(sendSuccess('User deleted successfully'));
  } catch (error) {
    await t.rollback();
    logger.info(error.message);
    return next(error);
  }
};

const getProfile = async (req, res, next) => {
  try {
    const requestorUserId = req.user.id;

    const user = await User.findOne({
      where: { id: requestorUserId },
      include: [
        {
          model: UserRole,
          as: 'UserRoles',
          attributes: ['id'],
          include: [{ model: Role, as: 'Role' }],
        },
      ],
      attributes: { exclude: ['password'] },
    });

    if (!user) {
      throw new NotFound('User not found');
    }

    const { UserRoles, ...userData } = user.get({ plain: true });
    const roles = UserRoles.map((userRole) => userRole.Role);

    return res.json(
      sendSuccess('Profile retrieved successfully', { ...userData, roles })
    );
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const updateProfile = async (req, res, next) => {
  const t = await sequelize.transaction();

  try {
    const requestorUserId = req.user.id;

    let { password } = req.body;

    if (email) {
      const userWithEmailExists = await User.findOne({ where: { email } });

      if (userWithEmailExists) {
        throw new BadRequest(`User with email already exists`);
      }
    }

    if (password) {
      password = await encryptPassword(password);
    }

    const dataToUpdate = { ...(password ? { password } : {}) };

    if (Object.keys(dataToUpdate).length > 0) {
      await User.update(dataToUpdate, {
        where: { id: requestorUserId },
        transaction: t,
      });
    }

    await t.commit();

    return res
      .status(200)
      .json(sendSuccess('User profile updated successfully'));
  } catch (error) {
    await t.rollback();
    logger.info(error.message);
    return next(error);
  }
};

module.exports = {
  findAll,
  create,
  update,
  destroy,
  findOne,
  getProfile,
  updateProfile,
};
