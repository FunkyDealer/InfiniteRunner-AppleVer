//
//  GameScene.swift
//  Infinite Runner
//
//  Created by intozoom on 5/22/21.
//

import SpriteKit
import GameplayKit

class GameScene : SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var floors : [FloorTIle] = []
    var collectables : [Collectable] = []
    
    var player = Player(pos: CGPoint(x: 60, y: 100), sprite: SKSpriteNode(imageNamed: "player"), scale: CGPoint(x: 0.5, y: 0.5), name: "Player")
    
    var thirstBar = ThirstBar(pos: CGPoint(x: 300, y: 100), anchor: CGPoint(x: 0.5, y: 0), sprite: SKSpriteNode(imageNamed: "Points1"), scale: CGPoint(x: 100, y: 1), name: "ThirstBar")
    
    private var gameOverScene : SKScene! = nil
    private var transition : SKTransition = SKTransition.fade(withDuration: 1)
    private var button : SKNode! = nil
    
    override func didMove(to view: SKView)
    {
        backgroundColor = SKColor.black
        
        addChild(thirstBar.sprite)
        addChild(player.sprite)
        
        createButton()
        
        gameOverScene = GameOverScene(size: size)
        
        player.setUp(scene: self)
        thirstBar.setPosition(pos: CGPoint(x: 50, y: size.height - 50))
        
        createSpinnies()
        
        for _ in 0...10 {
            addFloor()
        }
        
        let CollectableSpawnAction = SKAction.sequence([SKAction.run(addCollectable), SKAction.wait(forDuration: 3.0)])
        
        run(SKAction.repeatForever(CollectableSpawnAction))

        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ deltaTime: CFTimeInterval)
    {
        // Called before each frame is rendered
        
        player.update(deltaTime,scene: self)
        thirstBar.update(deltaTime, player: player)
        
        for f in floors {
            f.update(deltaTime, gameScene: self,speed: player.speed)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody
        var secondBody : SKPhysicsBody
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if ((firstBody.categoryBitMask & GameManager.PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & GameManager.PhysicsCategory.Collectible != 0)) {
            if let playerSprite = firstBody.node as? SKSpriteNode,
               let collectableSprite = secondBody.node as? SKSpriteNode {
                
                var col : Collectable
                col = collectables[0]
                for c in collectables {
                    if (c.compareSprite(sprite: collectableSprite)) {
                        col = c
                    }
                }
                
                player.GetCollectable(collectable: col)
                thirstBar.updateScale(player: player)
                col.sprite.removeFromParent()
                
                print("Player's thirst: \(player.thirst)")
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        player.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Loop over all touches in this event
        for touch in touches {
            //get the location of the touch in this scene
            let location = touch.location(in: self)
            //check if the location of the touch is within the button's bounds
            if button.contains(location) {
                ChangeToGameOverScene()
            }
        }
        
        player.touchesEnded(touches, with: event)
    }
    
    func addCollectable()
    {
        let y = CGFloat.random(in: floors[0].sprite.size.height...size.height - floors[0].sprite.size.height)
        
        let t = CGFloat.random(in: 0...100)
        
        var c : Collectable
        
        if (t < 30) {
            c = Sugar(pos: CGPoint(x: size.width + 100, y: y), anchor: CGPoint(x: 0.5, y: 0.5), sprite: SKSpriteNode(imageNamed: "Danger1"), scale: CGPoint(x: 1, y: 1), name: "Points", direction: CGVector(dx: 1, dy: 0), speed: player.speed)
        }else {
            c = Refreshment(pos: CGPoint(x: size.width + 100, y: y), anchor: CGPoint(x: 0.5, y: 0.5), sprite: SKSpriteNode(imageNamed: "Points1"), scale: CGPoint(x: 1, y: 1), name: "Points", direction: CGVector(dx: 1, dy: 0), speed: player.speed)
        }
               
        collectables.append(c)
        
        addChild(c.sprite)
    }
    
    func addFloor()
    {
        let f = FloorTIle(pos: CGPoint(x: 0 , y: 0), sprite: SKSpriteNode(imageNamed: "Floor1"), scale: CGPoint(x: 0.5, y: 0.5), name: "floor", floors: floors)
        
        floors.append(f)
        
        addChild(f.sprite)
    }
    
    func ChangeToGameOverScene() {
        
        
        self.view?.presentScene(gameOverScene, transition: transition)
    }
    
    
    func createButton() {
        let text = SKLabelNode(fontNamed: "Arial")
        text.text = "gameOver"
        text.fontSize = 10
        text.fontColor = SKColor.green
        text.position = CGPoint(x: size.width - 50, y: size.height - 50)
        addChild(text)
        
        //Create a red rectangle
        button = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 22))
        //Put it in the center of the scene
        button.position = CGPoint(x: size.width - 50, y: size.height - 50)
        addChild(button)
    }
    
    func createSpinnies() {
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

}
