//
//  GameManager.swift
//  Created by Wonbi, 미니
//

struct GameManager {
	private var rockPaperScissorsGame: RockPaperScissorsManager
	private var mukjipaGame: MukjipaManager
    
	init(
		_ rockPaperScissorsGame: RockPaperScissorsManager,
		_ mukjipaGame: MukjipaManager
	) {
        self.rockPaperScissorsGame = rockPaperScissorsGame
        self.mukjipaGame = mukjipaGame
    }
    
	mutating func startRockPaperScissors() {
        let result = rockPaperScissorsGame.startGame()
        
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
