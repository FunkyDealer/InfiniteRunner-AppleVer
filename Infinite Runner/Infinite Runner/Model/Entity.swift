//
//  Entity.swift
//  Infinite Runner
//
//  Created by intozoom on 5/22/21.
//

import Foundation
import GameplayKit
import SpriteKit

class Entity {
    
    var position : CGPoint
    var sprite : SKSpriteNode
    var anchor : CGPoint
    var scale : CGPoint
    var name : String
    
    var actions : [SKAction]

    init(pos : CGPoint, sprite : SKSpriteNode, scale : CGPoint, name : String) {
        self.position = pos
        self.sprite = sprite
        self.anchor = CGPoint(x: 0, y: 0)
        self.scale = scale
        self.name = name
        
        sprite.position = pos
        sprite.anchorPoint = self.anchor
        sprite.xScale = self.scale.x
        sprite.yScale = self.scale.y
        actions = []
    }
    
    init(pos : CGPoint, anchor : CGPoint, sprite : SKSpriteNode, scale : CGPoint, name : String) {
        self.position = pos
        self.sprite = sprite
        self.anchor = anchor
        self.name = name
        self.scale = scale
        
        sprite.position = pos
        sprite.anchorPoint = self.anchor
        sprite.xScale = self.scale.x
        sprite.yScale = self.scale.y
        actions = []
    }
    
    func update(_ deltaTime: CFTimeInterval)
    {
        
        
     
        updatePosition()
    }
    
    func addAction(action : SKAction) {
        actions.append(action)
        
    }
    
    func runAction(action : SKAction) {
        sprite.run(action)
    }
    
    
    func updatePosition() {
        self.sprite.position = self.position
        
        //print("x: \(self.position.x) y: \(self.position.y)"  )
    }
    
    
    func compareSprite(sprite : SKSpriteNode) -> Bool {
        if (self.sprite == sprite) { return true }
        else { return false }
    }
    
}
