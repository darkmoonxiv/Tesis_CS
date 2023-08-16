module.exports = (sequelize, DataTypes) => {
  const PlanningSowing2 = sequelize.define(
    'PlanningSowing2',
    {
      id: {
        field: 'IdPlanSiembra2',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      sowingDate: {
        field: 'FechaSiembra',
        type: DataTypes.DATE,
      },
      sowingDateEnd: {
        field: 'FechaSiembraFin',
        type: DataTypes.DATE,
      },
      estimatedSowingTime: {
        field: 'TiempoEstimadoSiembra',
        type: DataTypes.INTEGER,
      },
      numberOfBunches: {
        field: 'NumeroRacimos',
        type: DataTypes.INTEGER,
      },
      rejectedBunches: {
        field: 'NumeroRacimosRechazados',
        type: DataTypes.INTEGER,
      },
      averageBunchWeight: {
        field: 'PesoPromedioRacimo',
        type: DataTypes.FLOAT,
      },
      batchNumber: {
        field: 'NumeroLote',
        type: DataTypes.INTEGER,
      },
      planningSowing1Id: {
        field: 'IdPlanSiembra1',
        type: DataTypes.INTEGER,
        // references: {
        //   model: 'PlanificacionSiembra1',
        //   key: 'id',
        // },
      },
    },
    {
      tableName: 'PlanificacionSiembra2',
      timestamps: false,
    }
  );

  PlanningSowing2.associate = (models) => {
    PlanningSowing2.belongsTo(models.PlanningSowing1, {
      foreignKey: 'planningSowing1Id',
      as: 'planningSowing1',
    });
    // Add your other associations here if you have any.
  };

  return PlanningSowing2;
};
