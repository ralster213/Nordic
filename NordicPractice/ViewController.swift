//
//  ViewController.swift
//  NordicPractice
//
//  Created by 90305007 on 3/4/20.
//  Copyright © 2020 90305007. All rights reserved.
// lets try to see if this works
import CoreData
import UIKit
import MessageUI
import CloudKit
import WebKit
import AVKit
import AVFoundation

// MARK: Captin Class
class Captin {
    var name: String;
    var phoneNumber: String;
    var picture: String;
    var emailAddress: String;
    
    
    init(name: String, phoneNumber: String, picture: String, emailAddress: String) {
        self.name = name;
        self.phoneNumber = phoneNumber;
        self.picture = picture;
        self.emailAddress = emailAddress;
    }
    
}
//class Goal {
//    var goal: String;
//
//    init(goal: String){
//        self.goal = goal;
//    }
//}


//MARK: Announce Class
class Announce {
    var title: String;
    var time: String;
    var message: String;
    
    init(title: String, time: String, message: String){
        self.title = title;
        self.time = time;
        self.message = message;
    }
    
}

class ViewController: UIViewController, UITextFieldDelegate, MFMessageComposeViewControllerDelegate, UITableViewDelegate {
    
    @IBOutlet weak var webkit: WKWebView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var phoneNumberLabel: UILabel?
    @IBOutlet weak var emailAddressLabel: UILabel?
    @IBOutlet weak var picturePath: UIImageView!
    @IBOutlet weak var goalLabel: UILabel?
    @IBOutlet weak var goal2Label: UILabel?
    @IBOutlet weak var goal3Label: UILabel?
    @IBOutlet weak var cap1Look: UIButton!
    @IBOutlet weak var cap2Look: UIButton!
    @IBOutlet weak var cap3Look: UIButton!
    @IBOutlet weak var cap4Look: UIButton!
    @IBOutlet weak var cap5Look: UIButton!
    @IBOutlet weak var cap6Look: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var hitTheBruh: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var bruhCounter: UILabel!
    
    
    
    //MARK: Vars
    var pianoSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Bruh", ofType: "wav")!);
    var YMessage = 0.0

    var time = 10
    var nextField = UITextField(frame: CGRect(x: 10.0, y: 100.0, width: UIScreen.main.bounds.size.width - 20.0, height: 50.0))
    var highScore = 0
    var doStart = true
    var countBruh = false
    
    
    
    var audioPlayer = AVAudioPlayer()
   
    var audioPlayer2 = AVAudioPlayer()
    
    let goal = UserDefaults.standard
    
    let goal1 = UserDefaults.standard
    
    let goal2 = UserDefaults.standard
    
    let goal3 = UserDefaults.standard
    
    var Goal1 = ""
    var Goal2 = ""
    var Goal3 = ""
    var bruhCount = 0
    static var goals: Array<String> = []
    static var captains: Array<Captin> = [
    Captin(name: "Connor Holm", phoneNumber: "612-254-5870", picture: "ConnorPic", emailAddress: "connorholm@email.com"),
    Captin(name: "Ethan Koland", phoneNumber: "612-478-8080", picture: "KolandPic", emailAddress: "ethankoland@email.com"),
    Captin(name: "Mason Martin", phoneNumber: "612-425-9535", picture: "MasonPic", emailAddress: "masonmartin@email.com"),
    Captin(name: "Ella Bakken", phoneNumber: "612-696-6969", picture: "BakkenPic", emailAddress: "ellabakken@email.com"),
    Captin(name: "Silje Busklein", phoneNumber: "612-696-6969", picture: "BuskleinPic", emailAddress: "siljebusklein@email.com"),
    Captin(name: "Ella Williams", phoneNumber: "612-696-6969", picture: "WilliamsPic", emailAddress: "ellawilliams@email.com")
    ]
    
    override func viewDidLoad() {
      // cap1Look.titleLabel?.text = ViewController.captains[0].name
        super.viewDidLoad()
        let url = URL(string: "https://sites.google.com/site/epnordic/home")
        let request = URLRequest(url:url!)
        webkit?.load(request)
        if let text1 = goal1.object(forKey: "text1") as? String {
            var word = goal1.object(forKey: "text1") as! String
            goalLabel?.text = "Goal 1: " + word
        }
        if let text2 = goal2.object(forKey: "text2") as? String {
            var word = goal2.object(forKey: "text2") as! String
            goal2Label?.text = "Goal 2: " + word
        }
        if let text3 = goal3.object(forKey: "text3") as? String {
            var word = goal3.object(forKey: "text3") as! String
            goal3Label?.text = "Goal 3: " + word
        }
        nameLabel?.text = "Name: " + MyVariables.capName
        phoneNumberLabel?.text = "Phone Number: " + MyVariables.capPhone
        emailAddressLabel?.text = "Email: " + MyVariables.capEmail
        
        //picturePath.image = UIImage(named: "ConnorPic")
        
        if(MyVariables.doStuff == true){
            
            picturePath.image = UIImage(named: MyVariables.capPicture)
        }
        MyVariables.doStuff = false
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Captain
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
            case .cancelled:
                print("Message was cancelled")
                dismiss(animated: true, completion: nil)
            case .failed:
                print("Message failed")
                dismiss(animated: true, completion: nil)
            case .sent:
                print("Message was sent")
                dismiss(animated: true, completion: nil)
            default:
            break
        }
    }
    @IBAction func sendMessage(_ sender: Any) {
        let messageVC = MFMessageComposeViewController()
            
        messageVC.body = "Enter a message";
        messageVC.recipients = [MyVariables.capPhone]
        messageVC.messageComposeDelegate = self
            
        self.present(messageVC, animated: true, completion: nil)
    }
    @IBAction func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            //mail.mailComposeDelegate = self
            mail.setToRecipients([MyVariables.capEmail])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            self.present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    //start of bruh button
    //wtf why is this being weird
    @IBAction func openBruh(_ sender: Any) {
        if passwordField.text == "Hit em with the bruh button"{
            self.view.endEditing(true)
            performSegue(withIdentifier: "ToBruhButton", sender: UIButton.self)
        } else{
            passwordLabel.text!.append("nice try, go again")
            self.view.endEditing(true)
        }
    }
    @IBAction func playVid(_ sender: Any) {
        print("hi")
       if let path = Bundle.main.path(forResource: "vid", ofType: "mp4"){
        let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            print("hello")
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
            
        }
       
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
            audioPlayer2.stop()
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
                self.audioPlayer2 = try AVAudioPlayer(contentsOf: MyVariables.bruhmusic as URL)
                self.audioPlayer2.play()
                   }
                   catch{
                   
                   }
            }
            }
            
                
            
        }
        
        
    }
    //end of bruh button
    
    @IBAction func Cap1Press(_ sender: Any) {
        //func captain1
        MyVariables.capCount = 1
        MyVariables.doStuff = true
        performSegue(withIdentifier: "Cap1Segue", sender: (Any).self)
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! ViewController
        destVC.nameLabel?.text = "hello"
        print("hi")
        // stuff is nill in prepare for segue, but not view did load
        if MyVariables.capCount == 1{
            
            MyVariables.capName = ViewController.captains[0].name
            MyVariables.capPhone = ViewController.captains[0].phoneNumber
            MyVariables.capEmail = ViewController.captains[0].emailAddress
            MyVariables.capPicture = ViewController.captains[0].picture
            //print(MyVariables.capPicture)
        }
        if MyVariables.capCount == 2{
            
            MyVariables.capName = ViewController.captains[1].name
            MyVariables.capPhone = ViewController.captains[1].phoneNumber
            MyVariables.capEmail = ViewController.captains[1].emailAddress
            MyVariables.capPicture = ViewController.captains[1].picture
        }
        if MyVariables.capCount == 3{
            
            MyVariables.capName = ViewController.captains[2].name
            MyVariables.capPhone = ViewController.captains[2].phoneNumber
            MyVariables.capEmail = ViewController.captains[2].emailAddress
            MyVariables.capPicture = ViewController.captains[2].picture
        }
        if MyVariables.capCount == 4{
            
            MyVariables.capName = ViewController.captains[3].name
            MyVariables.capPhone = ViewController.captains[3].phoneNumber
            MyVariables.capEmail = ViewController.captains[3].emailAddress
            MyVariables.capPicture = ViewController.captains[3].picture
        }
        if MyVariables.capCount == 5{
            
            MyVariables.capName = ViewController.captains[4].name
            MyVariables.capPhone = ViewController.captains[4].phoneNumber
            MyVariables.capEmail = ViewController.captains[4].emailAddress
            MyVariables.capPicture = ViewController.captains[4].picture
        }
        if MyVariables.capCount == 6{
            
            MyVariables.capName = ViewController.captains[5].name
            MyVariables.capPhone = ViewController.captains[5].phoneNumber
            MyVariables.capEmail = ViewController.captains[5].emailAddress
            MyVariables.capPicture = ViewController.captains[5].picture
        }
        
        
    }
    
    
    @IBAction func Cap2Press(_ sender: Any) {
        //func captain2
        MyVariables.capCount = 2
        MyVariables.doStuff = true
    }
    
    @IBAction func Cap3Press(_ sender: Any) {
        //func captain3
        MyVariables.capCount = 3
        MyVariables.doStuff = true
    }
    
    @IBAction func Cap4Press(_ sender: Any) {
        //func captain4
        MyVariables.capCount = 4
        MyVariables.doStuff = true
    }
    
    @IBAction func Cap5Press(_ sender: Any) {
        MyVariables.capCount = 5
        MyVariables.doStuff = true
    }
    
    
    @IBAction func Cap6Press(_ sender: Any) {
        MyVariables.capCount = 6
        MyVariables.doStuff = true
    }
    
    @IBAction func deleteGoal(_ sender: Any) {
        
    }
    @IBAction func makeGoal1(_ sender: Any) {
        goal1.setValue(nextField.text, forKey: "text1")
        //nextField.text = ""
        if let text1 = goal1.object(forKey: "text1") as? String {
            print(goal1.object(forKey: "text1"))
            var word = goal1.object(forKey: "text1") as! String
            goalLabel?.text = "Goal 1: " + word
        }
    }
    @IBAction func makeGoal2(_ sender: Any) {
        goal2.setValue(nextField.text, forKey: "text2")
        if let text2 = goal2.object(forKey: "text2") as? String {
                print(goal2.object(forKey: "text2"))
                var word = goal2.object(forKey: "text2") as! String
            goal2Label?.text = "Goal 2: " + word
            }
        }
    @IBAction func makeGoal3(_ sender: Any) {
        goal3.setValue(nextField.text, forKey: "text3")
        if let text3 = goal3.object(forKey: "text3") as? String {
            print(goal3.object(forKey: "text3"))
            var word = goal3.object(forKey: "text3") as! String
            goal3Label?.text = "Goal 3: " + word
        }
    }
    
    @IBAction func AddMessage(_ sender: Any) {
        nextField.backgroundColor = .red
        nextField.borderStyle = .line
        nextField.delegate = self
//        if let text = goal1.object(forKey: "text") as? String {
//            print(goal1.object(forKey: "text"))
//            goalLabel?.text = goal1.object(forKey: "text") as! String
//        } else{
//            print("nothing saved")
//        }
        self.view.addSubview(nextField)
        
        //here is where I will try to make it so whenever I make a new prototype-announcement, new constraints come in to resize everything in the content view. When the plus button is clicked, I want a text field to appear. In the text field will be the contents of the next announcement. The contents of the text field, upon hitting return, will be added to a list of strings, that will be given to a series of text views. The text views will be added in upon hitting return
        //The part I need to really get on is the whole constraint adding part.
        //Need to learn how to make the "return" key a function, so that it can add the text field text to the text view.
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nextField.resignFirstResponder()
        ViewController.goals.append(nextField.text!)
        print (ViewController.goals)
        //let textField = UITextView(frame: CGRect(x: 10.0, y: 150 + 60 * YMessage, width: Double(UIScreen.main.bounds.size.width - 20.0), height: 50.0))
        textField.text = nextField.text
        
        self.view.addSubview(textField)
        goal.setValue(nextField.text, forKey: "text")
        if let text = goal.object(forKey: "text") as? String {
        print(goal.object(forKey: "text"))
        //goalLabel?.text = goal1.object(forKey: "text") as! String
        }
        
        nextField.isOpaque = true
        YMessage += 1
        return true
        
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

