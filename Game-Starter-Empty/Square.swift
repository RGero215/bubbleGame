//
//  Square.swift
//  Game-Starter-Empty
//
//  Created by Ramon Geronimo on 10/6/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import SpriteKit

class Square: SKSpriteNode {
    // Screen width.
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Screen height.
    private var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var miss: Int = 0
    
    
    /* You are required to implement this for your subclass to work */
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let squareSize = CGSize(width: 60, height: 60)
        super.init(texture: texture, color: color, size: squareSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSquare() {
        let random = arc4random_uniform(UInt32(self.screenWidth))
        let centerX: CGFloat = CGFloat(random)
        
        let centerY: CGFloat = -15
        
        let square = SKSpriteNode(texture: nil, color: .green, size: size)
        square.position.x = centerX
        square.position.y = centerY
        square.name = "square"
        
        
        let moveUp = SKAction.moveBy(x: 0.0, y: self.screenHeight, duration: 1.0)
        let disappear = SKAction.removeFromParent()
        let miss = SKAction.run {
            self.miss += 1
        }
        
        let seq = SKAction.sequence([moveUp, disappear, miss])
        square.run(seq)
        addChild(square)
    }
    
}
