//
//  Player.swift
//  Infinite Runner
//
//  Created by intozoom on 6/5/21.
//

import Foundation
import GameplayKit
import SpriteKit

class Player : Entity {
    
    private var maxX : CGFloat = 0
    private var minX : CGFloat = 0
    private var maxY : CGFloat = 0
    private var minY : CGFloat = 0
    
    var speed : CGFloat = 60
    
    var nextPos = CGVector(dx: 0, dy: 0)
    var jumpForce = CGVector(dx: 0, dy: 0)
    var jumpSpeed = CGFloat(200)
    
    var jumpTimer = 0.0
    var jumping : Bool = false
    var doubleJumping : Bool = false
    var landed : Bool = false
    var falling : Bool = true
    var doubleJumps : Int = 0
    var maxDoubleJumps = 1
    var startingPos = CGVector(dx: 0, dy: 0)

    
    var direction = CGVector(dx: 0, dy: 0)
    
    var thirst : Int = 100
    var thirstTimer = 0.0
    var thirstTime = 1.0
    var thirstValueDecrease : Int = 2
    
    var scene : GameScene?

    
    override init(pos: CGPoint, sprite: SKSpriteNode, scale: CGPoint, name: String) {
        
        super.init(pos: pos, sprite: sprite, scale: scale, name: name)
 
        setUpPhysics()
        
        setUpPlayer()
    }    
    
    override init(pos: CGPoint, anchor: CGPoint, sprite: SKSpriteNode, scale: CGPoint, name: String) {
        
        super.init(pos: pos, anchor: anchor, sprite: sprite, scale: scale, name: name)

        setUpPhysics()
        
        setUpPlayer()
        
    }
    
    func setUpPlayer()  {
        thirst = 100
    }
    
    
    func setUpPhysics() {
        
        //center of the sprite
        let centerPoint = CGPoint(x: sprite.size.width / 2 - (sprite.size.width * sprite.anchorPoint.x), y: sprite.size.height / 2 - (sprite.size.height * sprite.anchorPoint.y))
        
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size, center: centerPoint)
        sprite.physicsBody?.isDynamic = true
        sprite.physicsBody?.categoryBitMask = GameManager.PhysicsCategory.Player
        sprite.physicsBody?.contactTestBitMask = GameManager.PhysicsCategory.Collectible
        sprite.physicsBody?.collisionBitMask = GameManager.PhysicsCategory.none
    }
    
    func setUp(scene : GameScene) {        
        maxY = scene.size.height
        maxX = scene.size.width
        self.scene = scene
        
    }
    
    func update(_ deltaTime: CFTimeInterval, scene : GameScene)
    {
        direction = CGVector(dx: 0, dy: 0)
        
        direction = direction + (GameManager.gravity + jumpForce)
        direction = direction.Normalize()

        nextPos = CGVector(point: position + direction * jumpSpeed * 0.01)
        
        if (nextPos.dy > (scene.floors[0].sprite.size.height)) //Check if nextPos is not inside the floor
        {
            position = CGPoint(v: nextPos)
        } else {
            if (!landed) {
            falling = false
            doubleJumps = 0
            jumpTimer = 0.0
            landed = true
            print("Landed")
            }
        }
        
        if (position.y > maxY - sprite.size.height) { position.y = maxY - sprite.size.height }
        if (position.x < minX) { position.x = minX }
        if (position.x + sprite.size.width > maxX ) { position.x = maxX - sprite.size.width }
        
        //Jumping logic
        if (jumping) { //Jump
            jumpTimer += 0.01
            if (jumpTimer > 0.5) { //you can jump for 0.5f secs max
                falling = true
                jumping = false
                jumpForce = CGVector(dx: 0, dy: 0)
            }
        }
        if (doubleJumping) {
            jumpTimer += 0.01
            if (jumpTimer > 0.4) { //you can double jump for 0.3f secs max
                falling = true
                jumping = false
                jumpForce = CGVector(dx: 0, dy: 0)
            }
            
            //jumpForce = jumpForce + CGVector(dx: 0, dy: -1)
        }
        
        //Thirst Logic
        if (thirstTimer < thirstTime) { thirstTimer += 0.01 }
        else {
            thirstTimer = 0.0
            if (thirst - thirstValueDecrease > 0) { thirst -= thirstValueDecrease }
                else { thirst = 0 }
        }
        
        if (thirst == 0) {
            scene.ChangeToGameOverScene()
        }
     
        updatePosition()
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (landed) {
            jumping = true
            landed = false
            jumpForce = GameManager.gravity * -2.0
            print("Jump start")
        }
       if (!landed && !jumping && !doubleJumping && (doubleJumps < maxDoubleJumps)) {
            print("Double Jump Start")
            doubleJumping = true
            falling = false
            jumpForce = GameManager.gravity * -2.0
            doubleJumps += 1
        }
        
    }
    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if (!doubleJumping) {
        jumping = false
        doubleJumping = false
        falling = true
        jumpForce = CGVector(dx: 0 ,dy: 0)
        
        jumpTimer = 0.0
    }
    
    func GetCollectable(collectable : Collectable) {
        
        if (collectable is Sugar) {
            if (thirst - collectable.ammount > 0) { thirst -= collectable.ammount }
            else {thirst = 0}
            
            
        }
        else if (collectable is Refreshment)
        {
            if (thirst + collectable.ammount < 100) { thirst += collectable.ammount }
            else { thirst = 100 }
        }
        
    }
    
}
