//
//  RPSGameManager.swift
//  Created by Wonbi, 미니
//

protocol RockPaperScissorable: Gameable where T : GameElement {
	func fetchUserInput() -> Int?
	func startGame() -> GameState
}

struct RockPaperScissorsManager: RockPaperScissorable {
	typealias T = RockPaperScissors
	
	func fetchUserInput() -> Int? {
		print(GameMessage.rockPaperScissors, terminator: " : ")
		
		guard let inputValue = readLine(),
			  let inputNumber = Int(inputValue),
			  0...3 ~= inputNumber
		else {
			return nil
		}
		return inputNumber
	}
	
	func startGame() -> GameState {
		let userNumber = fetchUserInput()
		let userCardResult = generateUserCard(number: userNumber)
		let gameResult = checkValidity(of: userCardResult)
		return gameResult
	}
}
