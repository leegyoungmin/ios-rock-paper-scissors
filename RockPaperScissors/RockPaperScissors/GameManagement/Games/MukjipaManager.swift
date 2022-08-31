//
//  MukjipaGameManager.swift
//  Created by Wonbi, 미니
//

protocol Mukjipable: Gameable where T: GameElement {
	var isUserTurn: Bool { get }
	var currentTurn: String { get }
	
	func fetchUserInput(_ turn: String) -> Int?
}

struct MukjipaManager: Mukjipable {
	typealias T = Mukjipa
	
    var isUserTurn: Bool = true
	
	var currentTurn: String {
		isUserTurn ? "사용자" : "컴퓨터"
	}
	
	func fetchUserInput(_ turn: String) -> Int? {
		print("[\(turn) 턴]", GameMessage.mukjipa, separator: " ", terminator: " : ")
		
		guard let inputValue = readLine(),
			  let inputNumber = Int(inputValue),
			  0...3 ~= inputNumber
		else {
			return nil
		}
		return inputNumber
	}
	
	mutating func printTurn(to result: GameState) {
		if result == .userWin || result == .computerWin {
			decideTurn(from: result)
			print(currentTurn + "의 턴입니다.")
		}
	}
	
	mutating func decideTurn(from result: GameState) {
		
		if result == .userWin {
			isUserTurn = true
		} else {
			isUserTurn = false
		}
	}
	
	func printWinner(from result: GameState) {
		if result == .draw {
			print(currentTurn + "의 승리!")
		}
	}
	
	mutating func startGame(from result: GameState) -> GameState {
		decideTurn(from: result)
		let userNumber = fetchUserInput(currentTurn)
		let userCard = generateUserCard(number: userNumber)
		let result = checkValidity(of: userCard)
		
		printTurn(to: result)
		printWinner(from: result)
		
		return result
	}
}

