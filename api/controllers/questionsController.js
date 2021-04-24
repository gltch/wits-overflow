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

        //
        // Build the filters

        userWhereCondition = {};
        courseWhereCondition = {};
        moduleWhereCondition = {};
        
        if (req.query.course) {
            courseWhereCondition.name = req.query.course;
        }

        if (req.query.user) {
            userWhereCondition.name = req.query.user;
        }

        if (req.query.module) {
            moduleWhereCondition.code = req.query.module;
        }

        if (req.query.year) {
            moduleWhereCondition.year = req.query.year;
        }

        //
        // Return the filtered results

        return QuestionModel
        .findAll(
            { 
                include: [
                    {
                        model: UserModel
                        ,where: userWhereCondition
                    },
                    {
                        model: ModuleModel
                        ,include: [ 
                            { 
                                model: CourseModel
                                ,where: courseWhereCondition
                            }
                        ]
                        ,where: moduleWhereCondition
                    }
                ] 
            })
            .then(questionData => res.status(200).send(questionData))
            .catch(error => res.status(400).send(error));
    },

    createQuestion(req,response) {

        // TODO: Add some validation here.

        QuestionModel.create({

            title: req.body.title,
            body: req.body.body,
            score: req.body.score,
            authorId: req.body.authorId,
            moduleId: req.body.moduleId

        })
        .then(result => response.status(200).send(result))
        .catch(error => response.status(400).send(error));

    },

};