const morgan = require('morgan');
const logger = require('./logger');

const morganFormat =
  ':method :url :status :res[content-length] - :response-time ms - HTTP/:http-version :referrer :user-agent - :remote-addr - :remote-user';

// Create stream for morgan to interface with Winston
const morganStream = {
  write: (message) => {
    logger.info(message);
  },
};

// Export the middleware
module.exports = morgan(morganFormat, { stream: morganStream });
