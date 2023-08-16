module.exports.sendSuccess = (message, data) => ({
  status: 'success',
  message,
  data,
});

const formatErrors = (errors) => {
  let errorsValidationFormatted;

  if (errors && Array.isArray(errors)) {
    errorsValidationFormatted = errors.map((err) => ({
      field: err.field,
      message: err.message,
    }));
  }
  return errorsValidationFormatted;
};

module.exports.sendError = (statusCode, message, errors) => ({
  status: statusCode >= 500 ? 'error' : 'fail',
  code: statusCode,
  message,
  errors: formatErrors(errors),
});
