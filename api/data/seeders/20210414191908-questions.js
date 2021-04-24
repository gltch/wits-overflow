'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Questions', [{
      title: 'How do I undo the most recent local commits in Git?',
      body: 'I accidentally committed the wrong files to Git, but didn\'t push the commit to the server yet. How can I undo those commits from the local repository?',
      authorId: 1,
      moduleId: 1,
      score: 0,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      title: 'How do I delete a Git branch locally and remotely?',
      body: 'What should I do differently to successfully delete the remotes/origin/bugfix branch both locally and remotely?',
      authorId: 2,
      moduleId: 2,
      score: 0,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      title: 'How do I exit the Vim editor?',
      body: 'I\'m stuck and cannot escape. It says: "type :quit<Enter> to quit VIM". But when I type that it simply appears in the object body.',
      authorId: 3,
      moduleId: 3,
      score: 0,
      createdAt: new Date(),
      updatedAt: new Date()
    },{
      title: 'Programming languages',
      body: 'Which online resources can I use to learn a programming language?',
      authorId: 4,
      moduleId: 4,
      score: 0,
      createdAt: new Date(),
      updatedAt: new Date()
    }
  ], {});
  },

  down: async (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete('Questions', null, {});
  }
};
