//
//  BruhButton.swift
//  NordicPractice
//
//  Created by 90305007 on 3/9/20.
//  Copyright © 2020 90305007. All rights reserved.
//

import UIKit
import AVFoundation
class BruhButton: UIViewController {
    var time = 10
    var highScore = 0
    var doStart = true
    var countBruh = false
    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var hitTheBruh: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    var pianoSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Bruh", ofType: "wav")!);
    var audioPlayer = AVAudioPlayer()
    var bruhmusic = NSURL(fileURLWithPath: Bundle.main.path(forResource: "realBruhMusic", ofType: "wav")!);
    var audioPlayer2 = AVAudioPlayer()
    
    @IBOutlet weak var bruhCounter: UILabel!
    var bruhCount = 0
    
    override func viewDidLoad() {
        print("well hello there chaps")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    
    @IBAction func bruhButton(_ sender: Any) {
        do{
        print("hi")
        audioPlayer = try AVAudioPlayer(contentsOf: pianoSound as URL)
        audioPlayer.play()
            if countBruh == true{
            bruhCount += 1
            bruhCounter.text = String(bruhCount)
            }
        }
        catch{
            
        }
        
    }
    
    @IBAction func startPress(_ sender: Any) {
       //let
        
        if doStart == true{
            hitTheBruh.text = "Hit The Bruh Button!"
            bruhCount = 0
            timeCount.text = "Time: 10"
            bruhCounter.text = "0"
            self.time = 10
            doStart = false
            countBruh = true
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("timer Fired")
            self.time -= 1
            self.timeCount.text = "Time: " + String(self.time)
            if self.time == 0{
                self.timeCount.text = "Time's Up!"
                self.bruhCounter.text = "Your Score is " + String(self.bruhCount) + "!"
                if self.bruhCount > self.highScore {
                    self.highScore = self.bruhCount
                    self.timeCount.text = "New High Score!"
                    self.highScoreLabel.text = "High Score: " + String(self.highScore)
                    
                }
                timer.invalidate()
                self.doStart = true
                self.countBruh = false
                self.hitTheBruh.text = ""
               do{
                self.audioPlayer2 = try AVAudioPlayer(contentsOf: self.bruhmusic as URL)
                self.audioPlayer2.play()
                   }
                   catch{
                   
                   }
            }
            }
            
                
            
        }
        
        
    }
    

}
