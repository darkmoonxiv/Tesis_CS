module.exports = (sequelize, DataTypes) => {
  const RolePermission = sequelize.define(
    'RolePermission',
    {
      id: {
        field: 'IdRolPermiso',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      roleId: {
        field: 'IdRol',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      permissionId: {
        field: 'IdPermiso',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
    },
    {
      tableName: 'RolesPermisos',
      timestamps: false,
    }
  );

  RolePermission.associate = (models) => {
    RolePermission.belongsTo(models.Role, { foreignKey: 'roleId' });
    RolePermission.belongsTo(models.Permission, {
      foreignKey: 'permissionId',
      as: 'Permission',
    });
  };

  return RolePermission;
};
