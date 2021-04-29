const questionsController = require('../controllers').questionsController;

module.exports = (app) => {

    /*

    ---------------
    GET: /questions
    ---------------

    Returns a list of filtered questions, including the module, course
    and user information for each question.

    Accepts query string parameters:

    - course
    - module
    - year
    - user

    Examples:

    - /questions?year=1&module=COMS1016
    - /questions?user=John%20Smith&course=Computer%20Science

    */

    app.get('/questions', questionsController.listFiltered);

    // TODO: Add some comment here like above.
    app.post('/questions', questionsController.createQuestion);
};