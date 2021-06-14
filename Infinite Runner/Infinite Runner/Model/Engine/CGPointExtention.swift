//
//  CGPointExtention.swift
//  Infinite Runner
//
//  Created by intozoom on 5/22/21.
//

import Foundation
import GameplayKit

//Sum with another Point
func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x,y: left.y + right.y)
}

//Sum with a Vector, vector on the right
func +(left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x + right.dx,y: left.y + right.dy)
}

//Sum with a Vector, vector on the left
func +(left: CGVector, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.dx + right.x,y: left.dy + right.y)
}

//Subtraction with another point
func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x,y: left.y - right.y)
}

//Subtraction with a vector
func -(left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x - right.dx,y: left.y - right.dy)
}

//Multiplication with another point
func *(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x,y: left.y * right.y)
}

//Multiplication with a vector
func *(left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x * right.dx,y: left.y * right.dy)
}

//multiplication with a float
func *(left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right,y: left.y * right)
}

//Division with another point
func /(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x,y: left.y / right.y)
}

//division with a vector
func /(left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x / right.dx,y: left.y / right.dy)
}

//division with a float
func /(left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right,y: left.y / right)
}


extension CGPoint {
    
    //initiate the point from the values of a point
    init(v : CGVector) {
        self.init()
        self.x = v.dx
        self.y = v.dy
    }
    
    //Return the Length of the point
    func Length() -> CGFloat {
        return sqrt((self.x * self.x) + (self.y * self.y))
    }
    
    //Normalizes the Point, making all Values Equal
    func Normalize() -> CGPoint {
        let len = self.Length()
        if (len > 0) {
            return CGPoint(x: self.x / len,y: self.y / len)
        } else {
            return self
        }
    }
    

}
