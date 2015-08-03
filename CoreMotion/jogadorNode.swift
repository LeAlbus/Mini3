//
//  FilaLoja.swift
//  More
//
//  Created by Lucca Marmion on 27/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit


class jogadorNode: SKSpriteNode {
    
    let CollisionJogador     : UInt32 = 0x1 << 1
    let CollisionInimigo : UInt32 = 0x1 << 2
    
    init(size : CGSize, personagem: String)
    {
        super.init(texture: SKTexture(imageNamed:personagem), color: nil, size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 50, height: 50))
        self.physicsBody!.dynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody!.categoryBitMask = CollisionJogador
        self.physicsBody!.contactTestBitMask = CollisionInimigo
        self.name = personagem
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}