//
//  Sons.swift
//  CoreMotion
//
//  Created by Gabriela  Gomes Pires on 31/07/15.
//  Copyright (c) 2015 LuccaMarmion. All rights reserved.
//

import Foundation
import AVFoundation

class Sons{
    
    var audioPlay = AVAudioPlayer()
    var audioPlayFundo = AVAudioPlayer()
   
    var botaoInicio = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("(BotãoInicio CC)317789__jalastram__sfx-powerup-21", ofType: "wav")!)
    var botaoGeral = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("(Botão CC)164703__mishicu__sfx-21-mo", ofType: "wav")!)
    var musicaFundo = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Kevin_MacLeod_-_Call_to_Adventure", ofType: "mp3")!)

    
    func playAudioBotaoInicio(){
        audioPlay = AVAudioPlayer(contentsOfURL: botaoInicio, error: nil)
        audioPlay.volume = 1.0
        audioPlay.play()
    }
    
    func playAudioBotoesGeral(){
        audioPlay = AVAudioPlayer(contentsOfURL: botaoGeral, error: nil)
        audioPlay.volume = 1.0
        audioPlay.play()
    }
    
    func musicaDeFundo(){
        audioPlayFundo = AVAudioPlayer(contentsOfURL: musicaFundo, error: nil)
        audioPlayFundo.volume = 1.0
        audioPlayFundo.play()
        audioPlayFundo.numberOfLoops = -1
    }
}