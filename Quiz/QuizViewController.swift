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
    
    func answer() {
        var translationTransform: CGAffineTransform
        let screenWidth = UIScreen.main.bounds.width
        let y = UIScreen.main.bounds.height * 0.2
        
        if self.quizcard.style == .right {
            
            translationTransform = CGAffineTransform(translationX: screenWidth, y: y)
            self.manager.answerQuiz(answer: true)
        } else {
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: y)
            self.manager.answerQuiz(answer: false)
        }
        UIView.animate(withDuration: 0.5, delay:0.1, options: [.curveLinear], animations: {
            self.quizcard.transform = translationTransform}, completion: { [unowned self] (finished) in
                if finished {
                    self.showNextQuiz()
                }
            })
    }
    
    func showNextQuiz() {
        self.manager.nextQuiz()
        
        switch manager.status {
        case .inAnswer:
            
            self.quizcard.transform = CGAffineTransform.identity
            self.quizcard.style = .initial
            self.loadQuiz()
        case .done:
            self.quizcard.isHidden = true
            self.performSegue(withIdentifier: "goToResult", sender: nil)
        }
    }
    
    
    
    @objc func dragQuizCard(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began, .changed:
            self.transformquizcard(gesture: sender)
        case .ended:
            self.answer()
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController: ResultViewController = segue.destination as? ResultViewController{
            resultViewController.nameText = self.nameText
            resultViewController.score = self.manager.score
        }
    }
}

