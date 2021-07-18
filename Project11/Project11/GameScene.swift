//
//  GameScene.swift
//  Project11
//
//  Created by Thonatas Borges on 17/07/21.
//

import SpriteKit

enum BallColors: String, CaseIterable {
    case blue = "ballBlue"
    case cyan = "ballCyan"
    case green = "ballGreen"
    case gray = "ballGray"
    case purple = "ballPurple"
    case red = "ballRed"
    case yellow = "ballYellow"
}

class GameScene: SKScene, SKPhysicsContactDelegate {

    var scoreLabel: SKLabelNode!
    var editLabel: SKLabelNode!
    var ballsQuantityLabel:SKLabelNode!
    var restartLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    var ballsQuantity = 5 {
        didSet {
            ballsQuantityLabel.text = "Balls: \(ballsQuantity)"
        }
    }

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self

        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)

        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        ballsQuantityLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsQuantityLabel.text = "Balls: 5"
        ballsQuantityLabel.horizontalAlignmentMode = .right
        ballsQuantityLabel.position = CGPoint(x: 980, y: 650)
        addChild(ballsQuantityLabel)

        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.horizontalAlignmentMode = .left
        editLabel.position = CGPoint(x: 30, y: 700)
        addChild(editLabel)
        
        restartLabel = SKLabelNode(fontNamed: "Chalkduster")
        restartLabel.text = "Restart"
        restartLabel.horizontalAlignmentMode = .left
        restartLabel.position = CGPoint(x: 30, y: 650)
        restartLabel.isHidden = true
        addChild(restartLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            var location = touch.location(in: self)
            let objects = nodes(at: location)
            let ballColor: BallColors = BallColors.allCases.randomElement() ?? .red
            
            guard ballsQuantity != 0 || ballsQuantity < 0 else {
                ballsQuantityLabel.text = "End Game"
                restartLabel.isHidden = false
                
                if objects.contains(restartLabel) {
                    score = 0
                    editingMode = false
                    ballsQuantity = 5
                    restartLabel.isHidden = true
                }
                return
            }
            
            if objects.contains(editLabel) {
                editingMode = !editingMode
            } else {
                if editingMode {
                    let size = CGSize(width: Int.random(in: 16...128), height: 16)
                    let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                    box.zRotation = CGFloat.random(in: 0...3)
                    box.position = location
                    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                    box.physicsBody?.isDynamic = false
                    box.name = "box"
                    addChild(box)
                } else {
                    let ball = SKSpriteNode(imageNamed: ballColor.rawValue)
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                    ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                    ball.physicsBody?.restitution = 0.4
                    location.y = location.y <= 640 ? 640 : location.y
                    ball.position = location
                    ball.name = "ball"
                    addChild(ball)
                }
            }
        }
    }

    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }

    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode

        slotBase = SKSpriteNode(imageNamed: isGood ? "slotBaseGood" : "slotBaseBad")
        slotGlow = SKSpriteNode(imageNamed: isGood ? "slotGlowGood" : "slotGlowBad")
        slotBase.name = isGood ? "good" : "bad"

        slotBase.position = position
        slotGlow.position = position

        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false

        addChild(slotBase)
        addChild(slotGlow)

        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }

    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
            ballsQuantity = ballsQuantity >= 5 ? ballsQuantity : ballsQuantity + 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
            ballsQuantity -= 1
        } else if object.name == "box" {
            //detroy box
        }
    }

    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    }

    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
}
