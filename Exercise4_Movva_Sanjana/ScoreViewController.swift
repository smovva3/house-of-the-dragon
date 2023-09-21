//
//  ScoreViewController.swift
//  Exercise4_Movva_Sanjana
//
//  Created by Sanjana Movva on 9/18/23.
//

import UIKit

/*protocol ScoreViewDelegate: AnyObject {
    func handleBattleWin(player: Int)
 
}*/

class ScoreViewController: UIViewController {
    /*func handleBattleWin(player: Int) {
        player1B1.image = UIImage(named: "0_HOD_logo.png")

        
        if (player == 1) {
            var index = 0
            for i in 0...2 {
                if (player1Scores[i] == false) {
                    player1Scores[i] = true
                }
            }
        } else {
            var index = 0
            for i in 0...2 {
                if (player2Scores[i] == false) {
                    player2Scores[i] = true
                }
            }
        }
    }
    
    var player1Scores = [false, false, false]
    var player2Scores = [false, false, false]*/
    
    var player1RoundsWon = 0
    var player2RoundsWon = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerWins(_:)), name: Notification.Name("PlayerWinsNotification"), object: nil)
            
        NotificationCenter.default.addObserver(self, selector: #selector(restart(_:)), name: Notification.Name("GameRestartedNotification"), object: nil)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(restart(_:)))
                view.addGestureRecognizer(tapGestureRecognizer)
                
           
        
        
            
    }
   
    
    deinit {
            NotificationCenter.default.removeObserver(self)
        }
    

    @IBOutlet weak var player1B1: UIImageView!
    
    @IBOutlet weak var player1B2: UIImageView!
    
    @IBOutlet weak var player1B3: UIImageView!
    
    @IBOutlet weak var player2B1: UIImageView!
    
    @IBOutlet weak var player2B2: UIImageView!
    
    @IBOutlet weak var player2B3: UIImageView!
    

    @objc func playerWins(_ notification: Notification) {
            if let userInfo = notification.userInfo, let winningPlayer = userInfo["winningPlayer"] as? String {
                
                if winningPlayer == "Player 1" {
                    player1RoundsWon += 1
                    updatePlayer1Images()
                } else if winningPlayer == "Player 2" {
                    player2RoundsWon += 1
                    updatePlayer2Images()
                }
            }
        }

        @objc func restart(_ sender: UITapGestureRecognizer) {
            player1RoundsWon = 0
            player2RoundsWon = 0
            updatePlayer1Images()
            updatePlayer2Images()
          
        }
        
        func updatePlayer1Images() {
            player1B1.alpha = player1RoundsWon >= 1 ? 1.0 : 0.1
            player1B2.alpha = player1RoundsWon >= 2 ? 1.0 : 0.1
            player1B3.alpha = player1RoundsWon >= 3 ? 1.0 : 0.1
        }

        
        func updatePlayer2Images() {
            player2B1.alpha = player2RoundsWon >= 1 ? 1.0 : 0.1
            player2B2.alpha = player2RoundsWon >= 2 ? 1.0 : 0.1
            player2B3.alpha = player2RoundsWon >= 3 ? 1.0 : 0.1
            player2B3.alpha = player2RoundsWon >= 3 ? 1.0 : 0.1
        }
        
}
    
