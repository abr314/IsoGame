//
//  GameScene.swift
//  IsoGame
//
//  Created by Abraham Brovold on 3/21/15.
//  Copyright (c) 2015 Abraham Brovold. All rights reserved.
//

import UIKit
import SpriteKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGPoint) -> CGPoint {
    return CGPoint(x: point.x * scalar.x, y: point.y * scalar.y)
}

func / (point: CGPoint, scalar: CGPoint) -> CGPoint {
    return CGPoint(x: point.x / scalar.x, y: point.y / scalar.y)
}


func distance(p1:CGPoint, p2:CGPoint) -> CGFloat {
    return CGFloat(hypotf(Float(p1.x) - Float(p2.x), Float(p1.y) - Float(p2.y)))
}

func round(point:CGPoint) -> CGPoint {
    return CGPoint(x: round(point.x), y: round(point.y))
}

func floor(point:CGPoint) -> CGPoint {
    return CGPoint(x: floor(point.x), y: floor(point.y))
}

func ceil(point:CGPoint) -> CGPoint {
    return CGPoint(x: ceil(point.x), y: ceil(point.y))
}

enum Direction: Int {
    
    case N,NE,E,SE,S,SW,W,NW
    
    var description:String {
        switch self {
        case N:return "North"
        case NE:return "North East"
        case E:return "East"
        case SE:return "South East"
        case S:return "South"
        case SW:return "South West"
        case W:return "West"
        case NW:return "North West"
        }
    }
}

enum Tile: Int {
    
    case Ground, Wall, Droid
    
    var description:String {
        switch self {
        case Ground:return "Ground"
        case Wall:return "Wall"
        case Droid:return "Droid"
        }
    }
}

enum Action: Int {
    case Idle, Move
    
    var description:String {
        switch self {
        case Idle:return "Idle"
        case Move:return "Move"
        }
    }
}



class GameScene: SKScene {
    
    
    // mandatory code which must be included when subclassing SKScene
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // top down view to easily see mapping coordinates in a simple 2D grid
    let view2D:SKSpriteNode
    // isometric view that will use for final game rendering
    let viewIso:SKSpriteNode
    
    let layerIsoGround:SKNode
    let layerIsoObjects:SKNode
    
    // nested arrat of ids that will be used to generate the tile map. 1 == wall. 0 == ground (walkable area)
    let tiles:[[(Int, Int)]]
    let tileSize = (width:32, height: 32)
    
    let hero = Droid()
    
    let nthFrame = 6
    var nthFrameCount = 0
    
    override init(size: CGSize) {
        
        tiles =     [[(1,7), (1,0), (1,0), (1,0), (1,0), (1,0), (1,1)]]
        tiles.append([(1,6), (0,0), (0,0), (0,0), (0,0), (0,0), (1,2)])
        tiles.append([(1,6), (0,0), (2,2), (0,0), (0,0), (0,0), (1,2)])
        tiles.append([(1,6), (0,0), (0,0), (1,5), (1,4), (1,4), (1,3)])
        tiles.append([(1,6), (0,0), (0,0), (0,0), (0,0), (0,0), (0,0)])
        tiles.append([(1,6), (0,0), (0,0), (0,0), (0,0), (0,0), (0,0)])
        tiles.append([(1,5), (1,4), (1,4), (1,4), (1,4), (1,4), (1,3)])
        
        view2D = SKSpriteNode()
        viewIso = SKSpriteNode()
        
        layerIsoGround = SKNode()
        layerIsoObjects = SKNode()
        
        super.init(size: size)
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        
    }
    
    //5
    override func didMoveToView(view: SKView) {
        
            
            let deviceScale = self.size.width/667
            
            view2D.position = CGPoint(x:-size.width*0.45, y:self.size.height*0.17)
            view2D.xScale = deviceScale
            view2D.yScale = deviceScale
            addChild(view2D)
            
            viewIso.position = CGPoint(x:self.size.width*0.12, y:self.size.height*0.12)
            viewIso.xScale = deviceScale
            viewIso.yScale = deviceScale
        
            viewIso.addChild(layerIsoGround)
            viewIso.addChild(layerIsoObjects)
        
            addChild(viewIso)
        
            placeAllTiles2D()
            placeAllTilesIso()
        }
    
    func placeTile2D(tile:Tile, direction:Direction, position:CGPoint) {
        
        let tileSprite = SKSpriteNode(imageNamed: textureImage(tile, direction, Action.Idle))
        
        if (tile == hero.tile) {
            hero.tileSprite2D = tileSprite
            hero.tileSprite2D.zPosition = 1
        }
        
        tileSprite.position = position
        
        tileSprite.anchorPoint = CGPoint(x:0, y:0)
        
        view2D.addChild(tileSprite)
        
    }
   
    func placeAllTiles2D() {
        
        for i in 0..<tiles.count {
            
            let row = tiles[i];
            
            for j in 0..<row.count {
                
                let tile = Tile(rawValue: row[j].0)!
                let direction = Direction(rawValue: row[j].1)!
                
                var point = CGPoint(x: (j*tileSize.width), y: -(i*tileSize.height))
                
                if (tile == Tile.Droid) {
                    placeTile2D(Tile.Ground, direction:direction, position:point)
                }
                
                placeTile2D(tile, direction:direction, position:point)
            }
            
        }       
    }

    func placeTileIso(tile:Tile, direction:Direction, position:CGPoint) {
        
        let tileSprite = SKSpriteNode(imageNamed: "iso_3d_"+textureImage(tile, direction, Action.Idle))
        
        if (tile == hero.tile) {
            hero.tileSpriteIso = tileSprite
        }
        
        tileSprite.position = position
        
        tileSprite.anchorPoint = CGPoint(x:0, y:0)
        
        if (tile == Tile.Ground) {
            layerIsoGround.addChild(tileSprite)
        } else if (tile == Tile.Wall || tile == Tile.Droid) {
            layerIsoObjects.addChild(tileSprite)
        }
        
    }
    
    func placeAllTilesIso() {
        
        for i in 0..<tiles.count {
            
            let row = tiles[i];
            
            for j in 0..<row.count {
                
                let tile = Tile(rawValue: row[j].0)!
                let direction = Direction(rawValue: row[j].1)!
                
                var point = point2DToIso(CGPoint(x: (j*tileSize.width), y: -(i*tileSize.height)))
                
                if (tile == Tile.Droid) {
                    placeTileIso(Tile.Ground, direction:direction, position:point)
                }
                
                placeTileIso(tile, direction:direction, position:point)
                
            }
        }
    }
    func point2DToIso(p:CGPoint) -> CGPoint {
        
        // invert y pre-conversion
        var point = p * CGPoint(x:1, y:-1)
        
        // convert using algorithm
        point = CGPoint(x:(point.x - point.y), y: ((point.x + point.y) / 2))
        
        // invert y post-conversion
        point = point * CGPoint(x:1, y:-1)
        
        return point
    }
    
    func pointIsoTo2D(p:CGPoint) -> CGPoint {
        
        // invert y pre-conversion
        var point = p * CGPoint(x:1, y:-1)
        
        // convert using algorithm
        point = CGPoint(x:((2 * point.y + point.x) / 2), y:  ((2 * point.y - point.x) / 2))
        
        // invert y post conversion
        point = point * CGPoint(x:1, y:-1)
        
        return point
    }
    
    func degreesToDirection(var degrees:CGFloat) -> Direction {
        
        if (degrees < 0) {
            degrees = degrees + 360
            }
        let directionRange = 45.0
        
        degrees = degrees + CGFloat(directionRange/2)
        
        var direction = Int(floor(Double(degrees)/directionRange))
        
        if (direction == 8) {
            direction = 0
        }
        
        return Direction(rawValue: direction)!
        
    }
    
    func sortDepth() {
        
        // runs a sort process on all the children in layerIsoObjects (e.g. the Wall and Droid tiles). The sorted function adds the x and y values of each isometric tile (once converted to the 2D coordinate space), the larger sum means the tile is closer to the player and should therefor be at a higher depth.
        let childrenSortedForDepth = layerIsoObjects.children.sorted() {
            
            let p0 = self.pointIsoTo2D($0.position)
            let p1 = self.pointIsoTo2D($1.position)
            
            if ((p0.x+(-p0.y)) > (p1.x+(-p1.y))) {
                return false
            } else {
                return true
            }
        }
        
        // assigns a depth to each child based on the position in childrenSortedForDepth
        for i in 0..<childrenSortedForDepth.count {
            
            let node = (childrenSortedForDepth[i] as SKNode)
            
            node.zPosition = CGFloat(i)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    
        // get touch location from isometric views
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(viewIso)
        
        // convert the point from isometric to 2D
        var touchPos2D = pointIsoTo2D(touchLocation)
        // adjust for the isometric tile anchor point offset
        touchPos2D = touchPos2D + CGPoint(x: tileSize.width/2, y: -tileSize.height/2)
        // adjust for the 2D hero tile anchor point offset.
        let heroPos2D = touchPos2D + CGPoint(x:-tileSize.width/2, y:-tileSize.height/2)
        
        // get the distance between the current position and the destination
        let deltaY = heroPos2D.y - hero.tileSprite2D.position.y
        let deltaX = heroPos2D.x - hero.tileSprite2D.position.x
        
        // use trigonometry to get the angle
        let degrees = atan2(deltaX, deltaY) * (180.0 / CGFloat(M_PI))
        
        // set hero facing
        hero.facing = degreesToDirection(degrees)
        
        // call update to sub in the texture based on "facing" direction
        hero.update()
        
        // Set the position of 2D hero tile
        let velocity = 100
        let time = NSTimeInterval(distance(heroPos2D, hero.tileSprite2D.position)/CGFloat(velocity))
        hero.tileSprite2D.removeAllActions()
        hero.tileSprite2D.runAction(SKAction.moveTo(heroPos2D, duration: time))
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        hero.tileSpriteIso.position = point2DToIso(hero.tileSprite2D.position)
        
        nthFrameCount += 1
        if (nthFrameCount == nthFrame) {
            nthFrameCount = 0
            updateOnNthFrame()
        }
    }
    
    func updateOnNthFrame() {
        sortDepth()
    }
}

