'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Module extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      
      Module.belongsTo(models.Course, {
        foreignKey: 'courseId',
        onDelete: 'CASCADE'
      });

      Module.hasMany(models.Question, {
        foreignKey: 'moduleId',
      });

    }
  };
  Module.init({
    code: DataTypes.STRING,
    name: DataTypes.STRING,
    year: DataTypes.SMALLINT,
    courseId: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Module',
  });
  return Module;
};