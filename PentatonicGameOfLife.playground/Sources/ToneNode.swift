import SpriteKit

class ToneNode: SKSpriteNode {
    
    // MARK: - Pubilc API
    
    /// Whether the cell is currently alive.
    /// Updates the visual appearance of the node.
    public var isOn = false {
        didSet {
            spriteNode.alpha = isOn ? onAlpha : offAlpha
        }
    }
    
    /// The row of the cell. This is used to know which note to play.
    public var row: Int = 0
    
    /// Displays an animation alongside the tone playing.
    /// The actual sound effect is not handled in the `ToneNode` for performance reasons.
    public func play() {
        bounce()
        pulse()
    }
    
    /// Kills the cell with an animation.
    public func die() {
        isOn = false
        let extraNode = SKSpriteNode(texture: spriteNode.texture, color: spriteNode.color, size: spriteNode.size)
        extraNode.name = "extraNode"
        extraNode.colorBlendFactor = 1
        extraNode.alpha = onAlpha
        addChild(extraNode)
        let shrinkAction = SKAction.scale(to: 0, duration: 0.5)
        shrinkAction.timingMode = .easeInEaseOut
        let fadeAction = SKAction.fadeAlpha(to: 0, duration: 0.5)
        fadeAction.timingMode = .easeInEaseOut
        extraNode.run(SKAction.group([shrinkAction, fadeAction])) {
            extraNode.removeFromParent()
        }
    }
    
    /// Revives the cell with an animation.
    public func birth() {
        isOn = true
        spriteNode.alpha = offAlpha
        let extraNode = SKSpriteNode(texture: spriteNode.texture, color: spriteNode.color, size: spriteNode.size)
        extraNode.name = "extraNode"
        extraNode.colorBlendFactor = 1
        addChild(extraNode)
        extraNode.run(SKAction.scale(to: 0, duration: 0))
        let growAction = SKAction.scale(to: 1, duration: 0.5)
        growAction.timingMode = .easeInEaseOut
        let fadeAction = SKAction.fadeAlpha(to: onAlpha, duration: 0.5)
        fadeAction.timingMode = .easeInEaseOut
        extraNode.run(SKAction.group([growAction, fadeAction])) {
            extraNode.removeFromParent()
            self.spriteNode.alpha = self.onAlpha
        }
    }
    
    /// Resets the node. Useful to cancel any in-progress animations.
    public func reset() {
        childNode(withName: "extraNode")?.removeFromParent()
    }
    
    /// Updates the color of the node.
    public func updateColor(to color: UIColor) {
        spriteNode.color = color
    }
    
    /// `true` is the tone node is actually a cat! 😺
    public var isCat = false {
        didSet {
            spriteNode.texture = isCat ? SKTexture(imageNamed: "cat") : SKTexture(imageNamed: "tone")
        }
    }
    
    // MARK: - Constants
    
    private let onAlpha: CGFloat = 0.9
    private let offAlpha: CGFloat = 0.2
    
    // MARK: - Initialization
    
    private var spriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "tone"), color: .white, size: CGSize(width: 32, height: 32))
    
    init() {
        super.init(texture: nil, color: .clear, size: CGSize(width: 32, height: 32))
        spriteNode.colorBlendFactor = 1
        spriteNode.alpha = offAlpha
        addChild(spriteNode)
        addChild(pulseNode)
        pulseNode.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Animation
    
    private func bounce() {
        let scaleUpAction = SKAction.scale(to: 1.2, duration: 0.05)
        let scaleDownAction = SKAction.scale(to: 1, duration: 0.25)
        scaleDownAction.timingMode = SKActionTimingMode.easeOut
        let bounceAction = SKAction.sequence([scaleUpAction, scaleDownAction])
        spriteNode.run(bounceAction)
    }
    
    private var pulseNode = SKSpriteNode(texture: SKTexture(imageNamed: "pulse"), color: .white, size: CGSize(width: 32, height: 32))
    
    private func pulse() {
        pulseNode.run(SKAction.scale(to: 1, duration: 0))
        pulseNode.run(SKAction.fadeAlpha(to: 1, duration: 0))
        let growAction = SKAction.scale(to: 2, duration: 0.5)
        growAction.timingMode = .easeInEaseOut
        let fadeAction = SKAction.fadeAlpha(to: 0, duration: 0.5)
        fadeAction.timingMode = .easeInEaseOut
        pulseNode.run(SKAction.group([growAction, fadeAction]))
    }
    
}
