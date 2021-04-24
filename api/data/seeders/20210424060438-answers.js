'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    /**
     * Add seed commands here.
     *
     * Example:
     * await queryInterface.bulkInsert('People', [{
     *   name: 'John Doe',
     *   isBetaMember: false
     * }], {});
    */

     return queryInterface.bulkInsert('Answers', [{
      body: 'Watch thenewboston\'s programming tutorials on youtube. You can go to his channel and subsequently search for the programming language(s) you want to learn or you can just browse his channel until you locate tutorial playlists for the programming language(s) you want to learn. However, i\'d recommend you follow the former approach',
      score: 0,
      authorId: 5,
      questionId: 4,
      createdAt: new Date(),
      updatedAt: new Date()
    }], {});
  },

  down: async (queryInterface, Sequelize) => {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */

     return queryInterface.bulkDelete('Answers', null, {});
  }
};
