require('dotenv').config();

const express = require('express');
const helmet = require('helmet');
const cors = require('cors');

const logger = require('./utils/logger');
const morganMiddleware = require('./utils/morgan');
const router = require('./routes');
const { HttpError } = require('./utils/httpErrors');
const { sendError } = require('./utils/formatResponse');
const { createAdminUser } = require('./utils/startAdmin');

const app = express();

app.use(helmet());

app.use(cors());

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

if (process.env.NODE_ENV !== 'production') {
  app.use(morganMiddleware);
}

app.use('/v1', router);

app.use((err, req, res, next) => {
  logger.error(err);

  if (err instanceof HttpError) {
    return res
      .status(err.code)
      .json(sendError(err.code, err.message, err?.errors));
  }

  return res.status(500).json(sendError(500, 'Something went wrong'));
});

const PORT = process.env.APP_PORT;

// Start the server and create the user on startup
const startServer = async () => {
  app.listen(PORT, () => {
    logger.info(`Server is running on port ${PORT}`);
  });
  await createAdminUser();
};

startServer();
