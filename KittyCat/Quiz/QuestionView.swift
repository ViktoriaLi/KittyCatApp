//
//  QuestionView.swift
//  KittyCat
//
//  Created by Mac Developer on 18.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet var contentView: UIView!
    
    var question: Question? = nil
    var photo: String? = nil
    var delegate: QuestionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init(photo: String, question: Question, delegate: QuestionDelegate, frame: CGRect) {
        super.init(frame: frame)
        self.question = question
        self.photo = photo
        self.delegate = delegate
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    private func loadFromNib() {
        Bundle.main.loadNibNamed("QuestionView", owner: self, options: nil)
        addSubview(contentView)
        setUiElements()
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setUiElements() {
        option1Button.layer.cornerRadius = 8
        option2Button.layer.cornerRadius = 8
        option3Button.layer.cornerRadius = 8
        option4Button.layer.cornerRadius = 8
        imageView.layer.cornerRadius = 8
        option1Button.setTitle(question?.options[0], for: .normal)
        option2Button.setTitle(question?.options[1], for: .normal)
        option3Button.setTitle(question?.options[2], for: .normal)
        option4Button.setTitle(question?.options[3], for: .normal)
        imageView.loadImage(from: photo)
    }
    
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        print(sender.tag)
        if let currentQuestion = question {
            if sender.tag == currentQuestion.correctAnswer {
                changeButtonColor(color: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), button: sender)
                delegate?.displayNextQuestion(ifCorrect: true)
            } else {
                changeButtonColor(color: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), button: sender)
                delegate?.displayNextQuestion(ifCorrect: false)
            }
        }
    }
    
    private func changeButtonColor(color: CGColor, button: UIButton) {
        UIView.animate(withDuration: 0.5) {
            button.layer.backgroundColor = color
        }
        UIView.animate(withDuration: 0.5) {
            button.layer.backgroundColor = UIColor.white.cgColor
        }
    }
}
