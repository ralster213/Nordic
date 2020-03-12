import AVFoundation
struct MyVariables {
    static var capCount = 0
    static var runCount = 0
    static var capName = ""
    static var capPhone = ""
    static var capEmail = ""
    static var capPicture = ""
    static var doStuff = false
    
    
    //static var pianoSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Bruh", ofType: "wav")!);
    static var bruhmusic = NSURL(fileURLWithPath: Bundle.main.path(forResource: "realBruhMusic", ofType: "wav")!);
    }
   

//make all of the captains names one global variable and change the global variable each button press and have it so a timer that is always firing in the background checking to see what the capCount is
