const questionsController = require('../controllers').questionsController;

module.exports = (app) => {

    app.get('/questions', questionsController.listFiltered);

};