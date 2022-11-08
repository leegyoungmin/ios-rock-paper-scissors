//
//  Gamble.swift
//  Created by Wonbi, 미니
//

protocol Gamble {
    mutating func startGame(from result: GameState?) -> GameState
    
    func fetchUserInput(_ turn: String?) -> Int?
    
    func generateUserCard<T: GameElement>(number: Int?) -> Result<T, InputError>
    func checkValidity<T: GameElement>(of userInputResult: Result<T, InputError>) -> GameState
}

extension Gamble {
    func checkValidity<T: GameElement>(of userInputResult: Result<T, InputError>) -> GameState {
        switch userInputResult {
        case .success(let inputCard):
            return inputCard.generateGameResult()
        case .failure:
            return .error
        }
    }
}

protocol RockPaperScissorAble: Gamble {}

extension RockPaperScissorAble {
    func fetchUserInput(_ turn: String? = nil) -> Int? {
        print(GameMessage.rockPaperScissors, terminator: " : ")
        
        guard let inputValue = readLine(),
              let inputNumber = Int(inputValue),
              0...3 ~= inputNumber
        else {
            return nil
        }
        
        return inputNumber
    }
    
    mutating func startGame(from result: GameState?) -> GameState {
        let userNumber = fetchUserInput(nil)
        let userCardResult: Result<RockPaperScissors, InputError> = generateUserCard(number: userNumber)
        let gameResult = checkValidity(of: userCardResult)
        return gameResult
    }
    
    func generateUserCard<T: GameElement>(number: Int?) -> Result<T, InputError> {
        guard let number,
              let userCard = RockPaperScissors(rawValue: number) as? T else {
            return .failure(.invalidNumber)
        }
        return .success(userCard)
        
    }
}

protocol MukjipaAble: Gamble {
    var currentTurn: String { get }
    
    mutating func printTurn(to result: GameState)
    mutating func decideTurn(from result: GameState)
    func printWinner(from result: GameState)
}

extension MukjipaAble {
    func fetchUserInput(_ turn: String?) -> Int? {
        guard let turn = turn else {
            return nil
        }
        
        print("[\(turn) 턴]", GameMessage.mukjipa, separator: " ", terminator: " : ")
        
        guard let inputValue = readLine(),
              let inputNumber = Int(inputValue),
              0...3 ~= inputNumber
        else {
            return nil
        }
        return inputNumber
    }
    
    mutating func startGame(from result: GameState?) -> GameState {
        guard let prevResult = result else {
            return .error
        }
        
        decideTurn(from: prevResult)
        let userNumber = fetchUserInput(currentTurn)
        let userCard: Result<Mukjipa, InputError> = generateUserCard(number: userNumber)
        let result = checkValidity(of: userCard)
        
        printTurn(to: result)
        printWinner(from: result)
        
        return result
    }
    
    func generateUserCard<T: GameElement>(number: Int?) -> Result<T, InputError> {
        guard let number,
              let userCard = Mukjipa(rawValue: number) as? T else {
            return .failure(.invalidNumber)
        }
        
        return .success(userCard)
    }
}
