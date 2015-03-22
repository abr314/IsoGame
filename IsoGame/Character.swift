//
//  Character.swift
//  IsoGame
//
//  Created by Abraham Brovold on 3/21/15.
//  Copyright (c) 2015 Abraham Brovold. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

// all complex tile object conform to this protocol. Once instantiated constant tile will be used as a shortcut for identification
protocol TileObject {
    var tile:Tile {get}
}

// stores characters current Direction and Action and tileSprite
class Character {
    
    var facing:Direction
    var action:Action
    
    var tileSprite2D:SKSpriteNode!
    var tileSpriteIso:SKSpriteNode!
    
    init() {
        facing = Direction.E
        action = Action.Idle
    }
    
}

// subclasses character and conforms to TileObject protocol
class Droid:Character, TileObject {
    
    let tile = Tile.Droid
    
    func update() {
        
        if (self.tileSpriteIso != nil) {
            
            self.tileSpriteIso.texture = TextureDroid.sharedInstance.texturesIso[self.action.rawValue]![self.facing.rawValue]
        }
    }
}