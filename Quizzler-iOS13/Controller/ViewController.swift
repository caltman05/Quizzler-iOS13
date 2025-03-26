//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

// Added an Animation for when the answer is selected that fades in and out
// Also added sounds that play when the user selects a correct or incorrect answer.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var trueButton: UIButton!
    
    @IBOutlet weak var falseButton: UIButton!
    
    
    var quizBrain = QuizBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateUI()
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        
        //animate the button color change based on if the user got it right
        UIView.animate(withDuration: 0.5) {
            sender.backgroundColor = userGotItRight ? UIColor.green : UIColor.red
        }
        
        //set a timer so that the UI is not updated before the animation finishes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.quizBrain.nextQuestion()
            self.updateUI()
            
        //change it back
            UIView.animate(withDuration: 0.3) {
                sender.backgroundColor = UIColor.clear
            }
        }
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        
        
        
    }
    
    
}

