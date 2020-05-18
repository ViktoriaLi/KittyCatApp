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
        option1Button.setTitle(question?.options[0], for: .normal)
        option2Button.setTitle(question?.options[1], for: .normal)
        option3Button.setTitle(question?.options[2], for: .normal)
        option4Button.setTitle(question?.options[3], for: .normal)
        imageView.loadImage(from: photo)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        print(sender.tag)
        if let currentQuestion = question {
            if sender.tag == currentQuestion.correctAnswer {
                UIView.animate(withDuration: 0.5) {
                    sender.layer.backgroundColor =  UIColor.green.cgColor
                }
                UIView.animate(withDuration: 0.5) {
                    sender.layer.backgroundColor =  UIColor.white.cgColor
                }
                delegate?.displayNextQuestion(ifCorrect: true)
            } else {
                UIView.animate(withDuration: 0.5) {
                    sender.layer.backgroundColor =  UIColor.red.cgColor
                }
                UIView.animate(withDuration: 0.5) {
                    sender.layer.backgroundColor =  UIColor.white.cgColor
                }
                delegate?.displayNextQuestion(ifCorrect: false)
            }
        }
        
    }
}
