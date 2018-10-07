//
//  GameScene.swift
//  Game-Starter-Empty
//
//  Created by mitchell hudson on 9/13/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import SpriteKit
import GameplayKit

enum GameState {
    case title, playing, gameOver
}

class GameScene: SKScene {
    
    var state: GameState = .title
    
    var createSquare: Square = Square()
    
    var onScreen: Bool = false
    var scoreLabel: SKLabelNode!
    var gameOver: SKLabelNode!
    var score: Int = 0
    var miss: Int = 0
    var play: SKLabelNode!
    
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
  
    override func didMove(to view: SKView) {
        // Called when the scene has been displayed

        scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.text = "Score: 0"
        scoreLabel.fontColor = .white
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: screenWidth / 2, y: screenHeight - 60)
        addChild(scoreLabel)

        gameOver = SKLabelNode(fontNamed: "Helvetica")
        gameOver.text = "Game Over"
        gameOver.fontColor = .white
        gameOver.horizontalAlignmentMode = .center
        gameOver.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
        addChild(gameOver)
        gameOver.name = "gameOver"
        gameOver.isHidden = true
        
        
        play = SKLabelNode(fontNamed: "Helvetica")
        play.text = "Play"
        play.fontColor = .white
        play.horizontalAlignmentMode = .center
        play.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
        addChild(play)
        play.name = "play"
        play.isHidden = false
       
        
        
        
    }
    
  
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        scoreLabel.text = "Score: \(score)"
        if state == .title {
            play.isHidden = false
            gameOver.isHidden = true
        } else if state == .playing {
            play.isHidden = true
            gameOver.isHidden = true
            if miss >= 5 {
                gameOver.isHidden = false
                state = .gameOver
                createSquare.miss = 0
                miss = createSquare.miss
                state = .gameOver
                createSquare.removeFromParent()
            }
        } else if state == .gameOver {
            play.isHidden = true
            gameOver.isHidden = false
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let touchLocation = touch.location(in: self)
            let node = atPoint(touchLocation)
            if node.name == "square" {
                // Do something
                let remove = SKAction.removeFromParent()
                node.run(remove)
                score += 1
            } else if node.name == "play" {
                play.isHidden = true
                gameOver.isHidden = true
                score = 0
                createSquare.miss = 0
                miss = createSquare.miss
                state = .playing
                addChild(createSquare)
                let action = SKAction.run {
                    self.createSquare.createSquare()
                    self.miss = self.createSquare.miss
                }
                let wait = SKAction.wait(forDuration: 1)
                let seq = SKAction.sequence([action, wait])
                let repeatForEver = SKAction.repeatForever(seq)
                
                self.run(repeatForEver)
                
            } else if node.name == "gameOver" {
                state = .title
                createSquare.removeFromParent()
                goToGameScene()
            }
            
        }
    }
    
    func goToGameScene(){
        let gameScene:GameScene = GameScene(size: self.view!.bounds.size) // create your new scene
        let transition = SKTransition.fade(withDuration: 1.0) // create type of transition (you can check in documentation for more transtions)
        gameScene.scaleMode = SKSceneScaleMode.fill
        self.view!.presentScene(gameScene, transition: transition)
    }
}
