//
//  QuizViewController.swift
//  Quiz
//
//  Created by spark-02 on 2024/05/07.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var nameText: String = ""
    
    @IBOutlet weak var quizcard: QuizCard!
    let manager: QuizManager = QuizManager()
    //View Controller の実装
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //画面の初期設定やデータのロードをなど行う
        // Do any additional setup after loading the view.
        self.quizcard.style = .initial
        self.loadQuiz()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragQuizCard(_:)))
        self.quizcard.addGestureRecognizer(panGestureRecognizer)
        self.label.text = self.nameText
    }
    
    func loadQuiz() {
        self.quizcard.quizLabel.text = manager.currentQuiz.text
        self.quizcard.quizImageView.image = UIImage(named: manager.currentQuiz.imageName)
    }
    @objc func dragQuizCard(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began, .changed:
            self.transformquizcard(gesture: sender)
        case .ended:
            break
        default:
            break
        }
    }
    func transformquizcard(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.quizcard)
        let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
        let translationPerfect = translation.x/UIScreen.main.bounds.width/2
        let rotationAngle = CGFloat.pi/3 * translationPerfect
        let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
        let transform = translationTransform.concatenating(rotationTransform)
        self.quizcard.transform = transform
        
        
        if translation.x > 0 {
            self.quizcard.style = .right
        } else {
                self.quizcard.style = .wrong
            }
        }
    }

