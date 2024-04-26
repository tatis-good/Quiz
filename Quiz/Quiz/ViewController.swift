//
//  ViewController.swift
//  Quiz
//
//  Created by spark-02 on 2024/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.label.text = "Hello"
        self.label.textColor = UIColor.red
    }
    
    @IBAction func pressButton(_ sender: Any) {
        self.label.text = "ボタンを押しました"
        self.label.textColor = UIColor.blue
    }
    
}

