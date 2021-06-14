//
//  Collectable.swift
//  Infinite Runner
//
//  Created by intozoom on 6/5/21.
//

import Foundation
import GameplayKit
import SpriteKit


class Collectable : Entity {
    
    var exists : Bool
    var direction : CGVector
    
    let speed : CGFloat
    
    var ammount : Int = 10
    
    init(pos: CGPoint, sprite: SKSpriteNode, scale : CGPoint, name: String, direction : CGVector,
         speed : CGFloat) {
        self.exists = true
        self.direction = direction
        
        self.speed = speed
        
        super.init(pos: pos, sprite: sprite, scale: scale, name: name)
        setUpPhysics()
        
        setActions()
    
    }
    
    init(pos: CGPoint, anchor: CGPoint, sprite: SKSpriteNode, scale : CGPoint, name: String, direction : CGVector, speed : CGFloat) {
        self.exists = true
        self.direction = direction
        
        self.speed = speed
        
        super.init(pos: pos, anchor: anchor, sprite: sprite, scale: scale, name: name)
        setUpPhysics()
        
        setActions()
    }
    
    func setUpPhysics() {
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        sprite.physicsBody?.isDynamic = true
        sprite.physicsBody?.categoryBitMask = GameManager.PhysicsCategory.Collectible
        sprite.physicsBody?.contactTestBitMask = GameManager.PhysicsCategory.Player
        sprite.physicsBody?.collisionBitMask = GameManager.PhysicsCategory.none
    }
    
    func setActions() {
        
        let point = CGPoint(x: -100, y: position.y)
        let distance = self.position.x - point.x
        let time = Double((distance / speed))
        
        
        let actionMove = SKAction.move(to: point, duration: time)
        let remove = SKAction.removeFromParent() //"remove self" action
        
        let sequence = SKAction.sequence([actionMove, remove]) //Sequence of "move to point" -> "remove self"
        self.sprite.run(sequence)
        
    }
    
    
    override func update(_ deltaTime: CFTimeInterval) {
        
        
        
        updatePosition()
    }
    
    
}
