//
//  gamingPageViewController.swift
//  bpgame
//
//  Created by Zhangwei Chen on 4/5/20.
//  Copyright © 2020 Zhangwei Chen. All rights reserved.
//

import UIKit

class GamingpageViewController: UIViewController {

    
    @IBOutlet weak var gameTime: UILabel!
    
    @IBOutlet weak var readyTime: UILabel!
    
    @IBOutlet weak var gameScore: UILabel!
    
    @IBOutlet weak var highScore: UILabel!
    
    
    
    //Player name
    var finalName = ""
    //Defult gaming time
    var gTime: Int = 60
    //Gaming time timer
    var gTimer = Timer()
    //Ready count down timer
    var readyTimer = Timer()
    //Ready count down defult time
    var readySecond: Int = 3
    //Bubble
    var bubble = Bubble()
    //Defult bubble number
    var bubbleNum = 15
    //Bubble list
    var bubbleList = [Bubble]()
    var screenWidth:UInt32 {
        return UInt32(UIScreen.main.bounds.width)
    }
    var screenHeight:UInt32 {
        return UInt32(UIScreen.main.bounds.height)
    }
    //Previous score value
    var oldValue: Double = 0.0
    //Current score
    var score: Double = 0.0
    //Previous score rank dictionary
    var lastRankDic = [String:Double]()
    //Current score rank dictionary
    var currentRankDic = [String:Double]()
    //Ranked score aray
    var sortedRank = [(key: String, value: Double)]()

    
    //Ready count down method
    @objc func readyCounter() {
        //Ready Countdown
        readyTime.text? = String(readySecond)
        if(readySecond == 0){
            readyTimer.invalidate()
            readyTime.removeFromSuperview()
        }
        readySecond -= 1
    }
    
    
    //Ready count down timer
    func readycountdown() {
        readyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GamingpageViewController.readyCounter), userInfo: nil, repeats: true)
    }

    
    //Gaming timer method
    @objc func gamingTime() {
        gameTime.text = String(gTime)
        if gTime == 0 {
            gTimer.invalidate()
        }
        gTime -= 1
    }
    
    
    //Generate bubble
    @objc func bubbleGenerate() {
        if gTime != 0 {
            //Set random bubble number
            let generateNum = arc4random_uniform(UInt32(bubbleNum)) + 2
            var x = 0
            while x < generateNum {
                bubble = Bubble()
                //Set bubble location and size
                bubble.frame = CGRect(x: CGFloat(25 + arc4random_uniform(screenWidth-150)), y: CGFloat(280 + arc4random_uniform(screenHeight-370)), width: CGFloat(40), height: CGFloat(40))
                //Bubble size and how to appear
                bubble.layer.cornerRadius = bubble.frame.height/2
                if checkOverlap(newBubble: bubble) == false {
                    self.view.addSubview(bubble)
                    bubble.pulsate()
                    bubble.addTarget(self, action: #selector(addScore), for:UIControl.Event.touchUpInside)
                    bubbleList.append(bubble)
                    x += 1
                }
                else {
                    //Print for test
                    print("overlap,"+String(x))
                }
            }
            //Stop game when timer end
            if gTime == 0 {
                gameStop()
            }
        }
    }
    
    
    //Save score to user defult
    @objc func saveScore() {
        let defults = UserDefaults.standard
        if lastRankDic.isEmpty == false {
            currentRankDic = lastRankDic
            currentRankDic.updateValue(score, forKey: finalName)
        } else {
            currentRankDic.updateValue(score, forKey: finalName)
        }
        defults.set(currentRankDic,forKey: "currentRank")
        //Print for test
        print("currentDic")
        print(currentRankDic)
    }


    //Stop game
    @objc func gameStop() {
        //Remove all bubbles
        if gameTime.text == String(0) {
            for bubble in bubbleList{
                bubble.removeFromSuperview()
            }
            saveScore()
            //Display name
            let nameDisplay = UILabel(frame: CGRect(x: Int((screenWidth/2)-150), y: Int((screenHeight/2)-150), width: 300, height: 300))
            nameDisplay.font = UIFont.systemFont(ofSize: 30)
            nameDisplay.textColor = UIColor.init(red: 0, green: 0.7412, blue: 0.9294, alpha: 1)
            nameDisplay.textAlignment = NSTextAlignment.center
            nameDisplay.text = navigationItem.title
            self.view.addSubview(nameDisplay)
            //Display score
            let scoreDisplay = UILabel(frame: CGRect(x: Int((screenWidth/2)-150), y: Int((screenHeight/2)-150+70), width: 300, height: 300))
            scoreDisplay.font = UIFont.systemFont(ofSize: 30)
            scoreDisplay.textColor = UIColor.init(red: 0, green: 0.7412, blue: 0.9294, alpha: 1)
            scoreDisplay.textAlignment = NSTextAlignment.center
            scoreDisplay.text = "Your score is: " + String(Int(score))
            self.view.addSubview(scoreDisplay)
            //Display a button for jumping to score board
            let goScorepage = UIButton(frame: CGRect(x: Int((screenWidth/2)-150), y: Int((screenHeight/2)-150+70+70), width: 300, height: 300))
            goScorepage.setTitle("Go to ScoreBoard", for: .normal)
            goScorepage.setTitleColor(UIColor.init(red: 0, green: 0.0235, blue: 0.1765, alpha: 1), for: .normal)
            goScorepage.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            goScorepage.addTarget(self, action: #selector(goToScorepage), for: .touchUpInside)
            self.view.addSubview(goScorepage)
        }
    }
    
    
    //Remove bubble
    @objc func bubbleRemove() {
        var n = 0
        while n <= bubbleList.count  {
            //Avoid remving the only bubble on screen
            if bubbleList.count != 1 && n != bubbleList.count {
                //Set a random number for removing bubble
                let x = Int(arc4random_uniform(UInt32(bubbleList.count)))
                bubbleList[x].removeFromSuperview()
                bubbleList.remove(at: x)
                n += 1
            }
            else{
                n += 1
            }
        }
    }
    
    
    //Check bubble overlap
    @objc func checkOverlap(newBubble:Bubble) -> Bool {
        var n = 0
        while n < bubbleList.count {
            if newBubble.frame.intersects(bubbleList[n].frame) {
                n += 1
                return true
            }
            n += 1
        }
        return false
    }
    
    
    //Add score when tap bubble
    @IBAction func addScore(sender:Bubble) {
        sender.removeFromSuperview()
        if sender.value == oldValue {
            score = score + (sender.value)*1.5
            oldValue = sender.value
            gameScore.text = String(Int(score))
            //Score text become red when combo
            gameScore.textColor = UIColor.red
            //Check high score
            checkHighScore()
        }
        else {
            score = score + sender.value
            oldValue = sender.value
            gameScore.text = String(Int(score))
            gameScore.textColor = UIColor.black
            //Check high score
            checkHighScore()
        }
    }
    
    
    //Jump to score board
    @objc func goToScorepage() {
        performSegue(withIdentifier: "showScore", sender: nil)
    }
    
    
    //Check high score
    @objc func checkHighScore() {
        //Set a defult high score
        if sortedRank.isEmpty {
            highScore.text = String(Int(score))
        } else if score > sortedRank[0].value {
            highScore.text = String(Int(score))
        } else {
            highScore.text = String(Int(sortedRank[0].value))
        }
    }


    //What to do when view load
    override func viewDidLoad() {
        //Set a dufult sorted rank
        if UserDefaults.standard.dictionary(forKey: "currentRank")  == nil {
            sortedRank = [("",0)]
        }
        else {
            //Sort rank
            lastRankDic = UserDefaults.standard.dictionary(forKey: "currentRank") as! [String:Double]
            sortedRank = lastRankDic.sorted(by: {$0.value > $1.value})
        }
        //Display high score
        if sortedRank.isEmpty == true {
            highScore.text = "0"
        } else {
            highScore.text = String(Int(sortedRank[0].value))
        }
        //Print for test
        print("sortedRank")
        print(sortedRank)
        //Display player name
        finalName = navigationItem.title!
        //Display readytime
        readyTime.text = String(readySecond)
        //Display gamingtime
        gameTime.text = String(gTime)
        //Ready countdown
        readycountdown()
        //Start game
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 3 ){
            self.gTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (gTimer) in
                self.gamingTime()
                self.bubbleGenerate()
                self.bubbleRemove()
                self.gameStop()
            })
        }
        super.viewDidLoad()
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
