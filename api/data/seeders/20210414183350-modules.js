'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Modules', [{
      code: 'COMS1015',
      name: 'Basic Computer Organisation I',
      year: 1,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS1016',
      name: 'Discrete Computational Structures I',
      year: 1,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS1017',
      name: 'Introduction to Data Structures and Algorithms I',
      year: 1,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS1018',
      name: 'Introduction to Algorithms and Programming I',
      year: 1,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH1036',
      name: 'Calculus I',
      year: 1,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH1034',
      name: 'Algebra I',
      year: 1,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'APPM1006',
      name: 'Computational and Applied Mathematics I',
      year: 1,
      courseId: 2,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'APPM2007',
      name: 'Computational and Applied Mathematics II',
      year: 2,
      courseId: 2,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'STAT2012',
      name: 'Introduction to Mathematical Statistics II',
      year: 2,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH2001',
      name: 'Basic Analysis II',
      year: 2,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH2007',
      name: 'Multivariable Calculus II',
      year: 2,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH2015',
      name: 'Abstract Mathematics II',
      year: 2,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH2019',
      name: 'Linear Algebra II',
      year: 2,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH2025',
      name: 'Transition to Abstract Mathematics',
      year: 2,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS2002',
      name: 'Database Fundamentals II',
      year: 2,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS2013',
      name: 'Mobile Computing II',
      year: 2,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS2014',
      name: 'Computer Networks II',
      year: 2,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS2015',
      name: 'Analysis of Algorithms II',
      year: 2,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS3003',
      name: 'Formal Languages and Automata III',
      year: 3,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS3005',
      name: 'Analysis of Advanced Algorithms III',
      year: 3,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS3006',
      name: 'Computer Graphics and Visualization III',
      year: 3,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS3007',
      name: 'Machine Learning III',
      year: 3,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS3008',
      name: 'Parallel Computing III',
      year: 3,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS3009',
      name: 'Software Design III',
      year: 3,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS3010',
      name: 'Operating Systems and System Programming III',
      year: 3,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'COMS3011',
      name: 'Software Design Project III',
      year: 3,
      courseId: 1,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'APPM3017',
      name: 'Computational and Applied Mathematics III',
      year: 3,
      courseId: 2,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH30001',
      name: 'Number Theory III',
      year: 3,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH3003',
      name: 'Coding and Cryptography III',
      year: 3,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH3004',
      name: 'Complex Analysis III',
      year: 3,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH3006',
      name: 'Group Theory III',
      year: 3,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH3010',
      name: 'Topology III',
      year: 3,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH3031',
      name: 'Differential Geometry III',
      year: 3,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH3032',
      name: 'Real Analysis III',
      year: 3,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH3034',
      name: 'Leontief Systems III',
      year: 3,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      code: 'MATH3037',
      name: 'Intermediate Analysis III',
      year: 3,
      courseId: 3,
      createdAt: new Date(),
      updatedAt: new Date()
    }], {});
  },

  down: async (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete('Modules', null, {});
  }
};
