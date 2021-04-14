'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Courses', [{
      name: 'Computer Science',
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      name: 'Computational and Applied Mathematics',
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      name: 'Mathematics',
      createdAt: new Date(),
      updatedAt: new Date()
    }], {});
  },

  down: async (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete('Courses', null, {});
  }
};
