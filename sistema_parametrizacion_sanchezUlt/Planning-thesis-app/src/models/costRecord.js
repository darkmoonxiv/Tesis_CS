module.exports = (sequelize, DataTypes) => {
  const CostRecord = sequelize.define(
    'CostRecord',
    {
      id: {
        field: 'IdCostos',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      registerDate: {
        field: 'FechaRegistro',
        type: DataTypes.DATE,
        allowNull: false,
      },
      description: {
        field: 'Descripcion',
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      input: {
        field: 'Insumo',
        type: DataTypes.FLOAT,
        allowNull: false,
      },
      labor: {
        field: 'ManoObra',
        type: DataTypes.FLOAT,
        allowNull: false,
      },
      fuel: {
        field: 'Combustible',
        type: DataTypes.FLOAT,
        allowNull: false,
      },
      totalCosts: {
        field: 'Total',
        type: DataTypes.FLOAT,
        allowNull: false,
      },
      inventoryId: {
        field: 'IdInventario',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      operationalUserId: {
        field: 'IdUsuarioOperativo',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
    },
    {
      tableName: 'RegistroCostos',
      timestamps: false,
    }
  );

  CostRecord.associate = (models) => {
    CostRecord.belongsTo(models.Inventory, { foreignKey: 'inventoryId' });

    CostRecord.belongsTo(models.User, { foreignKey: 'operationalUserId' });
    // CostRecord.belongsTo(models.PlanningSowing, {
    //   foreignKey: 'planningSowingId',
    // });
  };

  return CostRecord;
};
