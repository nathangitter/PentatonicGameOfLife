import SpriteKit

public class GameScene: SKScene {
    
    // MARK: - Constants
    
    private let gridCount = 12
    private let cellSpacing: CGFloat = 38
    private let playDuration: TimeInterval = 2
    
    // MARK: - Nodes
    
    private let matrixNode = SKNode()
    private let buttonsNode = SKNode()
    private var toneNodes = [[ToneNode]]()
    private var titleNode = SKSpriteNode()
    private var descriptionLabel = SKLabelNode()
    private var leftSpotlightNode = SpotlightNode()
    private var rightSpotlightNode = SpotlightNode()
    private let rainEmitterNode = SKEmitterNode(fileNamed: "rain")!
    
    // MARK: - Steup
    
    public override func didMove(to view: SKView) {
        
        // set the background
        let backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "background"), color: .clear, size: size)
        addChild(backgroundNode)
        
        // fancy title
        titleNode = SKSpriteNode(texture: SKTexture(imageNamed: "logotype"), color: .clear, size: CGSize(width: 450, height: 40))
        titleNode.position = CGPoint(x: 0, y: 330)
        addChild(titleNode)
        
        // description label
        descriptionLabel.text = "Stable state — click cells or select a preset to continue the simulation."
        descriptionLabel.alpha = 0
        descriptionLabel.position = CGPoint(x: 0, y: -185)
        descriptionLabel.verticalAlignmentMode = .center
        descriptionLabel.fontSize = 12
        descriptionLabel.fontName = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.heavy).fontName
        addChild(descriptionLabel)
        
        // build the tone matrix
        for x in 0 ..< gridCount {
            var toneColumn = [ToneNode]()
            for y in 0 ..< gridCount {
                let toneNode = ToneNode()
                let offset = -CGFloat(gridCount) / 2 * cellSpacing + cellSpacing / 2
                toneNode.position = CGPoint(x: offset + CGFloat(x) * cellSpacing, y: offset + CGFloat(y) * cellSpacing)
                toneNode.row = y + 1
                matrixNode.addChild(toneNode)
                toneColumn.append(toneNode)
            }
            toneNodes.append(toneColumn)
        }
        
        // set up the matrix node
        matrixNode.position = CGPoint(x: 0, y: 54)
        addChild(matrixNode)
        
        // set up buttons
        buttonsNode.position = CGPoint(x: 0, y: -250)
        addChild(buttonsNode)
        
        let presetsLabelNode = SKLabelNode()
        presetsLabelNode.position = CGPoint(x: -184, y: 36)
        presetsLabelNode.verticalAlignmentMode = .center
        presetsLabelNode.text = "PRESETS"
        presetsLabelNode.fontSize = 16
        presetsLabelNode.fontName = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy).fontName
        buttonsNode.addChild(presetsLabelNode)
        
        let emptyButton = ButtonNode()
        emptyButton.position = CGPoint(x: -148, y: 0)
        emptyButton.text = "EMPTY"
        emptyButton.action = {
            self.resetPlaying()
            self.applyPreset(preset: Preset.empty)
            self.hideDescription()
        }
        buttonsNode.addChild(emptyButton)
        
        let heartButton = ButtonNode()
        heartButton.position = CGPoint(x: -148, y: -44)
        heartButton.text = "HEART"
        heartButton.action = {
            self.resetPlaying()
            self.applyPreset(preset: Preset.heart)
            self.hideDescription()
        }
        buttonsNode.addChild(heartButton)
        
        let gliderButton = ButtonNode()
        gliderButton.position = CGPoint(x: -148, y: -88)
        gliderButton.text = "GLIDER"
        gliderButton.action = {
            self.resetPlaying()
            self.applyPreset(preset: Preset.glider)
            self.hideDescription()
        }
        buttonsNode.addChild(gliderButton)
        
        let swiftButton = ButtonNode()
        swiftButton.position = CGPoint(x: 16, y: 0)
        swiftButton.text = "SWIFT"
        swiftButton.action = {
            self.resetPlaying()
            self.applyPreset(preset: Preset.swift)
            self.hideDescription()
        }
        buttonsNode.addChild(swiftButton)
        
        let randomButton = ButtonNode()
        randomButton.position = CGPoint(x: 16, y: -44)
        randomButton.text = "RANDOM"
        randomButton.action = {
            self.resetPlaying()
            self.applyPreset(preset: Preset.random)
            self.hideDescription()
        }
        buttonsNode.addChild(randomButton)
        
        let oscillatorButton = ButtonNode()
        oscillatorButton.position = CGPoint(x: 16, y: -88)
        oscillatorButton.text = "OSCILLATOR"
        oscillatorButton.action = {
            self.resetPlaying()
            self.applyPreset(preset: Preset.oscillator)
            self.hideDescription()
        }
        buttonsNode.addChild(oscillatorButton)
        
        let funLabelNode = SKLabelNode()
        funLabelNode.position = CGPoint(x: 142, y: 36)
        funLabelNode.verticalAlignmentMode = .center
        funLabelNode.text = "EFFECTS"
        funLabelNode.fontSize = 16
        funLabelNode.fontName = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy).fontName
        buttonsNode.addChild(funLabelNode)
        
        let colorButton = ButtonNode(isSmall: true)
        colorButton.position = CGPoint(x: 165, y: 0)
        colorButton.text = "🌈 COLORS"
        colorButton.action = {
            self.isRainbow = colorButton.isSelected
            self.updateEffects()
        }
        buttonsNode.addChild(colorButton)
        
        let meowButton = ButtonNode(isSmall: true)
        meowButton.position = CGPoint(x: 165, y: -44)
        meowButton.text = "😺 MEOWS"
        meowButton.action = {
            self.isMeow = meowButton.isSelected
            self.updateEffects()
        }
        buttonsNode.addChild(meowButton)
        
        let partyButton = ButtonNode(isSmall: true)
        partyButton.position = CGPoint(x: 165, y: -88)
        partyButton.text = "🎉 PARTY"
        partyButton.action = {
            self.isParty = partyButton.isSelected
            self.updateEffects()
        }
        buttonsNode.addChild(partyButton)
        
        // party effect nodes
        rightSpotlightNode = SpotlightNode()
        rightSpotlightNode.move(path: .right)
        rightSpotlightNode.isHidden = true
        addChild(rightSpotlightNode)
        
        leftSpotlightNode = SpotlightNode()
        leftSpotlightNode.move(path: .left)
        leftSpotlightNode.isHidden = true
        addChild(leftSpotlightNode)
        
        rainEmitterNode.position = CGPoint(x: 0, y: 400)
        rainEmitterNode.isHidden = true
        addChild(rainEmitterNode)
        
        // fancy scattered intro animation
        for toneColumn in toneNodes {
            for toneNode in toneColumn {
                let finalPosition = toneNode.position
                let randomOffset = CGFloat(20 + arc4random_uniform(200))
                let offsetAction = SKAction.moveBy(x: 0, y: -randomOffset, duration: 0)
                toneNode.run(offsetAction)
                toneNode.alpha = 0
                let randomDelay = 0.5 + Double(arc4random_uniform(20)) / 20
                let delayAction = SKAction.wait(forDuration: randomDelay)
                let introDuration = Double(randomOffset) / 200
                let moveAction = SKAction.move(to: finalPosition, duration: introDuration)
                let fadeAction = SKAction.fadeIn(withDuration: introDuration)
                let introAction = SKAction.group([moveAction, fadeAction])
                introAction.timingMode = .easeOut
                toneNode.run(SKAction.sequence([delayAction, introAction]))
            }
        }
        
        // load one of the presets
        applyPreset(preset: Preset.oscillator)
        
        // play the tones
        resetPlaying()
        
    }
    
    // MARK: - Logic
    
    private func resetPlaying() {
        let playActionKey = "playAction"
        removeAction(forKey: playActionKey)
        removeAction(forKey: "stepKey")
        toneNodes.forEach { $0.forEach { $0.reset() }}
        let delayAction = SKAction.wait(forDuration: playDuration + 0.2)
        let playTonesAction = SKAction.run { self.playTones() }
        let playAction = SKAction.repeatForever(SKAction.sequence([delayAction, playTonesAction]))
        run(playAction, withKey: playActionKey)
    }
    
    private func playTones() {
        
        // loop left -> right, playing tones
        for (index, toneColumn) in toneNodes.enumerated() {
            let delayAction = SKAction.wait(forDuration: Double(index) * playDuration / Double(gridCount))
            for toneNode in toneColumn {
                let playAction = SKAction.run {
                    if toneNode.isOn {
                        toneNode.play()
                        if toneNode.isCat {
                            self.playMeow(number: toneNode.row)
                        } else {
                            self.playTone(number: toneNode.row)
                        }
                    }
                }
                toneNode.run(SKAction.sequence([delayAction, playAction]))
            }
        }
        
        // at the end, make one step in game of life
        let waitAction = SKAction.wait(forDuration: playDuration)
        let stepAction = SKAction.run { self.stepGameOfLife() }
        run(SKAction.sequence([waitAction, stepAction]), withKey: "stepKey")
        
    }
    
    private var previousNeighbors = [[Int]]()
    
    private func stepGameOfLife() {
        
        // create a parallel array to track neighbors
        var neighbors = Array(repeating: Array(repeating: 0, count: toneNodes[0].count), count: toneNodes.count)
        
        // count the number of neighbors for each cell
        for (x, toneColumn) in toneNodes.enumerated() {
            for (y, _) in toneColumn.enumerated() {
                neighbors[x][y] = {
                    var count = 0
                    let nearIndexes = [
                        (x - 1, y - 1), (x, y - 1), (x + 1, y - 1),
                        (x - 1, y), (x + 1, y),
                        (x - 1, y + 1), (x, y + 1), (x + 1, y + 1),
                    ]
                    for (xIndex, yIndex) in nearIndexes {
                        if xIndex >= 0 && xIndex < toneNodes.count && yIndex >= 0 && yIndex < toneNodes[xIndex].count {
                            if toneNodes[xIndex][yIndex].isOn {
                                count += 1
                            }
                        }
                    }
                    return count
                }()
            }
        }
        
        // check for stable state
        if neighbors.reduce([], +) == previousNeighbors.reduce([], +) { showDescription() }
        previousNeighbors = neighbors
        
        // decide the fate of each cell
        for (x, toneColumn) in toneNodes.enumerated() {
            for (y, toneNode) in toneColumn.enumerated() {
                let numNeighbors = neighbors[x][y]
                if toneNode.isOn {
                    if numNeighbors < 2 || numNeighbors > 3 {
                        toneNode.die()
                    }
                } else {
                    if numNeighbors == 3 {
                        toneNode.birth()
                    }
                }
            }
        }
        
    }
    
    private func applyPreset(preset: [[Bool]]) {
        for (x, toneColumn) in toneNodes.enumerated() {
            for (y, toneNode) in toneColumn.enumerated() {
                toneNode.isOn = preset[x][y]
            }
        }
    }
    
    // MARK: - Effects :)
    
    private var isRainbow = false
    private var isMeow = false
    private var isParty = false
    
    private func updateEffects() {
        
        // rainbow effect
        titleNode.texture = isRainbow ? SKTexture(imageNamed: "logotype_rainbow") : SKTexture(imageNamed: "logotype")
        for toneColumn in toneNodes {
            for (index, toneNode) in toneColumn.enumerated() {
                toneNode.updateColor(to: isRainbow ? Rainbow.allColors.reversed()[index] : .white)
            }
        }
        leftSpotlightNode.isColorful = isRainbow
        rightSpotlightNode.isColorful = isRainbow
        if isRainbow {
            let times = (0 ..< Rainbow.allColors.count).map { Double($0) * 0.15 }
            rainEmitterNode.particleColorSequence = SKKeyframeSequence(keyframeValues: Rainbow.allColors, times: times as [NSNumber])
        } else {
            rainEmitterNode.particleColorSequence = SKKeyframeSequence(keyframeValues: [UIColor.white], times: [0])
        }
        
        // cat effect
        for toneColumn in toneNodes {
            for toneNode in toneColumn {
                toneNode.isCat = isMeow
            }
        }
        
        // party effect
        leftSpotlightNode.isHidden = !isParty
        rightSpotlightNode.isHidden = !isParty
        rainEmitterNode.isHidden = !isParty
        if isParty {
            let growAction = SKAction.scale(to: 1.1, duration: 0.4)
            let shrinkAction = SKAction.scale(to: 1, duration: 0.4)
            let pulseAction = SKAction.sequence([growAction, shrinkAction])
            titleNode.run(SKAction.repeatForever(pulseAction))
        } else {
            titleNode.removeAllActions()
            titleNode.run(SKAction.scale(to: 1, duration: 0))
        }
        
    }
    
    // MARK: - Helper Animations
    
    private func showDescription() {
        let showAction = SKAction.fadeIn(withDuration: 0.5)
        descriptionLabel.run(showAction)
    }
    
    private func hideDescription() {
        let hideAction = SKAction.fadeOut(withDuration: 0.5)
        descriptionLabel.run(hideAction)
    }
    
    // MARK: - Touches
    
    /// Whether the first tone touched was on.
    /// This dictates the behavior for the remainder of the gesture.
    private var isStartingSelectionOn = false
    
    private func touchDown(atPoint point: CGPoint) {
        if let toneNode = nodes(at: point).filter({ $0 is ToneNode }).first as? ToneNode {
            isStartingSelectionOn = toneNode.isOn
            toneNode.isOn = !isStartingSelectionOn
            hideDescription()
        }
    }
    
    private func touchMoved(toPoint point: CGPoint) {
        if let toneNode = nodes(at: point).filter({ $0 is ToneNode }).first as? ToneNode {
            toneNode.isOn = !isStartingSelectionOn
        }
    }
    
    private func touchUp(atPoint point: CGPoint) {
        if let buttonNode = nodes(at: point).filter({ $0 is ButtonNode }).first as? ButtonNode {
            if buttonNode.isSmall {
                buttonNode.isSelected = !buttonNode.isSelected
            } else {
                buttonNode.touchEffect()
            }
            buttonNode.action()
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    // MARK: - Sounds
    
    // keeping all sound actions in memory for better performance
    private let tone1Action = SKAction.playSoundFileNamed("tonematrix_1.wav", waitForCompletion: false)
    private let tone2Action = SKAction.playSoundFileNamed("tonematrix_2.wav", waitForCompletion: false)
    private let tone3Action = SKAction.playSoundFileNamed("tonematrix_3.wav", waitForCompletion: false)
    private let tone4Action = SKAction.playSoundFileNamed("tonematrix_4.wav", waitForCompletion: false)
    private let tone5Action = SKAction.playSoundFileNamed("tonematrix_5.wav", waitForCompletion: false)
    private let tone6Action = SKAction.playSoundFileNamed("tonematrix_6.wav", waitForCompletion: false)
    private let tone7Action = SKAction.playSoundFileNamed("tonematrix_7.wav", waitForCompletion: false)
    private let tone8Action = SKAction.playSoundFileNamed("tonematrix_8.wav", waitForCompletion: false)
    private let tone9Action = SKAction.playSoundFileNamed("tonematrix_9.wav", waitForCompletion: false)
    private let tone10Action = SKAction.playSoundFileNamed("tonematrix_10.wav", waitForCompletion: false)
    private let tone11Action = SKAction.playSoundFileNamed("tonematrix_11.wav", waitForCompletion: false)
    private let tone12Action = SKAction.playSoundFileNamed("tonematrix_12.wav", waitForCompletion: false)
    
    private let meow1Action = SKAction.playSoundFileNamed("Meow_1.wav", waitForCompletion: false)
    private let meow2Action = SKAction.playSoundFileNamed("Meow_2.wav", waitForCompletion: false)
    private let meow3Action = SKAction.playSoundFileNamed("Meow_3.wav", waitForCompletion: false)
    private let meow4Action = SKAction.playSoundFileNamed("Meow_4.wav", waitForCompletion: false)
    private let meow5Action = SKAction.playSoundFileNamed("Meow_5.wav", waitForCompletion: false)
    private let meow6Action = SKAction.playSoundFileNamed("Meow_6.wav", waitForCompletion: false)
    private let meow7Action = SKAction.playSoundFileNamed("Meow_7.wav", waitForCompletion: false)
    private let meow8Action = SKAction.playSoundFileNamed("Meow_8.wav", waitForCompletion: false)
    private let meow9Action = SKAction.playSoundFileNamed("Meow_9.wav", waitForCompletion: false)
    private let meow10Action = SKAction.playSoundFileNamed("Meow_10.wav", waitForCompletion: false)
    private let meow11Action = SKAction.playSoundFileNamed("Meow_11.wav", waitForCompletion: false)
    private let meow12Action = SKAction.playSoundFileNamed("Meow_12.wav", waitForCompletion: false)
    
    private var allToneActions: [SKAction] {
        return [tone1Action, tone2Action, tone3Action, tone4Action, tone5Action, tone6Action, tone7Action, tone8Action, tone9Action, tone10Action, tone11Action, tone12Action]
    }
    
    private var allMeowActions: [SKAction] {
        return [meow1Action, meow2Action, meow3Action, meow4Action, meow5Action, meow6Action, meow7Action, meow8Action, meow9Action, meow10Action, meow11Action, meow12Action]
    }
    
    private func playTone(number: Int) {
        run(allToneActions[number - 1])
    }
    
    private func playMeow(number: Int) {
        run(allMeowActions[number - 1])
    }
    
}
