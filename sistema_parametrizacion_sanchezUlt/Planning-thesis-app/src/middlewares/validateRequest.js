/* eslint-disable */

const { BadRequest } = require('../utils/httpErrors');

const validateRequestMiddleware = (schema) => {
  return (req, res, next) => {
    const toValidate = {
      body: req.body,
      headers: req.headers,
      query: req.query,
      params: req.params,
    };

    const { error } = schema.validate(toValidate, { abortEarly: false });

    if (error) {
      const { details } = error;

      const errors = details.map((detail) => ({
        field: detail.path[detail.path.length - 1],
        message: detail.message,
      }));

      throw new BadRequest('Validation errors', errors);
    }

    return next();
  };
};

module.exports = validateRequestMiddleware;
