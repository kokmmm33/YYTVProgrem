//
//  UIColor-Extension.swift
//  YYTV
//
//  Created by 蔡杰 on 2017/11/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    convenience init?(hex : String, alpha : CGFloat = 1) {
        guard hex.characters.count >= 6 else {
            return nil
        }
        
        var tempHex = hex.uppercased()
        
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        
        var range = NSMakeRange(0, 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        
        var r : Int32 = 0, g : Int32 = 0, b : Int32 = 0
        Scanner(string: rHex).scanInt32(&r)
        Scanner(string: gHex).scanInt32(&g)
        Scanner(string: bHex).scanInt32(&b)

        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), alpha: alpha)

    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
}
