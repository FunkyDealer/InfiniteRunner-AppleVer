//
//  Refreshmente.swift
//  Infinite Runner
//
//  Created by intozoom on 6/13/21.
//

import Foundation
import GameplayKit
import SpriteKit

class Refreshment : Collectable {
    
    override init(pos: CGPoint, sprite: SKSpriteNode, scale : CGPoint, name: String, direction : CGVector,
         speed : CGFloat) {
        super.init(pos: pos, sprite: sprite, scale: scale, name: name, direction: direction, speed: speed)
        
        
        ammount = 5
    }
    
    override init(pos: CGPoint, anchor: CGPoint, sprite: SKSpriteNode, scale : CGPoint, name: String, direction : CGVector, speed : CGFloat) {
        super.init(pos: pos, anchor: anchor, sprite: sprite, scale: scale, name: name, direction: direction, speed: speed)
        
        
        ammount = 5
    }
    
    
    
}
