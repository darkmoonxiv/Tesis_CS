const { Forbidden } = require('../utils/httpErrors');
const logger = require('../utils/logger');

function validateRole(roles) {
  return function (req, res, next) {
    try {
      const userRoles = req.user.roles.map((role) => role.code);

      if (roles.some((role) => userRoles.includes(role))) {
        return next();
      } else {
        throw new Forbidden(
          'You do not have the necessary role to perform this operation'
        );
      }
    } catch (error) {
      logger.error(error);
      return next(error);
    }
  };
}

module.exports = validateRole;
