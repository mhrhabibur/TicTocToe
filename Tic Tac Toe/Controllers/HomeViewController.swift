//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Habibur Rahman on 10/24/24.
//

import UIKit

enum Turn {
    case Nought
    case Cross
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    var firstTurn: Turn = .Cross
    var currentTurn: Turn = .Cross
    let NOUGHT = "O"
    let CROSS = "X"
    var board: [UIButton] = []
    var crossWins: Int = 0
    var noughtWins: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "X = \(crossWins) | O = \(noughtWins)"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Change Turn",
            style: .plain,
            target: self,
            action: #selector(changeTurn)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Reset",
            style: .plain,
            target: self,
            action: #selector(resetGame)
        )
        
        initBoard()
        navigationItem.leftBarButtonItem?.isHidden = false
        turnLabel.isHidden = false
        displayLabel.isHidden = false
    }
    
    // MARK: Board Init
    
    private func initBoard() {
        board = [button1, button2, button3, button4, button5, button6, button7, button8, button9]
    }
    
    // MARK: Reset Board
    
    private func resetBoard() {
        self.firstTurn = .Cross
        self.currentTurn = .Cross
        self.turnLabel.text = self.CROSS
        board.forEach { $0.setTitle(nil, for: .normal) }
        navigationItem.leftBarButtonItem?.isHidden = false
        turnLabel.isHidden = false
        displayLabel.isHidden = false
    }
    
    // MARK: Reset Game
    
    @objc func resetGame() {
        let alert = UIAlertController(
            title: "Reset Game",
            message: "Are you sure you want to reset the game?",
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.firstTurn = .Cross
            self.currentTurn = .Cross
            self.turnLabel.text = self.CROSS
            self.resetBoard()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        turnLabel.isHidden = false
        displayLabel.isHidden = false
    }
    
    // MARK: Check Board If it is Full or not
    
    private func isBoardFull() -> Bool {
        return board.allSatisfy{$0.title(for: .normal) != nil}
    }
    
    // MARK: Check Board If it is Full or not
    private func isBoardEmpty() -> Bool {
        return board.allSatisfy{$0.title(for: .normal) == nil}
    }
    
    // MARK: Check For Victory
    
    private func checkForVictory(_ symbol: String) -> Bool {
        if checkSymbol(button1, symbol) && checkSymbol(button2, symbol) && checkSymbol(button3, symbol) {
            return true
        }
        if checkSymbol(button4, symbol) && checkSymbol(button5, symbol) && checkSymbol(button6, symbol) {
            return true
        }
        if checkSymbol(button7, symbol) && checkSymbol(button8, symbol) && checkSymbol(button9, symbol) {
            return true
        }
        if checkSymbol(button1, symbol) && checkSymbol(button4, symbol) && checkSymbol(button7, symbol) {
            return true
        }
        if checkSymbol(button2, symbol) && checkSymbol(button5, symbol) && checkSymbol(button8, symbol) {
            return true
        }
        if checkSymbol(button3, symbol) && checkSymbol(button6, symbol) && checkSymbol(button9, symbol) {
            return true
        }
        if checkSymbol(button1, symbol) && checkSymbol(button5, symbol) && checkSymbol(button9, symbol) {
            return true
        }
        if checkSymbol(button3, symbol) && checkSymbol(button5, symbol) && checkSymbol(button7, symbol) {
            return true
        }
        return false
    }
    
    func checkSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    // MARK: Reset Alert
    
    private func resultAlert(result: String) {
        let alert = UIAlertController(
            title: "Game Over",
            message: "\(result)",
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert
            .addAction(
                UIAlertAction( 
                    title: "Play Again",
                    style: .default,
                    handler: { _ in
                        self.resetBoard()
                    }
                )
            )
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Button Tapped
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        addToBoard(sender)
        if isBoardFull() {
            turnLabel.isHidden = true
            displayLabel.isHidden = true
            resultAlert(result: "Draw!")
        }
        if checkForVictory("X") {
            crossWins += 1
            turnLabel.isHidden = true
            displayLabel.isHidden = true
            resultAlert(result: "X wins!")
        }
        
        if checkForVictory("O") {
            noughtWins += 1
            turnLabel.isHidden = true
            displayLabel.isHidden = true
            resultAlert(result: "O wins!")
        }
        navigationItem.title = "X = \(crossWins) | O = \(noughtWins)"
        navigationItem.leftBarButtonItem?.isHidden = true
    }
    
    // MARK: Add To Board
    
    private func addToBoard(_ sender: UIButton) {
        if (sender.title(for: .normal) == nil) {
            if (currentTurn == .Nought) {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = .Cross
                turnLabel.text = CROSS
            } else if (currentTurn == .Cross) {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = .Nought
                turnLabel.text = NOUGHT
            }
        }
    }
    
    // MARK: Chnage Turn
    
    @objc func changeTurn() {
        if isBoardEmpty() {
            if currentTurn == .Cross {
                currentTurn = .Nought
                self.turnLabel.text = self.NOUGHT
            } else if currentTurn == .Nought{
                currentTurn = .Cross
                self.turnLabel.text = self.CROSS
            }
        }
    }
    
}

