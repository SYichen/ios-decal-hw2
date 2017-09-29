//
//  GameVC.swift
//  Hangman
//
//  Created by Yichen Sun on 9/22/17.
//  Copyright © 2017 iOS DeCal. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var hangmanImg: UIImageView!
    var game: HangmanGame!
    var img: Int = 1
    let alphabet: [Character] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    @IBOutlet weak var guessed: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        game = HangmanGame()
        hangmanImg.image = #imageLiteral(resourceName: "hangman1")
        updateGuessed()
    }
        
        
        // Do any additional setup after loading the view.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startOver(_ sender: UIButton) {
        startOver()
    }
    
    func startOver() {
        game = HangmanGame()
        img = 0
        updateImage(img)
        updateGuessed()
        for button in buttons {
            button.setTitleColor(.darkText, for: .normal)
        }
    }
    
    @IBAction func letterPressed(_ sender: UIButton) {
        sender.setTitleColor(.lightGray, for: .normal)
        let guess = alphabet[sender.tag]
        let alreadyGuessed = game.wrongGuesses.contains(guess)
        let correct = game.takeTurn(game: game, guess: guess)
        if (correct && !alreadyGuessed) {
            updateGuessed()
        }
        else {
            if (!alreadyGuessed) {
                updateImage(img)
            }
        }
        if (!game.can_continue(game: game)) {
            let won = game.did_win(game: game)
            var outcome: String!
            if won {
                outcome = "won"
            }
            else {
                outcome = "lost"
            }
            performSegue(withIdentifier: "endGame", sender: outcome)
        }
    }

    func updateImage(_ imgNum: Int) {
        img += 1
        let imgName = "hangman" + String(img)
        hangmanImg.image = UIImage(named: imgName)
    }
    
    func updateGuessed() {
        var str = ""
        for c in game.guessed {
            str += String(c)
        }
        
        guessed.text = str
        guessed.setTextSpacingBy(value: 2.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "endGame" {
                if let dest = segue.destination as? EndVC {
                    if let outcome = sender as? String {
                        if (outcome == "won") {
                            dest.newLabel = "You won! ✨🎉"
                        }
                        else {
                            dest.newLabel = "You lost 😞"
                        }
                    }
                }
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UILabel {
    func setTextSpacingBy(value: Double) {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

