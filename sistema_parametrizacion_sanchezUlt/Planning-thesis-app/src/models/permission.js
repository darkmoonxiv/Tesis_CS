module.exports = (sequelize, DataTypes) => {
  const Permission = sequelize.define(
    'Permission',
    {
      id: {
        field: 'IdPermisos',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      permissionName: {
        field: 'NombrePermisos',
        type: DataTypes.STRING,
        allowNull: false,
      },
      description: {
        field: 'Descripcion',
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      tableName: 'Permisos',
      timestamps: false,
    }
  );

  Permission.associate = (models) => {
    Permission.hasMany(models.RolePermission, { foreignKey: 'permissionId' });
  };

  return Permission;
};
