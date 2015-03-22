//
//  Texture.swift
//  IsoGame
//
//  Created by Abraham Brovold on 3/21/15.
//  Copyright (c) 2015 Abraham Brovold. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

func textureImage(tile:Tile, direction:Direction, action:Action) -> String {
    
    switch tile {
    case .Droid:
        switch action {
        case .Idle:
            switch direction {
            case .N:return "droid_n"
            case .NE:return "droid_ne"
            case .E:return "droid_e"
            case .SE:return "droid_se"
            case .S:return "droid_s"
            case .SW:return "droid_sw"
            case .W:return "droid_w"
            case .NW:return "droid_nw"
            }
        case .Move:
            switch direction {
            case .N:return "droid_n"
            case .NE:return "droid_ne"
            case .E:return "droid_e"
            case .SE:return "droid_se"
            case .S:return "droid_s"
            case .SW:return "droid_sw"
            case .W:return "droid_w"
            case .NW:return "droid_nw"
            }
        }
    case .Ground:
        return "ground"
    case .Wall:
        switch direction {
        case .N:return "wall_n"
        case .NE:return "wall_ne"
        case .E:return "wall_e"
        case .SE:return "wall_se"
        case .S:return "wall_s"
        case .SW:return "wall_sw"
        case .W:return "wall_w"
        case .NW:return "wall_nw"
        }
    }
    
}

protocol TextureObject {
    class var sharedInstance: TextureDroid {get}
    var texturesIso:[[SKTexture]?] {get}
    var textures2D:[[SKTexture]?] {get}
}

private let textureDroid = TextureDroid()

class TextureDroid: TextureObject  {
    
    class var sharedInstance: TextureDroid {
        return textureDroid
    }
    
    let texturesIso:[[SKTexture]?]
    let textures2D:[[SKTexture]?]
    
    init() {
        
        texturesIso = [[SKTexture]?](count: 2, repeatedValue: nil)
        textures2D = [[SKTexture]?](count: 2, repeatedValue: nil)
        
        //Idle
        texturesIso[Action.Idle.rawValue] = [
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.N, Action.Idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.NE, Action.Idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.E, Action.Idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.SE, Action.Idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.S, Action.Idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.SW, Action.Idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.W, Action.Idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.NW, Action.Idle)),
        ]
        
        //Move
        texturesIso[Action.Move.rawValue] = [
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.N, Action.Move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.NE, Action.Move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.E, Action.Move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.SE, Action.Move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.S, Action.Move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.SW, Action.Move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.W, Action.Move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.Droid, Direction.NW, Action.Move)),
        ]
        
        //Idle
        textures2D[Action.Idle.rawValue] = [
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.N, Action.Idle)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.NE, Action.Idle)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.E, Action.Idle)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.SE, Action.Idle)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.S, Action.Idle)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.SW, Action.Idle)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.W, Action.Idle)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.NW, Action.Idle)),
        ]
        
        //Move
        textures2D[Action.Move.rawValue] = [
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.N, Action.Move)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.NE, Action.Move)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.E, Action.Move)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.SE, Action.Move)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.S, Action.Move)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.SW, Action.Move)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.W, Action.Move)),
            SKTexture(imageNamed: textureImage(Tile.Droid, Direction.NW, Action.Move)),
        ]
        
    }
    
}