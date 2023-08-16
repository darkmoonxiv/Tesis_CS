module.exports = (sequelize, DataTypes) => {
  const ReportType = sequelize.define(
    'ReportType',
    {
      id: {
        field: 'IdTipoReporte',
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      reportName: {
        field: 'NombreReporte',
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      tableName: 'TipoReporte',
      timestamps: false,
    }
  );

  ReportType.associate = (models) => {
    ReportType.hasMany(models.Report, { foreignKey: 'reportTypeId' });
  };

  return ReportType;
};
