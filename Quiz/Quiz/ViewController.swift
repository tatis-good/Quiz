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
        var str = ""
        str = "Hello Swift"
        self.label.text = str
    }
    
    
    
    @IBAction func pressButton(_ sender: Any) {
        self.label.text = "ボタンを押しました"
        self.label.textColor = UIColor.blue
    }
    
}

