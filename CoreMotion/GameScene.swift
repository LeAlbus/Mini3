//
//  GameScene.swift
//  CodeMotionExemplo
//
//  Created by Lucca Marmion on 22/06/15.
//  Copyright (c) 2015 LuccaMarmion. All rights reserved.
//

import SpriteKit
import CoreMotion
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Fundo
    var fundo : SKSpriteNode!
    var personagem : SKSpriteNode!
    
    let coreMotionManager = CMMotionManager()
    var yAxisAcceleration : CGFloat = 0.0
    
    let botaoPause = SKSpriteNode(imageNamed: "BtnPausar.png")
    let botaoContinuar = SKSpriteNode(imageNamed: "BtnContinuar.png")
    let botaoSair = SKSpriteNode(imageNamed: "BtnSair.png")
    let fundoEscurecido = SKSpriteNode(imageNamed: "FundoPausar.png")
    let fundoPause = SKSpriteNode(imageNamed: "BtnFundo.png")
    var pausado = false
    var som : Sons = Sons ()
    var a = true
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
    
        //Fisica do Mundo
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        
        som.musicaDeFundo()
        

//        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("addConsoante"), userInfo: nil, repeats: true)


        var timerVogal = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("addVogal"), userInfo: nil, repeats: true)
        
    
        FundoEscolhido()
        
        PersonagemEscolhido()
        
        botaoPause.position = CGPointMake(CGRectGetMidX(self.frame)+400,CGRectGetMidY(self.frame)+330)
        botaoPause.setScale(0.5)
        botaoPause.zPosition = 5
        addChild(botaoPause)

        coreMotionManager.accelerometerUpdateInterval = 0.4
        
        if (coreMotionManager.accelerometerAvailable) {
            coreMotionManager.startAccelerometerUpdatesToQueue(NSOperationQueue()) {
                (data, error) in
            
                if let constVar = error {
                    println("Erro no CoreMotion")
                }
                else {
                    if data.acceleration.y < 0
                    {
                        self.yAxisAcceleration = CGFloat(data!.acceleration.y)
                    }
                    else if data.acceleration.y > 0
                    {
                        self.yAxisAcceleration = CGFloat(data!.acceleration.y)
                    }
                }
            }
        }
    }
    
    override func didSimulatePhysics() {
        
        if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight
        {
            personagem!.physicsBody!.velocity = CGVectorMake(yAxisAcceleration * 700, 0)
        }
        else if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft
        {
            personagem!.physicsBody!.velocity = CGVectorMake(-yAxisAcceleration * 700, 0)
        }
        
        if personagem.position.x > size.width + 25 {
            personagem.position = CGPoint(x: -25, y: size.height / 2 - 300)
        }
        else if personagem.position.x < -25 {
            personagem.position = CGPoint(x: size.width + 25, y: size.height / 2 - 300)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var nodeB = contact.bodyB!.node!
        
        nodeB.removeFromParent()
    }
    
    func PersonagemEscolhido() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let a = defaults.integerForKey("personagem")
        
        if a == 0 {
            personagem = jogadorNode(size: CGSize(width: 100, height: 100), personagem: "AuAu")
        }
        else if a == 1{
            personagem = jogadorNode(size: CGSize(width: 100, height: 100), personagem: "Miau")
        }
        else if a == 2{
            personagem = jogadorNode(size: CGSize(width: 100, height: 100), personagem: "bolinha")
        }
        else if a == 3{
            personagem = jogadorNode(size: CGSize(width: 100, height: 100), personagem: "Bigodinho")
        }
        personagem.position = CGPoint(x: size.width / 2, y: size.height / 2 - 300)
        self.addChild(personagem!)
    }

    func FundoEscolhido(){
        let defaults = NSUserDefaults.standardUserDefaults()
        let b = defaults.integerForKey("fundoEscolhido")
        
        if b == 0 {
            self.fundo = SKSpriteNode(imageNamed: "Fundo2")
        }
        else if b == 1{
            self.fundo = SKSpriteNode(imageNamed: "fundo4")
        }
        else if b == 2{
            self.fundo = SKSpriteNode(imageNamed: "Fundo3")
        }
        else if b == 3{
            self.fundo = SKSpriteNode(imageNamed: "Fundo1")
        }
        
        fundo.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        fundo.xScale = 0.5
        fundo.yScale = 0.5
        self.addChild(fundo)
    }
    
    func pausar(){
        self.paused = true
        pausado = true
        som.audioPlayFundo.pause()
        fundoEscurecido.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        fundoEscurecido.setScale(0.5)
        fundoEscurecido.zPosition = 10
        fundoPause.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        fundoPause.setScale(0.5)
        fundoPause.zPosition = 11
        botaoContinuar.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)+80)
        botaoContinuar.setScale(0.5)
        botaoContinuar.zPosition = 11
        botaoSair.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-70)
        botaoSair.setScale(0.5)
        botaoSair.zPosition = 11
        self.addChild(fundoEscurecido)
        self.addChild(fundoPause)
        self.addChild(botaoContinuar)
        self.addChild(botaoSair)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        if(botaoPause.containsPoint(touchLocation)){
            som.playAudioBotoesGeral()
            pausar()
        }
        else if (botaoContinuar.containsPoint(touchLocation)){
            som.playAudioBotoesGeral()
            som.audioPlayFundo.play()
            self.paused = false
            pausado = false
            fundoEscurecido.removeFromParent()
            fundoPause.removeFromParent()
            botaoContinuar.removeFromParent()
            botaoSair.removeFromParent()
        }
        else if (botaoSair.containsPoint(touchLocation)){
            som.playAudioBotoesGeral()
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.09, target: self, selector: Selector("chamaMenu"), userInfo: nil, repeats: false)
        }
    }
    
    func chamaMenu(){
        som.audioPlayFundo.stop()
        let transition = SKTransition()
        let cenarioMenu = Menu(size: self.size)
        cenarioMenu.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioMenu, transition: transition)
    }
    
//    func addConsoante()
//    {
//        var sprite: String
//        let array=["b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z"]
//        
//        sprite = array[Int(arc4random_uniform(21))]
//        
//        var letra = Letras(size: CGSize(width: 70, height: 70), Letra: "\(sprite)")
//        self.addChild(letra)
//        letra.runLetraAction(size.height)
//        
//
//        
//    }
    
    func addVogal()
    {
        if a == true
        {
        var spriteVogal: String
        let arrayVogal=["a","e","i","o","u"]
        
        spriteVogal = arrayVogal[Int(arc4random_uniform(5))]
        
        var letraVogal = Letras(size: CGSize(width: 70, height: 70), Letra: "\(spriteVogal)")
        self.addChild(letraVogal)
        letraVogal.runLetraAction(size.height)
            self.a = false
        }
        else
        {
            var sprite: String
            let array=["b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z"]
            
            sprite = array[Int(arc4random_uniform(21))]
            
            var letra = Letras(size: CGSize(width: 70, height: 70), Letra: "\(sprite)")
            self.addChild(letra)
            letra.runLetraAction(size.height)
            self.a = true
        }
    }

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
