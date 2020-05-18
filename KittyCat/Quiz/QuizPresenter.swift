//
//  QuizPresenter.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol QuizViewPresentationLogic {
    func processingError(response: QuizView.GetErrorView.Response)
    func processingBreeds(response: QuizView.GetBreeds.Response)
    func processingImage(response: QuizView.GetImage.Response)
}

final class QuizViewPresenter: QuizViewPresentationLogic {
    
    weak var viewController: QuizViewDisplayLogic?
    
    func processingError(response: QuizView.GetErrorView.Response) {
        switch response.error {
            
        case ApiResponse.noNetwork:
            let viewModel = QuizView.GetErrorView.ViewModel(error: "Network error")
        case .success:
            break
        default:
            let viewModel = QuizView.GetErrorView.ViewModel(error: "Something wrong")
        }
    }
    
    func processingBreeds(response: QuizView.GetBreeds.Response) {

        var questions = [Question]()
        for breed in response.breeds {
            var options: [String] = Array(repeating: "", count: 4)
            let correctAnswerIndex = Int.random(in: 0..<4)
            options[correctAnswerIndex] = breed.name
            for (i, option) in options.enumerated() where option == "" {
                var newOption = response.breeds[Int.random(in: 0..<response.breeds.count)].name
                while options.contains(newOption) {
                    newOption = response.breeds[Int.random(in: 0..<response.breeds.count)].name
                }
                options[i] = newOption
            }
            let newQusetion = Question(breedId: breed.id, breedName: breed.name, options: options, correctAnswer: correctAnswerIndex)
            questions.append(newQusetion)
        }
        print("questions")
        print(questions)
        let viewModel = QuizView.GetBreeds.ViewModel(questions: questions)
        viewController?.fillQuestions(viewModel: viewModel)
    }
    
    func processingImage(response: QuizView.GetImage.Response) {

        let viewModel = QuizView.GetImage.ViewModel(imageUrl: response.imageUrl)
        viewController?.displayImage(viewModel: viewModel)
    }
    
}
