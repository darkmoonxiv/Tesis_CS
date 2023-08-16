module.exports = (sequelize, DataTypes) => {
  const PlanningSowing1 = sequelize.define(
    'PlanningSowing1',
    {
      id: {
        field: 'IdPlanSiembra1',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      climaticCondition: {
        field: 'CondicionClimatica',
        type: DataTypes.STRING,
        allowNull: false,
      },
      seedName: {
        field: 'NombreSemillas',
        type: DataTypes.STRING,
        allowNull: false,
      },
      bananaVariety: {
        field: 'VariedadBanano',
        type: DataTypes.STRING,
        allowNull: false,
      },
      fertilizerQuantityKG: {
        field: 'CantidadFertilizanteKG',
        type: DataTypes.FLOAT,
        allowNull: false,
      },
      pesticideQuantityKG: {
        field: 'CantidadPesticidasKG',
        type: DataTypes.FLOAT,
        allowNull: false,
      },
      fumigationDate: {
        field: 'FechaFumigacionArea',
        type: DataTypes.DATE,
      },
      irrigation: {
        field: 'Riego',
        type: DataTypes.ENUM('riego1', 'riego2'),
        allowNull: false,
      },
      operationalUserId: {
        field: 'IdUsuarioOperativo',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
    },
    {
      tableName: 'PlanificacionSiembra1',
      timestamps: false,
    }
  );

  PlanningSowing1.associate = (models) => {
    PlanningSowing1.belongsTo(models.User, { foreignKey: 'operationalUserId' });
    PlanningSowing1.hasOne(models.PlanningSowing2, {
      foreignKey: 'planningSowing1Id',
      as: 'planningSowing2',
    });

    // PlanningSowing1.hasMany(models.CostRecord, {
    //   foreignKey: 'planningSowing1Id',
    // });
  };

  return PlanningSowing1;
};
