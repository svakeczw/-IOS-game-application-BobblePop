//
//  SettingpageViewController.swift
//  bpgame
//
//  Created by Zhangwei Chen on 4/5/20.
//  Copyright © 2020 Zhangwei Chen. All rights reserved.
//

import UIKit

class SettingpageViewController: UIViewController {

    var playerDictionary = [String:String]()
    var gamesettingDictionary = [String:Int]()
    var bubbleNum : Int = 15
    var timeNum : Int = 60
    var defaultName = "No Name"
    
    @IBOutlet weak var playerName: UITextField!
    
    @IBOutlet weak var bubbleNumber: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBAction func inputName(_ sender: Any) {
    }
    
    @IBAction func numberSlider(_ sender: UISlider) {
        //Set bubble number
        bubbleNumber.text = String(Int(sender.value))
        bubbleNum = Int(sender.value)
    }
    
    @IBAction func timeSlider(_ sender: UISlider) {
        //Set gaming time
        timeLabel.text = String(Int(sender.value))
        timeNum = Int(sender.value)
    }
    
    
    
    
    @IBAction func startGame(_ sender: UIButton) {

    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        //Pass bubble number and gamin time to gaming page
        if let view = segue.destination as? GamingpageViewController {
            view.gTime = timeNum
            view.bubbleNum = bubbleNum
        }
        
        //Set a defult player name
        if playerName.hasText  == false {
            segue.destination.navigationItem.title = defaultName
    }
        else {
            //Pass player name to gaming page
            if let name = self.playerName.text {
                segue.destination.navigationItem.title = name
            }
        }
        
        
        
        
        
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
