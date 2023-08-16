/* eslint-disable max-classes-per-file */
class HttpError extends Error {
  constructor(code, message) {
    super(message);
    this.code = code;
  }
}

class BadRequest extends HttpError {
  constructor(message, errors) {
    super(400, message);
    this.errors = errors;
  }
}

class Unauthorized extends HttpError {
  constructor(message) {
    super(401, message);
  }
}

class Forbidden extends HttpError {
  constructor(message) {
    super(403, message);
  }
}

class NotFound extends HttpError {
  constructor(message) {
    super(404, message);
  }
}

class UnprocessableContent extends HttpError {
  constructor(message) {
    super(422, message);
  }
}

class InternalServerError extends HttpError {
  constructor(message) {
    super(500, message);
  }
}

module.exports = {
  BadRequest,
  Forbidden,
  NotFound,
  Unauthorized,
  UnprocessableContent,
  InternalServerError,
  HttpError,
};
