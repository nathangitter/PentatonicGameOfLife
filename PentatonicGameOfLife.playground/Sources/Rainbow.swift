import UIKit

struct Rainbow {
    
    private static let red = UIColor(hex: 0xFF3B3B)
    private static let redOrange = UIColor(hex: 0xFF723B)
    private static let orange = UIColor(hex: 0xFFA73B)
    private static let yellow = UIColor(hex: 0xFFDD3B)
    private static let lime = UIColor(hex: 0xB6FF3B)
    private static let mint = UIColor(hex: 0x3BFFA9)
    private static let sky = UIColor(hex: 0x3BFFF5)
    private static let blue = UIColor(hex: 0x3BBDFF)
    private static let darkBlue = UIColor(hex: 0x3B75FF)
    private static let purple = UIColor(hex: 0x803BFF)
    private static let velvet = UIColor(hex: 0xBC3BFF)
    private static let pink = UIColor(hex: 0xFF3BD0)
    
    static var allColors: [UIColor] {
        return [red, redOrange, orange, yellow, lime, mint, sky, blue, darkBlue, purple, velvet, pink]
    }
    
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255
        let g = CGFloat((hex & 0xFF00) >> 8) / 255
        let b = CGFloat((hex & 0xFF)) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
