import SpriteKit

class GameViewController: UIViewController {
    
    var scene: Menu!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 1. Configure the main view
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // 2. Create and configure our game scene
        scene = Menu(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        // 3. Show the scene.
        skView.presentScene(scene)
    }
}