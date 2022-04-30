//
//  ViewController.swift
//  TicTacToe
//
//  Created by Daniil Balakiriev on 30.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet var boardButtons: [UIButton]!
    @IBOutlet weak var playAgainButton: UIButton!
    
    var activePlayer: Bool = true
    var state: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winningPos: [[Int]] = [[0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8], [6, 4, 2]]
    
    @IBAction func boardButtonClick(_ sender: Any) {
        let button = sender as! UIButton
        if state[button.tag] == 0 {
            if activePlayer {
                button.alpha = 0.0
                button.setImage(UIImage(named: "cross"), for: UIControl.State())
                UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
                    button.alpha = 1.0
                })
                activePlayer = !activePlayer
//                statusLabel.text = "O turn!"
                animatedTextChange(message: "O turn!")
                state[button.tag] = 1
            }
            else{
                button.alpha = 0.0
                button.setImage(UIImage(named: "circle"), for: UIControl.State())
                UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
                    button.alpha = 1.0
                })
                activePlayer = !activePlayer
//                statusLabel.text = "X turn!"
                animatedTextChange(message: "X turn!")
                state[button.tag] = 2
            }
            for pos in winningPos {
                if state[pos[0]] != 0 && state[pos[0]] == state[pos[1]] && state[pos[1]] == state[pos[2]]{
//                    statusLabel.text = "\(!activePlayer ? "X" : "O") wins!"
                    animatedTextChange(message: "\(!activePlayer ? "X" : "O") wins!")
                    gameEnds(combination: pos)
                    return
                }
            }
            var flag = true
            for i in state { if i == 0 { flag = false } }
            if flag {
//                statusLabel.text = "Draw!"
                animatedTextChange(message: "Draw!")
                gameEnds(combination: nil)
            }
        }
    }
    
    @IBAction func playAgainButtonPressed(_ sender: Any) {
//        statusLabel.text = "X turn!"
        playAgainButton.isEnabled = false
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseIn, animations: {
            self.boardButtons[0].alpha = 0.0
            self.boardButtons[1].alpha = 0.0
            self.boardButtons[2].alpha = 0.0
            self.boardButtons[3].alpha = 0.0
            self.boardButtons[4].alpha = 0.0
            self.boardButtons[5].alpha = 0.0
            self.boardButtons[6].alpha = 0.0
            self.boardButtons[7].alpha = 0.0
            self.boardButtons[8].alpha = 0.0
            self.playAgainButton.alpha = 0.0
            self.statusLabel.alpha = 0.0
            
        }, completion: { done in
            for button in self.boardButtons {
                button.setImage(UIImage(), for: UIControl.State())
                button.alpha = 1.0
            }
            self.animatedTextChange(message: "X turn!")
            self.activePlayer = true
            self.state = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        })
    }

    func gameEnds(combination: [Int]?){
        state = [9, 9, 9, 9, 9, 9, 9, 9, 9]
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
            self.playAgainButton.alpha = 1.0
        })
        playAgainButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButton.alpha = 0.0
        playAgainButton.isEnabled = false
        boardView.alpha = 0.0
        statusLabel.alpha = 0.0
        headerLabel.alpha = 0.0
        for button in boardButtons {
            button.isEnabled = false
        }
        statusLabel.text = "X turn!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0.7, options: .curveEaseOut, animations: {
            self.headerLabel.alpha = 1.0
        })
        UIView.animate(withDuration: 0.7, delay: 1.7, options: .curveEaseOut, animations: {
            self.statusLabel.alpha = 1.0
        })
        UIView.animate(withDuration: 0.8, delay: 2.4, options: .curveEaseOut, animations: {
            self.boardView.alpha = 1.0
        })
        for button in boardButtons {
            button.isEnabled = true
        }
    }
    
    func animatedTextChange(message: String){
        UIView.animate(withDuration: 0.45, animations: {
            self.statusLabel.alpha = 0.0
        })
        statusLabel.text = message
        UIView.animate(withDuration: 0.45, animations: {
            self.statusLabel.alpha = 1.0
        })
    }
}

