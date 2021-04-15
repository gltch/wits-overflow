'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Question extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {

      Question.belongsTo(models.User, {
        foreignKey: 'authorId',
        onDelete: 'CASCADE'
      });

      Question.belongsTo(models.Module, {
        foreignKey: 'moduleId',
        onDelete: 'CASCADE'
      });


    }
  };
  Question.init({
    title: DataTypes.STRING,
    body: DataTypes.STRING,
    score: DataTypes.INTEGER,
    authorId: DataTypes.INTEGER,
    moduleId: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Question',
  });
  return Question;
};