const logger = require('../utils/logger');

module.exports = {
  development: {
    username: 'root',
    password: '',
    database: 'PlaneacionSiembra',
    host: '127.0.0.1',
    port: 3307,
    dialect: 'mysql',
    dialectOptions: {
      bigNumberStrings: true,
    },
    logging: (msg) => {
      logger.debug(msg);
    },
  },
  production: {
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    dialect: 'mysql',
    dialectOptions: {
      bigNumberStrings: true,
    },
    logging: (msg) => {
      logger.debug(msg);
    },
  },
};
