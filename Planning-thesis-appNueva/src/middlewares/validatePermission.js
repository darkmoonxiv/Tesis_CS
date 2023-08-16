const { Forbidden } = require('../utils/httpErrors');
const logger = require('../utils/logger');

function validatePermission(permissions) {
  return function (req, res, next) {
    try {
      const userPermissions = req.user.roles.reduce(
        (prev, role) => [...prev, ...role.permissions],
        []
      );

      if (
        permissions.some((permission) => userPermissions.includes(permission))
      ) {
        return next();
      } else {
        throw new Forbidden(
          'You do not have the necessary permissions to perform this operation'
        );
      }
    } catch (error) {
      logger.error(error);
      return next(error);
    }
  };
}

module.exports = validatePermission;
