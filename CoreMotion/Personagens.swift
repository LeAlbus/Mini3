//
//  Personagens.swift
//  CoreMotion
//
//  Created by Gabriela  Gomes Pires on 31/07/15.
//  Copyright (c) 2015 LuccaMarmion. All rights reserved.
//

import SpriteKit

class Personagens: SKScene{
    
    //Variaveis
    let fundoPersonagens = SKSpriteNode(imageNamed: "FundoComprar.png")
    let personagemBigodinho = SKSpriteNode (imageNamed: "BtnBigodinho.png")
    let personagemMiau = SKSpriteNode (imageNamed: "BtnMiau.png")
    let personagemAuau = SKSpriteNode (imageNamed: "BtnAuau.png")
    let personagemBolinha = SKSpriteNode (imageNamed: "BtnBolinha.png")
    var personagemSelecionado = SKSpriteNode()
    var som : Sons = Sons()
    
    //    var Auau = SKSpriteNode(imageNamed: "AuAu.png")
    //    var Miau = SKSpriteNode(imageNamed: "Miau.png")
    //    var Bigodinho = SKSpriteNode(imageNamed: "Bigodinho.png")
    //    var Bolinha = SKSpriteNode (imageNamed: "bolinha.png")
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var selecionou = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Caracteristicas da imagem de fundo.
        fundoPersonagens.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        fundoPersonagens.xScale = 0.5
        fundoPersonagens.yScale = 0.5
        
        //Personagens
        personagemBigodinho.position = CGPointMake(CGRectGetMidX(self.frame)+270,CGRectGetMidY(self.frame)+180)
        personagemBigodinho.xScale = 0.45
        personagemBigodinho.yScale = 0.45
        //personagemBigodinho.alpha = 0.3
        
        personagemMiau.position = CGPointMake(CGRectGetMidX(self.frame)+270,CGRectGetMidY(self.frame)-200)
        personagemMiau.xScale = 0.45
        personagemMiau.yScale = 0.45
        //personagemMiau.alpha = 0.3
        
        personagemAuau.position = CGPointMake(CGRectGetMidX(self.frame)-270,CGRectGetMidY(self.frame)-200)
        personagemAuau.xScale = 0.45
        personagemAuau.yScale = 0.45
        //personagemAuau.alpha = 1.0
        
        personagemBolinha.position = CGPointMake(CGRectGetMidX(self.frame)-270,CGRectGetMidY(self.frame)+180)
        personagemBolinha.xScale = 0.45
        personagemBolinha.yScale = 0.45
        //personagemBolinha.alpha = 0.3
        
        let name = defaults.integerForKey("personagem")
        
        if name == 0 {
            personagemAuau.setScale(0.55)
            personagemMiau.setScale(0.45)
            personagemBolinha.setScale(0.45)
            personagemBigodinho.setScale(0.45)
        }
        else if name == 1 {
            personagemAuau.setScale(0.45)
            personagemMiau.setScale(0.55)
            personagemBolinha.setScale(0.45)
            personagemBigodinho.setScale(0.45)
        }
        else if name == 2 {
            personagemAuau.setScale(0.45)
            personagemMiau.setScale(0.45)
            personagemBolinha.setScale(0.55)
            personagemBigodinho.setScale(0.45)
        }
        else if name == 3 {
            personagemAuau.setScale(0.45)
            personagemMiau.setScale(0.45)
            personagemBolinha.setScale(0.45)
            personagemBigodinho.setScale(0.55)
        }
        
        self.addChild(fundoPersonagens)
        self.addChild(personagemBigodinho)
        self.addChild(personagemMiau)
        self.addChild(personagemAuau)
        self.addChild(personagemBolinha)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        /* Called when a touch begins */
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        if (personagemAuau.containsPoint(touchLocation)){
            personagemAuau.setScale(0.55)
            personagemMiau.setScale(0.45)
            personagemBolinha.setScale(0.45)
            personagemBigodinho.setScale(0.45)
            selecionou = true
            defaults.setInteger(0, forKey: "personagem")
        }
        else if (personagemMiau.containsPoint(touchLocation)){
            personagemAuau.setScale(0.45)
            personagemMiau.setScale(0.55)
            personagemBolinha.setScale(0.45)
            personagemBigodinho.setScale(0.45)
            selecionou = true
            defaults.setInteger(1, forKey: "personagem")
        }
        else if (personagemBolinha.containsPoint(touchLocation)){
            personagemAuau.setScale(0.45)
            personagemMiau.setScale(0.45)
            personagemBolinha.setScale(0.55)
            personagemBigodinho.setScale(0.45)
            selecionou = true
            defaults.setInteger(2, forKey: "personagem")
        }
        else if (personagemBigodinho.containsPoint(touchLocation)){
            personagemAuau.setScale(0.45)
            personagemMiau.setScale(0.45)
            personagemBolinha.setScale(0.45)
            personagemBigodinho.setScale(0.55)
            selecionou = true
            defaults.setInteger(3, forKey: "personagem")
        }
        
        if selecionou{
            som.playAudioBotoesGeral()
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("chamaMenu"), userInfo: nil, repeats: false)
        }
    }
    
    func chamaMenu(){
        let transition = SKTransition()
        let cenarioMenu = Menu(size: self.size)
        cenarioMenu.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioMenu, transition: transition)
    }
    
    
}