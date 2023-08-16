module.exports = (sequelize, DataTypes) => {
  const Profitability = sequelize.define(
    'Profitability',
    {
      id: {
        field: 'IdRentabilidad',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      planningSowing2Id: {
        field: 'IdPlanSiembra2',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      costRecordId: {
        field: 'IdRegistroCostos',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
    },
    {
      tableName: 'Rentabilidad',
      timestamps: false,
    }
  );

  Profitability.associate = (models) => {
    Profitability.belongsTo(models.PlanningSowing2, {
      foreignKey: 'planningSowing2Id',
      as: 'planningSowing2',
    });
    Profitability.belongsTo(models.CostRecord, {
      foreignKey: 'costRecordId',
      as: 'costRecord',
    });
  };

  return Profitability;
};
