//
//  FilaLoja.swift
//  More
//
//  Created by Lucca Marmion on 27/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit


class Letras: SKSpriteNode {
    
    var actionMoverInimigo : SKAction!
    var actionDeletarInimigo = SKAction.removeFromParent()
    

    
    
    let CollisionJogador     : UInt32 = 0x1 << 1
    let CollisionInimigo : UInt32 = 0x1 << 2
    
    init(size : CGSize, Letra: String)
    {
        super.init(texture: SKTexture(imageNamed: Letra), color: nil, size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 70, height: 70))
        self.physicsBody?.dynamic = false
        self.physicsBody!.categoryBitMask = CollisionInimigo
        self.physicsBody!.contactTestBitMask = CollisionJogador
        self.name = Letra
        
    }
    
    func runLetraAction(sizeY : CGFloat) {
        
        actionMoverInimigo = SKAction.moveByX(0, y: -790, duration: 10)

        
        var randomY = Int(arc4random_uniform(874)) + 50
        println("\(randomY)")
        
        
        
        self.position = CGPoint(x: CGFloat(randomY), y: 775)
        
        self.runAction(SKAction.sequence([actionMoverInimigo, actionDeletarInimigo]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}