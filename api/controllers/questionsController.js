const QuestionModel = require('../data/models').Question;
const UserModel = require('../data/models').User;
const ModuleModel = require('../data/models').Module;
const CourseModel = require('../data/models').Course;

module.exports = {
    
     listAll(req, res) {

        return QuestionModel
        .findAll(
            { 
                include: [
                    {
                        model: UserModel
                    },
                    {
                        model: ModuleModel
                    }
                ] 
            })
            .then(questionData => res.status(200).send(questionData))
            .catch(error => res.status(400).send(error));
    },

    listFiltered(req, res) {

        console.log(req.query.course)
        console.log(req.query.year)
        console.log(req.query.module)

        return QuestionModel
        .findAll(
            { 
                include: [
                    {
                        model: UserModel
                    },
                    {
                        model: ModuleModel
                        ,include: [ 
                            { 
                                model: CourseModel
                                ,where: { name: req.query.course }
                            }
                        ]
                        ,where: { 
                            year: req.query.year
                            ,code: req.query.module 
                        }
                    }
                ] 
            })
            .then(questionData => res.status(200).send(questionData))
            .catch(error => res.status(400).send(error));
    },

};