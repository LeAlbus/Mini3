//
//  Loja.swift
//  CoreMotion
//
//  Created by Gabriela  Gomes Pires on 31/07/15.
//  Copyright (c) 2015 LuccaMarmion. All rights reserved.
//

import SpriteKit

class Loja: SKScene{
    let fundoLoja = SKSpriteNode(imageNamed: "FundoComprar.png")
    let fundoJogo1 = SKSpriteNode(imageNamed: "BtnFundo2.png")
    let fundoJogo2 = SKSpriteNode(imageNamed: "BtnFundo4.png")
    let fundoJogo3 = SKSpriteNode (imageNamed: "BtnFundo3.png")
    let fundoJogo4 = SKSpriteNode (imageNamed: "BtnFundo1.png")
    var som : Sons = Sons()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var selecionou = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Caracteristicas da imagem de fundo.
        fundoLoja.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        fundoLoja.xScale = 0.5
        fundoLoja.yScale = 0.5
        
        fundoJogo1.position = CGPointMake(CGRectGetMidX(self.frame)+270,CGRectGetMidY(self.frame)+180)
        fundoJogo1.xScale = 0.45
        fundoJogo1.yScale = 0.45
        
        fundoJogo2.position = CGPointMake(CGRectGetMidX(self.frame)+270,CGRectGetMidY(self.frame)-200)
        fundoJogo2.xScale = 0.45
        fundoJogo2.yScale = 0.45
        
        fundoJogo3.position = CGPointMake(CGRectGetMidX(self.frame)-270,CGRectGetMidY(self.frame)-200)
        fundoJogo3.xScale = 0.45
        fundoJogo3.yScale = 0.45
        
        fundoJogo4.position = CGPointMake(CGRectGetMidX(self.frame)-270,CGRectGetMidY(self.frame)+180)
        fundoJogo4.xScale = 0.45
        fundoJogo4.yScale = 0.45
        
        let fundo = defaults.integerForKey("fundoEscolhido")
        
        if fundo == 0 {
            fundoJogo1.setScale(0.55)
            fundoJogo2.setScale(0.45)
            fundoJogo3.setScale(0.45)
            fundoJogo4.setScale(0.45)
        }
        else if fundo == 1 {
            fundoJogo1.setScale(0.45)
            fundoJogo2.setScale(0.55)
            fundoJogo3.setScale(0.45)
            fundoJogo4.setScale(0.45)
        }
        else if fundo == 2 {
            fundoJogo1.setScale(0.45)
            fundoJogo2.setScale(0.45)
            fundoJogo3.setScale(0.55)
            fundoJogo4.setScale(0.45)
        }
        else if fundo == 3 {
            fundoJogo1.setScale(0.45)
            fundoJogo2.setScale(0.45)
            fundoJogo3.setScale(0.45)
            fundoJogo4.setScale(0.55)
        }
        
        self.addChild(fundoLoja)
        self.addChild(fundoJogo1)
        self.addChild(fundoJogo2)
        self.addChild(fundoJogo3)
        self.addChild(fundoJogo4)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        /* Called when a touch begins */
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        if (fundoJogo1.containsPoint(touchLocation)){
            fundoJogo1.setScale(0.55)
            fundoJogo2.setScale(0.45)
            fundoJogo3.setScale(0.45)
            fundoJogo4.setScale(0.45)
            selecionou = true
            defaults.setInteger(0, forKey: "fundoEscolhido")
        }
        else if (fundoJogo2.containsPoint(touchLocation)){
            fundoJogo1.setScale(0.45)
            fundoJogo2.setScale(0.55)
            fundoJogo3.setScale(0.45)
            fundoJogo4.setScale(0.45)
            selecionou = true
            defaults.setInteger(1, forKey: "fundoEscolhido")
        }
        else if (fundoJogo3.containsPoint(touchLocation)){
            fundoJogo1.setScale(0.45)
            fundoJogo2.setScale(0.45)
            fundoJogo3.setScale(0.55)
            fundoJogo4.setScale(0.45)
            selecionou = true
            defaults.setInteger(2, forKey: "fundoEscolhido")
        }
        else if (fundoJogo4.containsPoint(touchLocation)){
            fundoJogo1.setScale(0.45)
            fundoJogo2.setScale(0.45)
            fundoJogo3.setScale(0.45)
            fundoJogo4.setScale(0.55)
            selecionou = true
            defaults.setInteger(3, forKey: "fundoEscolhido")
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