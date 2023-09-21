//
//  GameViewController.swift
//  Exercise4_Movva_Sanjana
//
//  Created by Sanjana Movva on 9/18/23.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    var backgroundAudioPlayer: AVAudioPlayer?
    //weak var delegate: ScoreViewDelegate?

        // Function to handle a battle win
        //private func handleBattleWin(player: Int) {
            // Update the delegate with the winner
            //delegate?.handleBattleWin(player: player)
       // }
    
    //let playerImages = [UIImage(named: "1_Balerion.png"), UIImage(named: "1_Meraxes.png"), UIImage(named: "1_Sheepstealer.png"), UIImage(named: "2_Silverwing.png"), UIImage(named: "2_Meleys.png"), UIImage(named: "2_Quicksilver.png"), UIImage(named: "3_Stormcloud.png"), UIImage(named: "3_Drogon.png"), UIImage(named: "3_Viserion.png")]
    
    let playerImages = ["1_Balerion.png", "1_Meraxes.png", "1_Sheepstealer.png", "2_Silverwing.png", "2_Meleys.png", "2_Quicksilver.png", "3_Stormcloud.png", "3_Drogon.png", "3_Viserion.png"]
    
    let playerImageNames = ["Balerion", "Meraxes", "Sheepstealer", "Silverwing", "Meleys", "Quicksilver", "Stormcloud", "Drogon", "Viserion"]
        
    
    var player1Wins = 0
    var player2Wins = 0
    var isGameOver = false


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addTapGesture(to: fightLogo, action: #selector(handleFightTap))
        addTapGesture(to: restartLogo, action: #selector(handleRestartTap))
        
        // Background sound for the game.
        
        if let backgroundSoundURL = Bundle.main.url(forResource: "got", withExtension: "mp3") {
                    do {
                        backgroundAudioPlayer = try AVAudioPlayer(contentsOf: backgroundSoundURL)
                        backgroundAudioPlayer?.numberOfLoops = -1 // Loop indefinitely
                        backgroundAudioPlayer?.volume = 0.5 // Adjust the volume as needed
                        backgroundAudioPlayer?.play()
                    } catch {
                        print("Error loading background sound: \(error.localizedDescription)")
                    }
                } else {
                    print("Background sound file not found.")
                }
        

    }
    

    @IBOutlet weak var player1Logo: UIImageView!
    
    @IBOutlet weak var player2Logo: UIImageView!
    
    @IBOutlet weak var winner: UILabel!
    
    @IBOutlet weak var restartLogo: UIImageView!
    
    @IBOutlet weak var fightLogo: UIImageView!
    
    func addTapGesture(to view: UIView, action: Selector) {
            let tapGesture = UITapGestureRecognizer(target: self, action: action)
            view.addGestureRecognizer(tapGesture)
            view.isUserInteractionEnabled = true
        }
    
    //Animation
    // Winning animation
    func playWinAnimation() {
        // scaling animation
        UIView.animate(withDuration: 0.5, animations: {
            self.player1Logo.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (finished) in
            UIView.animate(withDuration: 0.5) {
                self.player1Logo.transform = CGAffineTransform.identity
            }
        }
    }

    // Losing animation
    func playLoseAnimation() {
        // shaking animation
        UIView.animate(withDuration: 0.1, animations: {
            self.player1Logo.transform = CGAffineTransform(translationX: -5, y: 0)
        }) { (finished) in
            UIView.animate(withDuration: 0.1, animations: {
                self.player1Logo.transform = CGAffineTransform(translationX: 5, y: 0)
            }) { (finished) in
                UIView.animate(withDuration: 0.1) {
                    self.player1Logo.transform = CGAffineTransform.identity
                }
            }
        }
    }

    
    @objc func handleFightTap() {
        // Check if the game is over
        /*if player1Wins >= 3 || player2Wins >= 3 {
            // Reset the game
            player1Wins = 0
            player2Wins = 0
            winner.text = "Restart the game"
            player1Logo.image = UIImage(named: "0_HOD_logo.png")
            player2Logo.image = UIImage(named: "0_HOD_logo.png")
        } else {*/
        
        if isGameOver {
            return
        }
            
            // Generate random indices for player images
            var player1Index = Int.random(in: 0..<playerImages.count)
            var player2Index = Int.random(in: 0..<playerImages.count)
            
            // Ensure that player 1 and player 2 images are not the same
            while player1Index == player2Index {
                player2Index = Int.random(in: 0..<playerImages.count)
            }
            
            
            var resultText: String
            var winningPlayerName = ""
        
            if player1Index < player2Index {
                resultText = "Player 1 wins the round!"
                winningPlayerName = playerImageNames[player1Index]
               // handleBattleWin(player: 1)
                player1Wins += 1
                playWinAnimation()
                let userInfo: [String: Any] = ["winningPlayer": "Player 1"]
                    NotificationCenter.default.post(name: Notification.Name("PlayerWinsNotification"), object: nil, userInfo: userInfo)
                       
            } else {
                resultText = "Player 2 wins the round!"
                winningPlayerName = playerImageNames[player2Index]
               // handleBattleWin(player: 2)
                player2Wins += 1
                playLoseAnimation()
                let userInfo: [String: Any] = ["winningPlayer": "Player 2"]
                    NotificationCenter.default.post(name: Notification.Name("PlayerWinsNotification"), object: nil, userInfo: userInfo)
            
            }
            
            // Set the result in the "winner" label
            winner.text = winningPlayerName + " is stronger.\n"  + resultText
            
            // Check if the game is over
            if player1Wins >= 3 || player2Wins >= 3 {
                //winner.numberOfLines = 2
                if(player1Wins == 3) {
                    resultText = "Player 1 won! (" + String(player1Wins) + " - " + String(player2Wins) + ")"
                    winner.text = resultText + "\nRestart the game."
                    isGameOver = true
                } else {
                    resultText = "Player 2 won! (" + String(player1Wins) + " - " + String(player2Wins) + ")"
                    winner.text = resultText + "\nRestart the game."
                    isGameOver = true
                }
                //winner.text = resultText + "\nRestart"
            }
            
            
            // Set the new player images
            player1Logo.image = UIImage(named: playerImages[player1Index])
            player2Logo.image = UIImage(named: playerImages[player2Index])
            
        
        
    }
    
    @objc func handleRestartTap() {
        winner.text = "Prepare for the battle!"
        player1Logo.image = UIImage(named: "0_HOD_logo.png")
        player2Logo.image = UIImage(named: "0_HOD_logo.png")
        player1Wins = 0
        player2Wins = 0
        isGameOver = false
        NotificationCenter.default.post(name: Notification.Name("GameRestartedNotification"), object: nil)
        
    }
    
    
    
}
