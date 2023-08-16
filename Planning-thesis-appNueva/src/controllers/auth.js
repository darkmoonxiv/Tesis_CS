const { sendSuccess } = require('../utils/formatResponse');
const logger = require('../utils/logger');
const MailService = require('../utils/mailService');

const {
  User,
  UserRole,
  Role,
  RolePermission,
  Permission,
} = require('../models');
const {
  BadRequest,
  Forbidden,
  Unauthorized,
  NotFound,
} = require('../utils/httpErrors');
const { generateToken, verifyToken } = require('../utils/jwt');
const { checkPassword, encryptPassword } = require('../utils/encryption');
const RESET_PASSWORD_TEMPLATE = require('../constants/recoveryEmailTemplate');

const signin = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({
      where: { email },
      include: [
        {
          model: UserRole,
          as: 'UserRoles',
          attributes: ['id'],
          include: [
            {
              model: Role,
              as: 'Role',
              include: [
                {
                  model: RolePermission,
                  as: 'RolePermissions',
                  attributes: ['id'],
                  include: [
                    {
                      model: Permission,
                      as: 'Permission',
                      attributes: ['permissionName', 'description'],
                    },
                  ],
                },
              ],
            },
          ],
        },
      ],
    });

    if (!user) {
      throw new NotFound('User not found');
    }

    if (user.state !== 'activo') {
      throw new Forbidden('Your Account is Currently Inactive');
    }

    const isMatch = await checkPassword(password, user.password);

    if (!isMatch) {
      throw new BadRequest('Invalid credentials');
    }

    const rolesPermissions = user.UserRoles.map((userRole) => ({
      name: userRole.Role.roleName,
      code: userRole.Role.roleCode,
      permissions: userRole.Role.RolePermissions.map(
        (permission) => permission.Permission.permissionName
      ),
    }));

    const payload = {
      user: {
        id: user.id,
        email: user.email,
        roles: rolesPermissions,
      },
    };

    const token = await generateToken(
      process.env.LOGIN_JWT_SECRET,
      payload,
      '1d'
    );

    return res.status(200).json(
      sendSuccess('Successfully logged', {
        user: {
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
        },
        token,
      })
    );
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const resetPasswordRequest = async (req, res, next) => {
  try {
    const { email } = req.body;

    const user = await User.findOne({ where: { email } });

    if (!user) {
      throw new NotFound('User not found');
    }

    if (user.state !== 'activo') {
      throw new Forbidden('Your Account is Currently Inactive');
    }

    const token = await generateToken(
      process.env.RECOVERY_PASSWORD_JWT_SECRET,
      {
        user: {
          id: user.id,
          email,
        },
      },
      '5m'
    );

    await MailService.sendMail({
      to: email,
      subject: 'Restablecer contraseña',
      html: RESET_PASSWORD_TEMPLATE(
        token,
        process.env.WEB_RECOVERY_PASSWORD_URL
      ),
    });

    return res.status(200).json(sendSuccess('Recovery email sent'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

const resetPassword = async (req, res, next) => {
  try {
    const { token } = req.params;
    const { password } = req.body;

    const decoded = await verifyToken(
      process.env.RECOVERY_PASSWORD_JWT_SECRET,
      token
    ).catch((e) => {
      logger.error(e);
      throw new Unauthorized('Token is not valid');
    });

    const user = decoded.user;

    const userRetrieved = await User.findOne({ where: { id: user.id } });

    if (!userRetrieved) {
      throw new NotFound('User not found');
    }

    if (userRetrieved.state !== 'activo') {
      throw new Forbidden('Your Account is Currently Inactive');
    }

    const hashedPassword = await encryptPassword(password);

    await User.update({ password: hashedPassword }, { where: { id: user.id } });

    return res
      .status(200)
      .json(sendSuccess('User password updated successfully'));
  } catch (error) {
    logger.info(error.message);
    return next(error);
  }
};

module.exports = {
  signin,
  resetPasswordRequest,
  resetPassword,
};
