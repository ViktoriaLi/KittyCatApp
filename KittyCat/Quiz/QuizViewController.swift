//
//  SecondViewController.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

protocol QuizViewDisplayLogic: class {
    func fillQuestions(viewModel: QuizView.GetBreeds.ViewModel)
    func displayImage(viewModel: QuizView.GetImage.ViewModel)
}

protocol QuestionDelegate {
    func displayNextQuestion(ifCorrect: Bool)
    
}

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionContainer: QuestionView!
    @IBOutlet weak var answerCounterLabel: UILabel!
    @IBOutlet weak var correctnessLabel: UILabel!
    
    var currentQuestion = 0
    var correctness = 0
    
    var questions = [Question]()
    
    var interactor: QuizBusinessLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = QuizViewInteractor()
        let presenter = QuizViewPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBreeds()
        
    }

    func getBreeds() {
        let request = QuizView.GetBreeds.Request()
        interactor?.getBreeds(request: request)
    }
    
    func setQuizLabels() {
        answerCounterLabel.text = "\(currentQuestion + 1)/\(questions.count)"
        correctnessLabel.text = "\(correctness)/\(questions.count)"
    }
    /*func loadViewWithQuestion() {
        let question = QuestionView(question: questions[currentQuestion], frame: CGRect(x: questionContainer.frame.minX, y: questionContainer.frame.minY, width: questionContainer.frame.width, height: questionContainer.frame.height))
        for view in questionContainer.subviews {
            view.removeFromSuperview()
        }
        questionContainer.addSubview(question)
    }*/
    
    func getImage() {
        if currentQuestion < questions.count {
            let request = QuizView.GetImage.Request(breedId: questions[currentQuestion].breedId)
            interactor?.getImageUrl(request: request)
        }
    }
}

extension QuizViewController: QuizViewDisplayLogic {
    
    func fillQuestions(viewModel: QuizView.GetBreeds.ViewModel) {
        questions = viewModel.questions
        setQuizLabels()
        getImage()
    }

    func displayImage(viewModel: QuizView.GetImage.ViewModel) {
        let question = QuestionView(photo: viewModel.imageUrl, question: questions[currentQuestion], delegate: self, frame: CGRect(x: questionContainer.frame.minX, y: questionContainer.frame.minY, width: questionContainer.frame.width, height: questionContainer.frame.height))
        for view in questionContainer.subviews {
            view.removeFromSuperview()
        }
        questionContainer.addSubview(question)
        //questionContainer.imageView.loadImage(from: viewModel.imageUrl)
        //loadViewWithQuestion()
        //тут может быть несоответствие картинки и вопросу изза несинхронной загрухки
    }
    
    func resetQuize() {
        currentQuestion = 0
        correctness = 0
        getImage()
        setQuizLabels()
    }
}

//сделать окно результата и и сброс квиза

extension QuizViewController: QuestionDelegate {
    func displayNextQuestion(ifCorrect: Bool) {
        currentQuestion += 1
        if ifCorrect == true {
            correctness += 1
        }
        if currentQuestion == questions.count {
            let alert = UIAlertController(title: "You finished quiz with \(correctness) correct answers. Good job!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { (UIAlertAction)
                in
                self.resetQuize()
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            getImage()
            setQuizLabels()
        }
    }
}

