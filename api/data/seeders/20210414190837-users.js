'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Users', [{
      name: 'Anton Stott',
      email: '1759765@students.wits.ac.za',
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      name: 'Cameron Cafferty',
      email: '2115870@students.wits.ac.za',
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      name: 'Mbusiso Siso',
      email: '2126210@students.wits.ac.za',
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      name: 'Motsoaledi Matlala',
      email: '1497069@students.wits.ac.za',
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      name: 'Mulalo Moditambi',
      email: '1828618@students.wits.ac.za',
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      name: 'Thabiso Kobe',
      email: '1862081@students.wits.ac.za',
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      name: 'Vukosi Moyane',
      email: '2138802@students.wits.ac.za',
      createdAt: new Date(),
      updatedAt: new Date()
    }], {});
  },

  down: async (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete('Users', null, {});
  }
};
