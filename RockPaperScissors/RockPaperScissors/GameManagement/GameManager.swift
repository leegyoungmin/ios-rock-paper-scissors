//
//  GameManager.swift
//  Created by Wonbi, 미니
//

struct GameManager {
    private var rockPaperScissorsGame: Gamble
    private var mukjipaGame: Gamble
    
    init(_ rockPaperScissorsGame: Gamble, _ mukjipaGame: Gamble) {
        self.rockPaperScissorsGame = rockPaperScissorsGame
        self.mukjipaGame = mukjipaGame
    }
    
    mutating func startRockPaperScissors() {
        guard var rockPaperScissorsGame = rockPaperScissorsGame as? RockPaperScissorsManager else {
            return startRockPaperScissors()
        }
        
        let result = rockPaperScissorsGame.startGame(from: nil)
        
        print(result.description)
        
        switch result {
        case .draw, .error:
            startRockPaperScissors()
        case .exit:
            return
        case .computerWin, .userWin:
            startMukjipa(result)
        }
    }
    
    private mutating func startMukjipa(_ result: GameState) {
        
        guard var mukjipaGame = mukjipaGame as? MukjipaManager else {
            return
        }
        let result = mukjipaGame.startGame(from: result)
        
        switch result {
        case .draw:
            return
        case .exit:
            print(result.description)
            return
        case .error:
            print(result.description)
            startMukjipa(result)
        case .userWin, .computerWin:
            startMukjipa(result)
        }
    }
}
