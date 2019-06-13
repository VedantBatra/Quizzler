//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let allQuestions = questionBank() //creation of the object of class question bank
    var answerPicked : Bool = false  //tells us the answer picked by us
    var questionNumber : Int = 0
    var score : Int = 0
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            answerPicked = true
        }
        if sender.tag == 2 {
            answerPicked = false
        }
        
        checkAnswer()
        questionNumber = questionNumber + 1
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score : \(score)"
        progressLabel.text = "\(questionNumber+1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber+1)
    }
    

    func nextQuestion() {
     
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }
        else {
            
            let alert = UIAlertController(title: "AWESOME", message: "You have now reached to the end of the quiz. Do you wish to start over ?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (alert) in
                self.startOver()
                self.nextQuestion()
            }
            alert.addAction(restartAction)
            //present(alert,animated: true,completion: nil)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let firstQuestion = allQuestions.list[questionNumber]
        let correctAnswer = firstQuestion.answer
        if answerPicked == correctAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        }
        else{
            ProgressHUD.showError("Wrong Answer")
        }

        
        
    
        
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
       
    }
    

    
}
