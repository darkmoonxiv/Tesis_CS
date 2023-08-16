const express = require('express');

// Routes
const authRouter = require('./auth');
const planningSowingRouter = require('./planningSowing');
const rolesRouter = require('./role');
const permissionsRouter = require('./permission');
const usersRouter = require('./user');
const profitabilityRouter = require('./profitability');
const inventoryRouter = require('./inventory');
const reportsRouter = require('./report');
const costRecordsRouter = require('./costRecord');

const router = express.Router();

router.use('/auth', authRouter);
router.use('/planning-sowing', planningSowingRouter);
router.use('/roles', rolesRouter);
router.use('/permissions', permissionsRouter);
router.use('/users', usersRouter);
router.use('/profitability', profitabilityRouter);
router.use('/inventory', inventoryRouter);
router.use('/reports', reportsRouter);
router.use('/cost-records', costRecordsRouter);

module.exports = router;
