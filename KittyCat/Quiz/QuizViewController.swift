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
    func showErrorView(viewModel: QuizView.GetErrorView.ViewModel)
}

protocol QuestionDelegate {
    func displayNextQuestion(ifCorrect: Bool)
}

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionContainer: UIView!
    @IBOutlet weak var answerCounterLabel: UILabel!
    @IBOutlet weak var correctnessLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
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
        answerCounterLabel.isHidden = true
        correctnessLabel.isHidden = true
        getBreeds()
    }

    func getBreeds() {
        let request = QuizView.GetBreeds.Request()
        interactor?.getBreeds(request: request)
    }
    
    func setQuizLabels() {
        answerCounterLabel.text = "Question \(currentQuestion + 1)/\(questions.count)"
        correctnessLabel.text = "Correctness is \(correctness)/\(questions.count)"
    }

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

    func showErrorView(viewModel: QuizView.GetErrorView.ViewModel) {
        DispatchQueue.main.async {
            let errorView = SomethingWrongView(delegate: self, frame: CGRect(x: self.questionContainer.frame.minX, y: self.questionContainer.bounds.minY, width: self.questionContainer.frame.width, height: self.questionContainer.frame.height))
            for view in self.questionContainer.subviews {
                view.removeFromSuperview()
            }
            self.questionContainer.addSubview(errorView)
            self.answerCounterLabel.isHidden = true
            self.correctnessLabel.isHidden = true
        }
    }
    
    func displayImage(viewModel: QuizView.GetImage.ViewModel) {
        let question = QuestionView(photo: viewModel.imageUrl, question: questions[currentQuestion], delegate: self, frame: CGRect(x: questionContainer.frame.minX, y: questionContainer.bounds.minY, width: questionContainer.frame.width, height: questionContainer.frame.height))
        for view in questionContainer.subviews {
            view.removeFromSuperview()
        }
        questionContainer.addSubview(question)
        answerCounterLabel.isHidden = false
        correctnessLabel.isHidden = false
    }
    
    func resetQuize() {
        currentQuestion = 0
        correctness = 0
        getImage()
        setQuizLabels()
    }
}

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

extension QuizViewController: ErrorViewDelegate {
    
    func tryAgain() {
        getBreeds()
    }
}
