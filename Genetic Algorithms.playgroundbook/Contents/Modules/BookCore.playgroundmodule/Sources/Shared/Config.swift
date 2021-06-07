//
//  Config.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 09/04/21.
//

import SpriteKit

class Config {
    
    public static let debugMode: Bool = false
    
    public static let maxWidth: CGFloat = 900.0
    
    public static func getFullWidth(withBounds bounds: CGRect, withMargins: Bool = true) -> CGFloat {
        if withMargins {
            return bounds.width >= maxWidth ? maxWidth - 50 : bounds.width - 50
        } else {
            return bounds.width >= maxWidth ? maxWidth : bounds.width
        }
    }
    
    public static func setUpFonts() {
        var fontURL = Bundle.main.url(forResource: "Montserrat-Bold", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
        
        fontURL = Bundle.main.url(forResource: "Montserrat-Regular", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
    }
    
}

extension CGRect {
    
    public var boundTop: CGFloat {
        return self.height/2
    }
    
    public var boundBottom: CGFloat {
        return -self.height/2
    }
    
    public var boundRight: CGFloat {
        return self.width/2
    }
    
    public var boundLeft: CGFloat {
        return -self.width/2
    }
    
}

extension SKNode {
    
    public var widthOffset: CGFloat {
        return self.frame.width/2
    }
    
    public var heightOffset: CGFloat {
        return self.frame.height/2
    }
    
}
