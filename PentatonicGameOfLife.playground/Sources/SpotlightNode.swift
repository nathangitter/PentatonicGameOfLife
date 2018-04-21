import SpriteKit

enum SpotlightPath {
    case right
    case left
}

class SpotlightNode: SKSpriteNode {
    
    public func move(path: SpotlightPath) {
        var bezierPath: UIBezierPath
        switch path {
        case .left:
            bezierPath = UIBezierPath(ovalIn: CGRect(x: -100, y: 80, width: 500, height: 200))
        case .right:
            bezierPath = UIBezierPath(ovalIn: CGRect(x: -600, y: -80, width: 500, height: 200))
            bezierPath = bezierPath.reversing()
        }
        let moveAction = SKAction.follow(bezierPath.cgPath, asOffset: false, orientToPath: false, duration: 6)
        moveAction.timingMode = path == .left ? .easeInEaseOut : .linear
        run(SKAction.repeatForever(moveAction))
    }
    
    public var isColorful = false {
        didSet {
            guard oldValue != isColorful else { return }
            if isColorful {
                let colorizeAction = SKAction.sequence(Rainbow.allColors.map { SKAction.colorize(with: $0, colorBlendFactor: 1, duration: 0.5) })
                run(SKAction.repeatForever(colorizeAction), withKey: colorActionKey)
            } else {
                removeAction(forKey: colorActionKey)
                color = .white
            }
        }
    }
    
    private let colorActionKey = "colorActionKey"
    
    init() {
        super.init(texture: SKTexture(imageNamed: "circle"), color: .white, size: CGSize(width: 200, height: 200))
        colorBlendFactor = 1
        alpha = 0.4
        pulse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func pulse() {
        let fadeInAction = SKAction.fadeAlpha(to: 0.6, duration: 0.5)
        let fadeOutAction = SKAction.fadeAlpha(to: 0.4, duration: 0.5)
        let fadeAction = SKAction.sequence([fadeInAction, fadeOutAction])
        run(SKAction.repeatForever(fadeAction))
    }
    
}
