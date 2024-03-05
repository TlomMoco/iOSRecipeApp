
import Foundation
import SwiftUI

extension Color{
    public static var Primary: Color {
        return Color(UIColor(named: "Primary")!)
    }
    
    public static var Secondary: Color {
        return Color(UIColor(named: "Secondary")!)
    }
    
    public static var Tertiary: Color {
        return Color(UIColor(named: "Tertiary")!)
    }
    
    public static var Background: Color {
        return Color(UIColor(named: "Background")!)
    }
    
    public static var Text: Color {
        return Color(UIColor(named: "Text")!)
    }
}

extension UIColor {
    public static var Primary: UIColor {
        return UIColor(named: "Primary")!
    }
    
    public static var Secondary: UIColor {
        return UIColor(named: "Secondary")!
    }
    
    public static var Tertiary: UIColor {
        return UIColor(named: "Tertiary")!
    }
    
    public static var Background: UIColor {
        return UIColor(named: "Background")!
    }
    
    public static var Text: UIColor {
        return UIColor(named: "Text")!
    }
}
