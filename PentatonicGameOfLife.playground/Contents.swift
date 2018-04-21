//: # Pentatonic Game of Life 🔬🎵
//: ## Interactive music generation based on Conway's game of life
//:
//: ### Instructions
//:
//: 1. Open the Assistant Editor (button in the top right).
//: 2. Click the "Play" button in the bottom left.
//:
//: ### About the Playground
//:
//: To start, click and drag to activate cells or choose from one of the presets.
//:
//: Every few seconds, the cells will form a new generation. This will add and remove cells according to the rules of the game of life (listed below).
//:
//: Try to create interesting patterns and music! There's no way to "win" the game, as it's just an interactive simulation. Have fun!
//:
//: ### Rules of Conway's Game of Life
//:
//: ![Rules of Conway's Game of Life](golrules.png)
//:
//: Conway's game of life is a cellular automaton that follows simple rules to create life-like patterns. The idea is that each cell can be "alive" or "dead" based on the number of surrounding cells.
//:
//: Each "generation", cells change state. They either stay the same, die, or come alive. This can create interesting patterns, shapes, and more!
//:
//: While it's called a "game", it's more of a simulation since there's no way to win or lose.
//:
//: ### Pentatonic Scale
//:
//: ![Diagram showing the pentatonic scale](pentatonic.png)
//:
//: A pentatonic tone matrix uses the pentatonic scale to create tones that sound pleasing.
//:
//: A pentatonic scale has 5 fives notes per octave, which is different from the traditional septatonic scale which has 7.
//:
//: In this case, we are using the notes "C, D, F, G, A" instead of the traditional "C, D, E, F, G, B, A".
//:
//: ### Special Effects
//:
//: Make sure to try the special effects! Try the rainbow effect, meow effect, and party effect! Or combine them all! 🌈😺🎉
//:
import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: CGRect(x: 0 , y: 0, width: 590, height: 840))
if let scene = GameScene(fileNamed: "GameScene") {
    scene.scaleMode = .aspectFill
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
