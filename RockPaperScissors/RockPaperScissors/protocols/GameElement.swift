//
//  GameElement.swift
//  Created by Wonbi, 미니
//

protocol GameElement: CaseIterable {
    func chooseComputerNumber(between min: Int, and max: Int) -> Int
    func generateComputerCard() -> Self
    func generateGameResult() -> GameState
    func compare(to computerCard: Self) -> GameState
}

extension GameElement {
    func chooseComputerNumber(between min: Int, and max: Int) -> Int {
        let choiceNumber = Int.random(in: min...max)
        return choiceNumber
    }
}

protocol RockPaperScissorsElement: GameElement, CaseIterable { }

protocol MukjipaElement: GameElement, CaseIterable { }
