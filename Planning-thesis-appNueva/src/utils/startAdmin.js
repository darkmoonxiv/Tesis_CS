require('dotenv').config();

const { encryptPassword } = require('../utils/encryption');
const { User, Role, UserRole, sequelize } = require('../models');
const { ROLE_CODES } = require('../constants/constants');

const logger = require('../utils/logger');

async function createAdminUser() {
  try {
    const adminEmail = process.env.ADMIN_EMAIL;
    const adminPassword = process.env.ADMIN_PASSWORD;

    const adminRole = await Role.findOne({
      where: { roleCode: ROLE_CODES.ADMIN },
    });

    if (!adminRole) {
      throw new Error('Cannot find Role Administrador');
    }

    const adminUser = await User.findOne({ where: { email: adminEmail } });

    if (!adminUser) {
      const hashedPassword = await encryptPassword(adminPassword);

      await sequelize.transaction(async (t) => {
        // Create user
        const newAdminUser = await User.create(
          {
            firstName: process.env.ADMIN_FIRSTNAME,
            lastName: process.env.ADMIN_LASTNAME,
            email: adminEmail,
            password: hashedPassword,
            state: 'activo',
          },
          { transaction: t }
        );

        await UserRole.create(
          {
            roleId: adminRole.id,
            userId: newAdminUser.id,
          },
          { transaction: t }
        );
      });
    }
  } catch (error) {
    logger.error('Error creating user:', error);
    logger.info('Retrying in 5 seconds...');
    await delay(5000); // Delay for 5 seconds

    // Call the function again to retry
    await createAdminUser();
  }
}

const delay = (ms) => {
  return new Promise((resolve) => setTimeout(resolve, ms));
};

module.exports = { createAdminUser };
