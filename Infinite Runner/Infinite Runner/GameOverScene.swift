//
//  GameOverScene.swift
//  Infinite Runner
//
//  Created by intozoom on 6/14/21.
//

import Foundation
import SpriteKit
import GameplayKit


class GameOverScene : SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    private var gameScene : SKScene! = nil
    private var transition : SKTransition = SKTransition.fade(withDuration: 1)
    private var button : SKNode! = nil
    
    
    
    
    override func didMove(to view: SKView)
    {
        //Text
        createTittleText()
        createButton()
        
        
        //GameScene for button
        gameScene = GameScene(size: size)
        
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        

        
    }
    
    override func update(_ deltaTime: CFTimeInterval)
    {
        // Called before each frame is rendered

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Loop over all touches in this event
        for touch in touches {
            //get the location of the touch in this scene
            let location = touch.location(in: self)
            //check if the location of the touch is within the button's bounds
            if button.contains(location) {
                ChangeToGameScene()
            }
        }
    }
    
    func ChangeToGameScene() {
        
        
        self.view?.presentScene(gameScene, transition: transition)
    }
    
    func createTittleText() {
        let gameOverText = SKLabelNode(fontNamed: "ChalkDuster")
        gameOverText.text = "Game Over!"
        gameOverText.fontSize = 65
        gameOverText.fontColor = SKColor.red
        gameOverText.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(gameOverText)
    }
    
    func createButton() {
        let text = SKLabelNode(fontNamed: "Arial")
        text.text = "Restart"
        text.fontSize = 20
        text.fontColor = SKColor.green
        text.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 60)
        addChild(text)
        
        //Create a red rectangle
        button = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 44))
        //Put it in the center of the scene
        button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 50)
        addChild(button)
    }
    
}
