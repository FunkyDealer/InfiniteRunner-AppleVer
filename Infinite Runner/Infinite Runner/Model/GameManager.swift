//
//  GameManager.swift
//  Infinite Runner
//
//  Created by intozoom on 6/5/21.
//

import Foundation
import GameplayKit
import SpriteKit


class GameManager {
    var player : Player?
    //var scene : GameScene
    
    static var gravity : CGVector = CGVector(dx: 0, dy: -5) //Global Gravity Value
    
    struct PhysicsCategory {
        static let none : UInt32 = 0
        static let all : UInt32 = UInt32.max
        static let Player : UInt32 = 0b1 //1
        static let Collectible : UInt32 = 0b10 //2
    }
    
    init() {

    }
    
    
    
}
