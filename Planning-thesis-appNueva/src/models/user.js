module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define(
    'User',
    {
      id: {
        field: 'IdUser',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      firstName: {
        field: 'NombreUser',
        type: DataTypes.STRING,
        allowNull: false,
      },
      lastName: {
        field: 'ApellidoUser',
        type: DataTypes.STRING,
        allowNull: false,
      },
      email: {
        field: 'CorreoElectronico',
        type: DataTypes.STRING,
        allowNull: false,
      },
      password: {
        field: 'Contrasena',
        type: DataTypes.STRING,
        allowNull: false,
      },
      state: {
        field: 'Estado',
        type: DataTypes.ENUM('activo', 'inactivo'),
      },
    },
    {
      tableName: 'Usuarios',
      timestamps: false,
    }
  );

  User.associate = (models) => {
    User.hasMany(models.PlanningSowing1, { foreignKey: 'operationalUserId' });
    User.hasMany(models.Report, { foreignKey: 'userId' });

    User.hasMany(models.UserRole, { foreignKey: 'userId', as: 'UserRoles' });
  };

  return User;
};
