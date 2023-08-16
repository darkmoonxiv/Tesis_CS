/* eslint-disable */
const jwt = require('jsonwebtoken');

const generateToken = (privateKey, payload, expiresIn) => {
  return new Promise((resolve, reject) => {
    jwt.sign(payload, privateKey, { expiresIn }, (error, token) => {
      if (error) {
        reject(error);
      } else {
        resolve(token);
      }
    });
  });
};

const verifyToken = (privateKey, token) => {
  return new Promise((resolve, reject) => {
    jwt.verify(token, privateKey, (error, decodedToken) => {
      if (error) {
        reject(error);
      } else {
        resolve(decodedToken);
      }
    });
  });
};

module.exports = {
  generateToken,
  verifyToken,
};
