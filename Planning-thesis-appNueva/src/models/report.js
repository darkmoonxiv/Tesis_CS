module.exports = (sequelize, DataTypes) => {
  const Report = sequelize.define(
    'Report',
    {
      id: {
        field: 'IdReportes',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      userId: {
        field: 'IdUsuarios',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      reportTypeId: {
        field: 'IdTipoReporte',
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      content: {
        field: 'Contenido',
        type: DataTypes.STRING(200),
        allowNull: false,
      },
      creationDate: {
        field: 'FechaCreacion',
        type: DataTypes.DATE,
        allowNull: false,
      },
    },
    {
      tableName: 'Reportes',
      timestamps: false,
    }
  );

  Report.associate = (models) => {
    Report.belongsTo(models.User, { foreignKey: 'userId' });
    Report.belongsTo(models.ReportType, { foreignKey: 'reportTypeId' });
  };

  return Report;
};
