import SpriteKit

class ButtonNode: SKSpriteNode {
    
    // MARK: - Public API
    
    public var text: String = "" {
        didSet {
            labelNode.text = text
        }
    }
    
    public var action: () -> () = {}
    
    public func touchEffect() {
        let fadeInAction = SKAction.fadeAlpha(to: 0.5, duration: 0.05)
        let fadeBackAction = SKAction.fadeAlpha(to: 0.2, duration: 0.2)
        spriteNode.run(SKAction.sequence([fadeInAction, fadeBackAction]))
    }
    
    public let isSmall: Bool
    
    public var isSelected = false {
        didSet {
            spriteNode.alpha = isSelected ? 0.5 : 0.2
        }
    }
    
    // MARK: - Nodes
    
    private var spriteNode = SKSpriteNode(texture: nil, color: .white, size: .zero)
    private var labelNode = SKLabelNode()
    
    // MARK: - Constants
    
    private let normalSize = CGSize(width: 152, height: 36)
    private let smallSize = CGSize(width: 120, height: 36)
    
    // MARK: - Initialization
    
    init(isSmall: Bool = false) {
        self.isSmall = isSmall
        super.init(texture: nil, color: .clear, size: isSmall ? smallSize : normalSize)
        spriteNode.size = isSmall ? smallSize : normalSize
        spriteNode.texture = isSmall ? SKTexture(imageNamed: "buttonsmall") : SKTexture(imageNamed: "button")
        spriteNode.colorBlendFactor = 1
        spriteNode.alpha = 0.2
        spriteNode.isUserInteractionEnabled = false
        labelNode.fontName = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy).fontName
        labelNode.fontSize = 16
        labelNode.verticalAlignmentMode = .center
        addChild(spriteNode)
        addChild(labelNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.isSmall = false
        super.init(coder: aDecoder)
    }
    
}
