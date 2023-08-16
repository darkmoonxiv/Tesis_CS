module.exports = (sequelize, DataTypes) => {
  const UserRole = sequelize.define(
    'UserRole',
    {
      id: {
        field: 'IdUserRol',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      userId: {
        field: 'IdUser',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      roleId: {
        field: 'IdRol',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
    },
    {
      tableName: 'UsuariosRoles',
      timestamps: false,
    }
  );

  UserRole.associate = (models) => {
    UserRole.belongsTo(models.User, { foreignKey: 'userId' });
    UserRole.belongsTo(models.Role, { foreignKey: 'roleId', as: 'Role' });
  };

  return UserRole;
};
