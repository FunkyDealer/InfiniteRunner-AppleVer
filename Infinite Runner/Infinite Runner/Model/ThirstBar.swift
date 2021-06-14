//
//  ThirstBar.swift
//  Infinite Runner
//
//  Created by intozoom on 6/13/21.
//

import Foundation
import GameplayKit
import SpriteKit

class ThirstBar : Entity {
    
    var currentSize = 100
    
    override init(pos : CGPoint, sprite : SKSpriteNode, scale : CGPoint, name : String) {
        
        super.init(pos: pos, sprite: sprite, scale: scale, name: name)
        
        setUpThirdBar()
    }
    
    override init(pos : CGPoint, anchor : CGPoint, sprite : SKSpriteNode, scale : CGPoint, name : String) {
        
        super.init(pos: pos, anchor: anchor, sprite: sprite, scale: scale, name: name)
        setUpThirdBar()
    }
    
    func setUpThirdBar() {
        
        scale = CGPoint(x: 30, y: 1)
        
        sprite.xScale = self.scale.x
    }
    
    func setPosition(pos : CGPoint) {
        position = pos
        sprite.position = pos
    }
    
    func update(_ deltaTime: CFTimeInterval, player : Player) {
        
        updateScale(player: player)
        
    }
    
    func updateScale(player : Player) {
        //100 - 30
        //y - x
        //y * 30 / 100
        
        scale.x = CGFloat(player.thirst * 30 / 100)
        
        updatePosition()
    }
    
    
    override func updatePosition() {
        sprite.position = position
        sprite.xScale = scale.x
        sprite.yScale = scale.y
        
    }
    
}
