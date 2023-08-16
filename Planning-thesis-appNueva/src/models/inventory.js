module.exports = (sequelize, DataTypes) => {
  const Inventory = sequelize.define(
    'Inventory',
    {
      id: {
        field: 'IdInventario',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      purchaseDate: {
        field: 'FechaCompra',
        type: DataTypes.DATE,
        allowNull: false,
      },
      product: {
        field: 'Producto',
        type: DataTypes.STRING,
        allowNull: false,
      },
      quantity: {
        field: 'Cantidad',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      unitPrice: {
        field: 'PrecioUnitario',
        type: DataTypes.FLOAT,
        allowNull: false,
      },
    },
    {
      tableName: 'Inventario',
      timestamps: false,
    }
  );

  Inventory.associate = (models) => {
    Inventory.hasMany(models.CostRecord, { foreignKey: 'inventoryId' });
  };

  return Inventory;
};
