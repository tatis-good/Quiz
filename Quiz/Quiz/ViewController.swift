//
//  ViewController.swift
//  Quiz
//
//  Created by spark-02 on 2024/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
  
    let quizzes = ["猫は人間を超でっかいネコだと思っている？",
     "イヌは食べ物の美味しさを味よりも匂いで判断している？",
     "トラのシマシマ模様は皮膚まで繋がっていない？"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        var str = ""
        str = self.quizzes[0]
        self.label.text = str
        
    }
    
    
    
    @IBAction func pressButton(_ sender: Any) {
        self.label.text = "ボタンを押しました"
        self.label.textColor = UIColor.blue
    }
    
}

