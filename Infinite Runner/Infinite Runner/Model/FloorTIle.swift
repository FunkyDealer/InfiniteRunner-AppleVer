//
//  FloorTIle.swift
//  Infinite Runner
//
//  Created by intozoom on 6/5/21.
//

import Foundation
import GameplayKit
import SpriteKit

class FloorTIle : Entity {
    
    
    init(pos: CGPoint, sprite: SKSpriteNode, scale: CGPoint, name: String, floors : [FloorTIle])
    {
        super.init(pos: pos, sprite: sprite, scale: scale, name: name)
        
        
        self.position.x = CGFloat(0 + (floors.count * Int(sprite.size.width)))
        }
    
    init(pos: CGPoint, anchor: CGPoint, sprite: SKSpriteNode, scale: CGPoint, name: String, floors : [FloorTIle])
    {

        super.init(pos: pos, anchor: anchor, sprite: sprite, scale: scale, name: name)
        
        
        self.position.x = CGFloat(0 + (floors.count * Int(sprite.size.width)))
    }
    
    
    let dir = CGVector(dx: -1, dy: 0)
    
    func update(_ deltaTime: CFTimeInterval, gameScene : GameScene, speed : CGFloat)
    {
        
        self.position = self.position + (dir * speed) * 0.01;
        
        if (self.position.x < -sprite.size.width) {
            let count = CGFloat((gameScene.floors.count - 1))
            self.position.x = count * sprite.size.width
        }
        
     
        updatePosition()
    }
    
    
}
