const { Unauthorized } = require('../utils/httpErrors');
const { verifyToken } = require('../utils/jwt');

const logger = require('../utils/logger');

const validateAuthorizationToken = async (req, res, next) => {
  try {
    const authHeader = req.header('Authorization');

    if (!authHeader) {
      throw new Unauthorized('No token, authorization denied');
    }

    const token = authHeader.split(' ')[1]; // Bearer <token>

    if (!token) {
      throw new Unauthorized('Malformed token, authorization denied');
    }

    const decoded = await verifyToken(
      process.env.LOGIN_JWT_SECRET,
      token
    ).catch((e) => {
      logger.error(e);
      throw new Unauthorized('Token is not valid');
    });

    req.user = decoded.user;
    return next();
  } catch (error) {
    logger.error(error);
    return next(error);
  }
};

module.exports = validateAuthorizationToken;
