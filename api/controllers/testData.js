const TestDataModel = require('../data/models').TestData;

module.exports = {
    list(req, res) {
        return TestDataModel
            .findAll()
            .then(testData => res.status(200).send(testData))
            .catch(error => res.status(400).send(error));
        }
};