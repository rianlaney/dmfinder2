//
//  GameViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 2/19/23.
//

import UIKit

class GameViewController: UIViewController {
    
    /**
     5.1 Create IBOutlets for the target letter label, the score label, and the seconds label. Also, create an IBOutlet collection for the letter buttons.
     */
    @IBOutlet weak var targetLetter: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var seconds: UILabel!
    
    @IBOutlet var letterBtns: [UIButton]!
    
    var timer: Timer!
    let gameBrain = GameBrain.shared
    
    /**
     6.1 Use the game brain to start a new game. Hint: We want the number of letters to be the number of letters buttons that we have.
     6.2 Create a function that uses the game brain to update the target letter label, the score label, the seconds label, and the title of each letter button. Call the function here.
     6.3 Call the provided `configureTimer` function.
     */
    
    func updateUI() {
        targetLetter.text = gameBrain.targetLetter
        score.text = String(gameBrain.score)
        seconds.text = String(gameBrain.secondsRemaining)
        for (index, button) in letterBtns.enumerated(){
            button.setTitle(gameBrain.randomLetters[index], for: .normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameBrain.newGame(numLetters: letterBtns.count)
        
        updateUI()
        configureTimer()
        
    }
    
    /*
     We are invalidating the timer when the screen disappears. You do not need to modify this code.
     */
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer.invalidate()
    }
    
    /*
     You do not need to modify this code.
     */
    func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: fireTimer(timer:))
        RunLoop.current.add(timer, forMode: .common)
    }
    
    
    /**
     7.1 Use the game brain to process the selected letter and call `updateUI`.
     */
    //ib action
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        gameBrain.letterSelected(userGuess: sender.titleLabel!.text!)
        updateUI()
    }
    
    
    /*
     8.1 This function will get called automatically every second. Uncomment the provided code and add one more line of code inside the conditional to transition the user back to the start screen.
     */
    func fireTimer(timer: Timer) {
        gameBrain.secondsRemaining -= 1
        updateUI()
        
        if gameBrain.secondsRemaining <= 0 {
            timer.invalidate()
            
        }
    }
}
