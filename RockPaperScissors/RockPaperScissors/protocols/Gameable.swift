//
//  Gameable.swift
//  Created by Wonbi, 미니
//

protocol Gameable {
    associatedtype T
	
	func generateUserCard(number: Int?) -> Result<T,InputError>
	func checkValidity(of userInputResult: Result<T, InputError>) -> GameState
}

extension Gameable where T: GameElement {
	func checkValidity(of userInputResult: Result<T, InputError>) -> GameState {
		switch userInputResult {
		case .success(let inputCard):
			return inputCard.generateGameResult()
		case .failure:
			return .error
		}
	}
}

extension Gameable where T == Mukjipa {
	func generateUserCard(number: Int?) -> Result<T, InputError> {
		guard let number = number,
			  let userCard = Mukjipa(rawValue: number) else {
			return .failure(.invalidNumber)
		}
		
		return .success(userCard)
	}
}

extension Gameable where T == RockPaperScissors {
	func generateUserCard(number: Int?) -> Result<T, InputError> {
		guard let number = number,
			  let userCard = RockPaperScissors(rawValue: number) else {
			return .failure(.invalidNumber)
		}
		
		return .success(userCard)
	}
}
