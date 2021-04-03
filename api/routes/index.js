const testDataController = require('../controllers').testData;

module.exports = (app) => {

    app.get('/data', testDataController.list);

};