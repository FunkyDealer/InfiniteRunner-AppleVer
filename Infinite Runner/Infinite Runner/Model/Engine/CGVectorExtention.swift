//
//  CGVectorExtention.swift
//  Infinite Runner
//
//  Created by intozoom on 5/22/21.
//

import Foundation
import GameplayKit


//addition with another vector
func +(left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx,dy: left.dy + right.dy)
}

//substraction with another vector
func -(left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

//Multiplication with anothe vector
func *(left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx * right.dx,dy: left.dy * right.dy)
}

//multiplication with a float
func *(left: CGVector, right: CGFloat) -> CGVector {
    return CGVector(dx: left.dx * right,dy: left.dy * right)
}

//division with another vector
func /(left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx / right.dx,dy: left.dy / right.dy)
}

//division with a float
func /(left: CGVector, right: CGFloat) -> CGVector {
    return CGVector(dx: left.dx / right,dy: left.dy / right)
}


extension CGVector {
    
    init(point : CGPoint) {
        self.init()
        self.dx = point.x
        self.dy = point.y
    }
    
    
    
    //Return the Length of the Vector2
    func Length() -> CGFloat {
        return sqrt((self.dx * self.dx) + (self.dy * self.dy))
    }
    
    //Normalizes the Vector2, making all Values Equal
    func Normalize() -> CGVector {
        let len = self.Length()
        if (len > 0) {
            return CGVector(dx: self.dx / len,dy: self.dy / len)
        } else {
            return self
        }
    }
    

    
    
}

