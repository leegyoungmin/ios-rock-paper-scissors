//
//  RockPaperScissors - main.swift
//  Created by Wonbi, 미니
//

var rockPaperScissorsManager: Gamble = RockPaperScissorsManager()
var mukjipaScissorsManager: Gamble = MukjipaManager()
var game = GameManager(rockPaperScissorsManager, mukjipaScissorsManager)

game.startRockPaperScissors()
