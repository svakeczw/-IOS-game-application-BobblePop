//
//  WelcomepageViewController.swift
//  bpgame
//
//  Created by Zhangwei Chen on 16/5/20.
//  Copyright © 2020 Zhangwei Chen. All rights reserved.
//

import UIKit

class WelcomepageViewController: UIViewController {

    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var currentRankDic = [String:Double]()
    var sortedRank = [(key: String, value: Double)]()
    var lastRankDic = [String:Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Display defult high score
        if UserDefaults.standard.dictionary(forKey: "currentRank")  == nil {
            highScoreLabel.text = String(0)
        }
        else {
            //Display high score
            lastRankDic = UserDefaults.standard.dictionary(forKey: "currentRank") as! [String:Double]
            sortedRank = lastRankDic.sorted(by: {$0.value > $1.value})
            highScoreLabel.text = String(Int(sortedRank[0].value))
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
