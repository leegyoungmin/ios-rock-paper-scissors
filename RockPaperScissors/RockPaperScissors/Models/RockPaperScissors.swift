//
//  RockPaperScissors.swift
//  Created by Wonbi, 미니
//

enum RockPaperScissors: Int, RockPaperScissorsElement {
    case none = 0
    case scissors = 1
    case rock = 2
    case paper = 3
        
    func generateComputerCard() -> Self {
        let computerCard = Self.allCases[chooseComputerNumber(between: 1, and: 3)]
        return computerCard
    }
    
    func compare(to computerCard: Self) -> GameState {
        guard self != .none else { return .exit }
        
        let userNumber = self.rawValue
        let computerNumber = computerCard.rawValue
        let comparedResultNumber = userNumber - computerNumber
        
        switch comparedResultNumber {
        case -2, 1:
            return .userWin
        case -1, 2:
            return .computerWin
        default:
            return .draw
        }
    }
    
    func generateGameResult() -> GameState {
        let computerCard = generateComputerCard()
        return self.compare(to: computerCard)
    }
}
