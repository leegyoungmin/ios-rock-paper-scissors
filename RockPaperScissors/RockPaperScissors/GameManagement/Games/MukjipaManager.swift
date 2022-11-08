//
//  MukjipaGameManager.swift
//  Created by Wonbi, 미니
//

struct MukjipaManager: MukjipaAble {
    var isUserTurn: Bool = true
    
    var currentTurn: String  {
        isUserTurn ? "사용자" : "컴퓨터"
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
        let userCard: Result<Mukjipa, InputError> = generateUserCard(number: userNumber)
        let result = checkValidity(of: userCard)
        
        printTurn(to: result)
        printWinner(from: result)
        
        return result
    }
}

