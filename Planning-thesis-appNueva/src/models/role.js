module.exports = (sequelize, DataTypes) => {
  const Role = sequelize.define(
    'Role',
    {
      id: {
        field: 'IdRol',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      roleName: {
        field: 'NombreRol',
        type: DataTypes.STRING,
        allowNull: false,
      },
      roleCode: {
        field: 'codeRol',
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      tableName: 'Roles',
      timestamps: false,
    }
  );

  Role.associate = (models) => {
    // Role.hasMany(models.UserRole, {foreignKey: 'roleId'});
    Role.hasMany(models.RolePermission, {
      foreignKey: 'roleId',
      as: 'RolePermissions',
    });
  };

  return Role;
};
