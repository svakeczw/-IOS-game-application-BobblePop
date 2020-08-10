//
//  ScoreBoardPageViewController.swift
//  bpgame
//
//  Created by Zhangwei Chen on 12/5/20.
//  Copyright © 2020 Zhangwei Chen. All rights reserved.
//

import UIKit

class ScoreBoardPageViewController: UIViewController {
    

    
    @IBOutlet weak var rankOnePlayer: UILabel!
    
    
    @IBOutlet weak var rankOneScore: UILabel!
    
    
    @IBOutlet weak var rankTwoPlayer: UILabel!
    
    
    @IBOutlet weak var rankTwoScore: UILabel!
    
    
    @IBOutlet weak var rankThreePlayer: UILabel!
    
    
    @IBOutlet weak var rankThreeScore: UILabel!
    
    
    
    
    var sortedRank = [(key: String, value: Double)]()
    var scoreRank = [String:Double]()
    var highScore: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set defult rank board
        if UserDefaults.standard.dictionary(forKey: "currentRank")  == nil {
            rankOneScore.text = ""
            rankOnePlayer.text = ""
            rankTwoScore.text = ""
            rankTwoPlayer.text = ""
            rankThreeScore.text = ""
            rankThreePlayer.text = ""
        } else {
            //Display rank board
            scoreRank = UserDefaults.standard.dictionary(forKey: "currentRank") as! [String:Double]
            if scoreRank.count == 1 {
                sortedRank = scoreRank.sorted(by: {$0.value > $1.value})
                rankOneScore.text = String(Int(sortedRank[0].value))
                rankOnePlayer.text = String(sortedRank[0].key)
                rankTwoScore.text = ""
                rankTwoPlayer.text = ""
                rankThreeScore.text = ""
                rankThreePlayer.text = ""
            } else if scoreRank.count == 2 {
                sortedRank = scoreRank.sorted(by: {$0.value > $1.value})
                print("sortedRank")
                print(sortedRank)
                rankOneScore.text = String(Int(sortedRank[0].value))
                rankOnePlayer.text = String(sortedRank[0].key)
                rankTwoScore.text = String(Int(sortedRank[1].value))
                rankTwoPlayer.text = String(sortedRank[1].key)
                rankThreeScore.text = ""
                rankThreePlayer.text = ""
            } else if scoreRank.count > 2 {
                sortedRank = scoreRank.sorted(by: {$0.value > $1.value})
                rankOneScore.text = String(Int(sortedRank[0].value))
                rankOnePlayer.text = String(sortedRank[0].key)
                rankTwoScore.text = String(Int(sortedRank[1].value))
                rankTwoPlayer.text = String(sortedRank[1].key)
                rankThreeScore.text = String(Int(sortedRank[2].value))
                rankThreePlayer.text = String(sortedRank[2].key)
            }
        }
        }
        // Do any additional setup after loading the view.
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
